import os
import math
from datetime import *
import requests
import xml.etree.ElementTree as ET

from qgis.core import (
    QgsPointXY, QgsPoint, QgsFeature, QgsGeometry, QgsField, QgsFields,
    QgsProject, QgsUnitTypes, QgsWkbTypes, QgsCoordinateTransform,
    QgsLineString, QgsDistanceArea, QgsVectorLayer, QgsVectorLayerJoinInfo, QgsMemoryProviderUtils)

from qgis.core import (
    QgsProcessing,
    QgsProcessingAlgorithm,
    QgsProcessingLayerPostProcessorInterface,
    QgsProcessingException,
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
from .time_zone_lookup import TimeZoneLookup

class AddCurrentStationsLayerAlgorithm(QgsProcessingAlgorithm):
    PrmCurrentStationsLayer = 'CurrentStationsLayer'
# boilerplate methods
    def name(self):
        return 'addcurrentstationslayer'

    def displayName(self):
        return tr('Add Current Stations Layer')

    def helpUrl(self):
        return ''

    def createInstance(self):
        return AddCurrentStationsLayerAlgorithm()

    # Set up this algorithm
    def initAlgorithm(self, config):
        self.addParameter(
            QgsProcessingParameterFeatureSink(
                self.PrmCurrentStationsLayer,
                tr('Current stations output layer'),
                QgsProcessing.TypeVectorPoint,
                os.path.join(layerStoragePath(), 'current_stations.gpkg'))
        )
        self.feedback = QgsProcessingFeedback()

    def processAlgorithm(self, parameters, context, feedback):
        self.context = context
        self.feedback = feedback
        self.parameters = parameters

        try:
            os.mkdir(layerStoragePath())
        except FileExistsError:
            pass

        current_dest_id = self.getCurrentStations()

        return {
            self.PrmCurrentStationsLayer: current_dest_id
        }

    def baseStationFields(self):
        fields = QgsFields()
        fields.append(QgsField("station", QVariant.String,'', 16))
        fields.append(QgsField("id", QVariant.String,'', 12))
        fields.append(QgsField("name", QVariant.String))
        fields.append(QgsField("type", QVariant.String,'',1))
        fields.append(QgsField("timeZoneId", QVariant.String, '', 32))
        fields.append(QgsField("timeZoneUTC", QVariant.String, '', 32))
        fields.append(QgsField("refStation", QVariant.String,'', 12))
        return fields

    def basePredictionFields(self):
        fields = QgsFields()
        fields.append(QgsField("station", QVariant.String,'',16))
        fields.append(QgsField("depth",  QVariant.Double))
        fields.append(QgsField("time",  QVariant.DateTime))
        fields.append(QgsField("value", QVariant.Double))  # signed value, on flood/ebb dimension for current
        fields.append(QgsField("type", QVariant.String))
        return fields

    def currentPredictionFields(self):
        fields = self.basePredictionFields()
        fields.append(QgsField("dir", QVariant.Double))
        fields.append(QgsField("magnitude", QVariant.Double))  # value along direction if known
        return fields

    def getCurrentStations(self):
        if currentStationsLayer() != None or currentPredictionsLayer() != None:
            raise QgsProcessingException(tr('Existing current layers must be removed before creating new ones.'))

        self.feedback.pushInfo("Requesting metadata for NOAA current stations...")
        url = 'https://api.tidesandcurrents.noaa.gov/mdapi/prod/webapi/stations.xml?type=currentpredictions&expand=currentpredictionoffsets'
        r = requests.get(url, timeout=30)
        if r.status_code != 200:
            raise QgsProcessingException(tr('Request failed with status {}').format(r.status_code))

        content = r.text
        if len(content) == 0:
            return

        self.feedback.pushInfo('Read {} bytes'.format(len(content)))

        # obtain our current stations output sink          
        fields = self.baseStationFields()
        fields.append(QgsField("bin", QVariant.String,'', 4))
        fields.append(QgsField("depth",  QVariant.Double))
        fields.append(QgsField("depthType",  QVariant.String, '', 1))
        fields.append(QgsField("surface", QVariant.Int))
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
        # Also maintain a map by station key.
        surfaceMap = {}
        stationMap = {}

        # Loop over all stations and index them. If filtering for shallowest at each location,
        # maintain the minimum depth station for each id in surfaceMap.
        for s in stations: 
            stationId = s.find('id').text
            stationBin = s.find('currbin').text

            # Skip weak/variable type stations
            if s.find('type').text == 'W':
                continue

            stationMap[stationId + '_' + stationBin] = s

            # If we find that we already saw this station, check its depth and only update the station map
            # if the newly found bin is shallower
            lastStation = surfaceMap.get(stationId)
            if lastStation and lastStation.find('depth').text and s.find('depth').text:
                lastDepth = float(lastStation.find('depth').text)
                newDepth = float(s.find('depth').text)
                if newDepth >= lastDepth:
                    continue

            surfaceMap[stationId] = s

        if self.context.willLoadLayerOnCompletion(current_dest_id):
            proc = CurrentStationsStylePostProcessor.create(
                tr('Current Stations'), 'current_stations.qml',
                tr('Current Predictions'), 'current_predictions.qml',
                self.currentPredictionFields()
            )
            self.context.layerToLoadOnCompletionDetails(current_dest_id).setPostProcessor(proc)

        # Now build the features for all stations in the map.

        progress_count = 0

        tzl = TimeZoneLookup()

        for key, s in stationMap.items():
            cpo = s.find('currentpredictionoffsets')

            f = QgsFeature(fields)

            lng = float(s.find('lng').text)
            lat = float(s.find('lat').text)
            geom = QgsGeometry(QgsPoint(lng, lat))
            f.setGeometry(geom)

            f['station'] = key
            f['id'] = s.find('id').text
            f['bin'] = s.find('currbin').text
            f['name'] = s.find('name').text
            f['type'] = s.find('type').text
            f['depth'] = parseFloatNullable(s.find('depth').text)
            f['depthType'] = s.find('depthType').text

            f['surface'] = 1 if surfaceMap.get(f['id']) == s else 0

            refStationId = cpo.find('refStationId').text
            if refStationId:
                f['refStation'] = refStationId + '_' + cpo.find('refStationBin').text

            (f['timeZoneId'], f['timeZoneUTC']) = tzl.getZoneByCoordinates(lat, lng)

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
 
        return current_dest_id

class StylePostProcessor(QgsProcessingLayerPostProcessorInterface):
    def __init__(self, layerName, styleName,
                 predictionLayerName, predictionStyleName,
                 predictionFields):
        super(StylePostProcessor, self).__init__()
        self.layerName = layerName
        self.styleName = styleName
        self.predictionLayerName = predictionLayerName
        self.predictionStyleName = predictionStyleName
        self.predictionFields = predictionFields

    def postProcessLayer(self, layer, context, feedback):
        # style the output layer here
        layer.setName(self.layerName)
        layer.loadNamedStyle(os.path.join(os.path.dirname(__file__),'styles',self.styleName))
        layer.triggerRepaint()

        predictionLayer = QgsMemoryProviderUtils.createMemoryLayer(
            self.predictionLayerName, self.predictionFields, QgsWkbTypes.Point, epsg4326
        )
        QgsProject.instance().addMapLayer(predictionLayer)

        # add a join to the station layer from which  predictions were derived

        joinInfo = QgsVectorLayerJoinInfo()
        joinInfo.setJoinLayer(layer)
        joinInfo.setTargetFieldName('station')
        joinInfo.setJoinFieldName('station')
        joinInfo.setJoinFieldNamesSubset(['name','timeZoneId','timeZoneUTC'])
        joinInfo.setPrefix('station_')
        predictionLayer.addJoin(joinInfo)
        predictionLayer.updateFields()

        predictionLayer.loadNamedStyle(os.path.join(os.path.dirname(__file__),'styles',self.predictionStyleName))

        # set up custom variables identifying the added layers
        layer.setCustomProperty(NOAA_LAYER_TYPE, CurrentStationsLayerType)
        predictionLayer.setCustomProperty(NOAA_LAYER_TYPE, CurrentPredictionsLayerType)

class CurrentStationsStylePostProcessor(StylePostProcessor):
    instance = None

    @staticmethod
    def create(layerName, styleName,
               predictionLayerName, predictionStyleName,
               predictionFields) -> 'CurrentStationsStylePostProcessor':
        CurrentStationsStylePostProcessor.instance = CurrentStationsStylePostProcessor(
            layerName, styleName,
            predictionLayerName, predictionStyleName,
            predictionFields
        )
        return CurrentStationsStylePostProcessor.instance

