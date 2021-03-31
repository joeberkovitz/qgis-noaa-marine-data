import os
import math
from datetime import *
import requests
import xml.etree.ElementTree as ET

from qgis.core import (
    QgsPointXY, QgsPoint, QgsFeature, QgsGeometry, QgsField, QgsFields,
    QgsProject, QgsUnitTypes, QgsWkbTypes, QgsCoordinateTransform,
    QgsLineString, QgsDistanceArea, QgsPalLayerSettings,
    QgsLabelLineSettings, QgsVectorLayer, QgsVectorLayerSimpleLabeling)

from qgis.core import (
    QgsProcessing,
    QgsProcessingAlgorithm,
    QgsProcessingLayerPostProcessorInterface,
    QgsProcessingFeedback,
    QgsProcessingParameterBoolean,
    QgsProcessingParameterDateTime,
    QgsProcessingParameterNumber,
    QgsProcessingParameterEnum,
    QgsProcessingParameterFeatureSource,
    QgsProcessingParameterField,
    QgsProcessingParameterExtent,
    QgsProcessingParameterFeatureSink)

from qgis.PyQt.QtGui import QIcon, QColor
from qgis.PyQt.QtCore import QVariant, QUrl

from .utils import *

class AddStationLayersAlgorithm(QgsProcessingAlgorithm):
    PrmOnlyShallowestStations = 'OnlyShallowestStations'
    PrmCurrentStationsLayer = 'CurrentStationsLayer'

