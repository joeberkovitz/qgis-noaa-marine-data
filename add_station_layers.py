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
        r = requests.get(url)
        if r.status_code != 200:
            self.reportError('Failed with status {}'.format(r.status_code), True)
            return

        content = r.text
        if len(content) == 0:
            return

        self.feedback.pushInfo('Read {} bytes'.format(len(content)))

        # This script converts a stations XML result obtained from this URL:
        # https://api.tidesandcurrents.noaa.gov/mdapi/prod/webapi/stations.xml?type=currentpredictions&expand=currentpredictionoffsets
        # by including only the bin of minimum depth for each station and eliminating weak/variable stations.
        # The flood and ebb directions are captured from the metadata also.
        self.feedback.pushInfo("Parsing metadata...")

        # Parse the XML file into a DOM up front
        xmlparse = ET.fromstring(content) 

        # Get the list of stations
        root = xmlparse #.getroot() 
        stations = root.findall('Station')

        # Get a map that will track the metadata for the least-depth bin for each station
        stationMap = {}

        # Loop over all stations finding the minimum depth and eliminating skippable ones.
        for s in stations: 
            stationId = s.find('id').text

            # Skip weak/variable type stations
            if s.find('type').text == 'W':
                continue

            # If we find that we already saw this station, check its depth and only update the station map
            # if the newly found bin is shallower
            lastStation = stationMap.get(stationId)
            if lastStation and lastStation.find('depth').text and s.find('depth').text:
                lastDepth = float(lastStation.find('depth').text)
                newDepth = float(s.find('depth').text)
                if newDepth >= lastDepth:
                    continue

            stationMap[stationId] = s

        # obtain our current stations output sink          
        fields = QgsFields()
        fields.append(QgsField("id_bin", QVariant.String,'',16))
        fields.append(QgsField("id", QVariant.String,'',12))
        fields.append(QgsField("name", QVariant.String))
        fields.append(QgsField("depth",  QVariant.Double))
        fields.append(QgsField("depthType",  QVariant.String, '', 1))
        fields.append(QgsField("type", QVariant.String,'',1))
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

        if self.context.willLoadLayerOnCompletion(current_dest_id):
            self.context.layerToLoadOnCompletionDetails(current_dest_id).setPostProcessor(CurrentStylePostProcessor.create(self))

        # Now build the features for all stations in the map.

        for stationId in stationMap:
            s = stationMap[stationId]
            cpo = s.find('currentpredictionoffsets')

            f = QgsFeature(fields)

            geom = QgsGeometry(QgsPoint(float(s.find('lng').text), float(s.find('lat').text)))
            f.setGeometry(geom)

            f['id'] = s.find('id').text
            f['id_bin'] = f['id'] + '_' + s.find('currbin').text
            f['name'] = s.find('name').text
            f['type'] = s.find('type').text
            if s.find('depth'):
                f['depth'] = float(s.find('depth').text)
            f['depthType'] = s.find('depthType').text

            f['refStationId'] = cpo.find('refStationId').text
            f['refStationBin'] = cpo.find('refStationBin').text

            f['meanFloodDir'] = self.parseFloatNullable(cpo.find('meanFloodDir').text)
            f['meanEbbDir'] = self.parseFloatNullable(cpo.find('meanEbbDir').text)
            f['mfcTimeAdjMin'] = self.parseFloatNullable(cpo.find('mfcTimeAdjMin').text)
            f['sbeTimeAdjMin'] = self.parseFloatNullable(cpo.find('sbeTimeAdjMin').text)
            f['mecTimeAdjMin'] = self.parseFloatNullable(cpo.find('mecTimeAdjMin').text)
            f['sbfTimeAdjMin'] = self.parseFloatNullable(cpo.find('sbfTimeAdjMin').text)
            f['mfcAmpAdj'] = self.parseFloatNullable(cpo.find('mfcAmpAdj').text)
            f['mecAmpAdj'] = self.parseFloatNullable(cpo.find('mecAmpAdj').text)

            currentSink.addFeature(f)
 
        return {self.PrmCurrentStationsLayer: current_dest_id}

    def parseFloatNullable(self, str):
        return float(str) if str else 0

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

    @staticmethod
    def create(proc) -> 'CurrentStylePostProcessor':
        CurrentStylePostProcessor.instance = CurrentStylePostProcessor(proc)
        return CurrentStylePostProcessor.instance