# boilerplate methods
    def name(self):
        return 'addstationlayers'

    def displayName(self):
        return tr('Add Station Layers')

    def helpUrl(self):
        return ''

    def createInstance(self):
        return AddStationLayersAlgorithm()

    # Set up this algorithm
    def initAlgorithm(self, config):
        self.addParameter(
            QgsProcessingParameterBoolean(
                self.PrmOnlyShallowestStations,
                tr('Use only stations nearest the surface'),
                True)
        )
        self.addParameter(
            QgsProcessingParameterFeatureSink(
                self.PrmCurrentStationsLayer,
                tr('Current stations output layer'))
        )
        self.feedback = QgsProcessingFeedback()

    def processAlgorithm(self, parameters, context, feedback):
        self.context = context
        self.feedback = feedback
        self.parameters = parameters

        return self.getCurrentStations()

    def getCurrentStations(self):
        self.feedback.pushInfo("Requesting metadata for NOAA current stations...")
        url = 'https://api.tidesandcurrents.noaa.gov/mdapi/prod/webapi/stations.xml?type=currentpredictions&expand=currentpredictionoffsets'
        r = requests.get(url, timeout=30)
        if r.status_code != 200:
            self.reportError('Failed with status {}'.format(r.status_code), True)
            return

        self.onlyShallowest = self.parameterAsBool(self.parameters, self.PrmOnlyShallowestStations, self.context)

        content = r.text
        if len(content) == 0:
            return

        self.feedback.pushInfo('Read {} bytes'.format(len(content)))

        # obtain our current stations output sink          
        fields = QgsFields()
        fields.append(QgsField("id_bin", QVariant.String,'',16))
        fields.append(QgsField("id", QVariant.String,'',12))
        fields.append(QgsField("bin", QVariant.String,'',4))
        fields.append(QgsField("name", QVariant.String))
        fields.append(QgsField("depth",  QVariant.Double))
        fields.append(QgsField("depthType",  QVariant.String, '', 1))
        fields.append(QgsField("type", QVariant.String,'',1))
        fields.append(QgsField("timezone_offset", QVariant.Double))
        fields.append(QgsField("refStationId", QVariant.String,'',12))
        fields.append(QgsField("refStationBin", QVariant.String,'',12))
        fields.append(QgsField("meanFloodDir", QVariant.Double))
        fields.append(QgsField("meanEbbDir", QVariant.Double))
        fields.append(QgsField("mfcTimeAdjMin", QVariant.Double))
        fields.append(QgsField("sbeTimeAdjMin", QVariant.Double))
        fields.append(QgsField("mecTimeAdjMin", QVariant.Double))
        fields.append(QgsField("sbfTimeAdjMin", QVariant.Double))
        fields.append(QgsField("mfcAmpAdj", QVariant.Double))
        fields.append(QgsField("mecAmpAdj", QVariant.Double))

        (currentSink, current_dest_id) = self.parameterAsSink(
            self.parameters, self.PrmCurrentStationsLayer, self.context, fields,
            QgsWkbTypes.Point, epsg4326)

        # This script converts a stations XML result obtained from this URL:
        # https://api.tidesandcurrents.noaa.gov/mdapi/prod/webapi/stations.xml?type=currentpredictions&expand=currentpredictionoffsets
        # by including only the bin of minimum depth for each station and eliminating weak/variable stations.
        # The flood and ebb directions are captured from the metadata also.
        self.feedback.pushInfo("Parsing metadata...")

        # Parse the XML file into a DOM up front
        xmlparse = ET.fromstring(content) 

        # Get the list of stations
        root = xmlparse
        stations = root.findall('Station')

        # Get a map that will track the metadata for the least-depth bin for each station.
        # Also maintain a map by id_bin key.
        stationMap = {}
        stationsByIdBin = {}

        # Loop over all stations and index them. If filtering for shallowest at each location,
        # maintain the minimum depth station for each id in stationMap.
        for s in stations: 
            stationId = s.find('id').text
            stationBin = s.find('currbin').text

            # Skip weak/variable type stations
            if s.find('type').text == 'W':
                continue

            stationsByIdBin[stationId + '_' + stationBin] = s

            if self.onlyShallowest:
                # If we find that we already saw this station, check its depth and only update the station map
                # if the newly found bin is shallower
                lastStation = stationMap.get(stationId)
                if lastStation and lastStation.find('depth').text and s.find('depth').text:
                    lastDepth = float(lastStation.find('depth').text)
                    newDepth = float(s.find('depth').text)
                    if newDepth >= lastDepth:
                        continue

                stationMap[stationId] = s

        if self.context.willLoadLayerOnCompletion(current_dest_id):
            self.context.layerToLoadOnCompletionDetails(current_dest_id).setPostProcessor(CurrentStylePostProcessor.create(self))

        # Now build the features for all stations in the map.

        progress_count = 0

        if self.onlyShallowest:
            iterMap = stationMap
        else:
            iterMap = stationsByIdBin

        for key in iterMap:
            s = iterMap[key]
            cpo = s.find('currentpredictionoffsets')

            f = QgsFeature(fields)

            geom = QgsGeometry(QgsPoint(float(s.find('lng').text), float(s.find('lat').text)))
            f.setGeometry(geom)

            f['id'] = s.find('id').text
            f['bin'] = s.find('currbin').text
            f['id_bin'] = f['id'] + '_' + f['bin']
            f['name'] = s.find('name').text
            f['type'] = s.find('type').text
            f['depth'] = parseFloatNullable(s.find('depth').text)
            f['depthType'] = s.find('depthType').text

            f['refStationId'] = cpo.find('refStationId').text
            f['refStationBin'] = cpo.find('refStationBin').text

            tz = parseFloatNullable(s.find('timezone_offset').text)
            if not tz:
                refStation = stationsByIdBin.get(f['refStationId'] + '_' + f['refStationBin'])
                if refStation:
                    tz = parseFloatNullable(refStation.find('timezone_offset').text)
            f['timezone_offset'] = tz

            f['meanFloodDir'] = parseFloatNullable(cpo.find('meanFloodDir').text)
            f['meanEbbDir'] = parseFloatNullable(cpo.find('meanEbbDir').text)
            f['mfcTimeAdjMin'] = parseFloatNullable(cpo.find('mfcTimeAdjMin').text)
            f['sbeTimeAdjMin'] = parseFloatNullable(cpo.find('sbeTimeAdjMin').text)
            f['mecTimeAdjMin'] = parseFloatNullable(cpo.find('mecTimeAdjMin').text)
            f['sbfTimeAdjMin'] = parseFloatNullable(cpo.find('sbfTimeAdjMin').text)
            f['mfcAmpAdj'] = parseFloatNullable(cpo.find('mfcAmpAdj').text)
            f['mecAmpAdj'] = parseFloatNullable(cpo.find('mecAmpAdj').text)

            currentSink.addFeature(f)

            progress_count += 1
            self.feedback.setProgress(100*progress_count/len(stationMap))
 
        return {self.PrmCurrentStationsLayer: current_dest_id}


class CurrentStylePostProcessor(QgsProcessingLayerPostProcessorInterface):
    instance = None

    def __init__(self, proc):
        super(CurrentStylePostProcessor, self).__init__()
        self.processor = proc

    def postProcessLayer(self, layer, context, feedback):
        if not isinstance(layer, QgsVectorLayer):
            return

        # style the output layer here
        layer.setName(tr('Current Stations'))
        layer.loadNamedStyle(os.path.join(os.path.dirname(__file__),'styles','current_stations.qml'))
        layer.triggerRepaint()

        # set up the project variable pointing to it
        QgsProject.instance().setCustomVariables({CurrentStationsLayerVar: layer.id()})

    @staticmethod
    def create(proc) -> 'CurrentStylePostProcessor':
        CurrentStylePostProcessor.instance = CurrentStylePostProcessor(proc)
        return CurrentStylePostProcessor.instance

