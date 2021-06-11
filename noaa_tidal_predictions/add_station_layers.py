import os
import math
import re as re
from datetime import *

import requests
from requests.exceptions import MissingSchema

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
    QgsProcessingParameterFeatureSink,
    QgsProcessingParameterString)

from qgis.PyQt.QtGui import QIcon, QColor
from qgis.PyQt.QtCore import QVariant, QUrl

from .utils import *
from .time_zone_lookup import TimeZoneLookup

class AddStationsLayerAlgorithm(QgsProcessingAlgorithm):
    PrmCurrentStationsURI = 'CurrentMetadataURI'
    PrmTideStationsURI = 'TideMetadataURI'
    PrmStationsLayer = 'StationsLayer'
    PrmPredictionsLayer = 'PredictionsLayer'

# boilerplate methods
    def name(self):
        return 'addtidalstationslayer'

    def displayName(self):
        return tr('Add Tidal Stations Layer')

    def helpUrl(self):
        return ''

    def createInstance(self):
        return AddStationsLayerAlgorithm()

    # Set up this algorithm
    def initAlgorithm(self, config):
        self.addParameter(
            QgsProcessingParameterString(
                self.PrmTideStationsURI,
                tr('Tide stations URL or file'),
                'https://api.tidesandcurrents.noaa.gov/mdapi/prod/webapi/stations.xml?expand=tidepredoffsets&type=tidepredictions')
        )
        self.addParameter(
            QgsProcessingParameterString(
                self.PrmCurrentStationsURI,
                tr('Current stations URL or file'),
                'https://api.tidesandcurrents.noaa.gov/mdapi/prod/webapi/stations.xml?type=currentpredictions&expand=currentpredictionoffsets')
        )
        self.addParameter(
            QgsProcessingParameterFeatureSink(
                self.PrmStationsLayer,
                tr('Stations layer'),
                QgsProcessing.TypeVectorPoint,
                os.path.join(layerStoragePath(), 'stations.gpkg')
                )
        )
        self.addParameter(
            QgsProcessingParameterFeatureSink(
                self.PrmPredictionsLayer,
                tr('Predictions layer'),
                QgsProcessing.TypeVectorPoint,
                os.path.join(layerStoragePath(), 'predictions.gpkg')
                )
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

        stations_dest_id = self.getStations()
        predictions_dest_id = self.getPredictions()

        return {
            self.PrmStationsLayer: stations_dest_id,
            self.PrmPredictionsLayer: predictions_dest_id
        }

    def stationFields(self):
        fields = QgsFields()
        fields.append(QgsField("station", QVariant.String,'', 16))
        fields.append(QgsField("id", QVariant.String,'', 12))
        fields.append(QgsField("name", QVariant.String, '', 64))
        fields.append(QgsField("flags", QVariant.Int))
        fields.append(QgsField("bin", QVariant.String,'', 4))
        fields.append(QgsField("timeZoneId", QVariant.String, '', 32))
        fields.append(QgsField("timeZoneUTC", QVariant.String, '', 32))
        fields.append(QgsField("refStation", QVariant.String,'', 12))
        fields.append(QgsField("depth",  QVariant.Double))
        fields.append(QgsField("depthType",  QVariant.String, '', 1))
        fields.append(QgsField("meanFloodDir", QVariant.Double))
        fields.append(QgsField("meanEbbDir", QVariant.Double))
        fields.append(QgsField("maxTimeAdj", QVariant.Double))
        fields.append(QgsField("minTimeAdj", QVariant.Double))
        fields.append(QgsField("risingZeroTimeAdj", QVariant.Double))
        fields.append(QgsField("fallingZeroTimeAdj", QVariant.Double))
        fields.append(QgsField("maxValueAdj", QVariant.Double))
        fields.append(QgsField("minValueAdj", QVariant.Double))
        return fields

    def predictionFields(self):
        fields = QgsFields()
        fields.append(QgsField("station", QVariant.String,'',16))
        fields.append(QgsField("depth",  QVariant.Double))
        fields.append(QgsField("time",  QVariant.DateTime))
        fields.append(QgsField("value", QVariant.Double))  # signed value, on flood/ebb dimension for current
        fields.append(QgsField("flags", QVariant.Int))
        fields.append(QgsField("dir", QVariant.Double))
        fields.append(QgsField("magnitude", QVariant.Double))  # value along direction if known
        return fields

    def getPredictions(self):
        if getPredictionsLayer() != None:
            raise QgsProcessingException(tr('Existing tidal layers must be removed before creating new ones.'))

        (predictionsSink, predictions_dest_id) = self.parameterAsSink(
            self.parameters, self.PrmPredictionsLayer, self.context,
            self.predictionFields(),
            QgsWkbTypes.Point, epsg4326)

        if self.context.willLoadLayerOnCompletion(predictions_dest_id):
            proc = PredictionsStylePostProcessor.create(
                tr('Tidal Predictions'), 'predictions.qml', PredictionsLayerType
            )
            self.context.layerToLoadOnCompletionDetails(predictions_dest_id).setPostProcessor(proc)

        return predictions_dest_id

    def getMetadataTree(self, paramName):
        url = self.parameters[paramName]
        if url == '':
            return None

        content = ''
        try:
            r = requests.get(url, timeout=30)

            if r.status_code != 200:
                raise QgsProcessingException(tr('Request failed with status {}').format(r.status_code))

            content = r.text
        except MissingSchema:
            # if no schema present, treat it as a filename
            with open(url, 'r') as dataFile:
                content = dataFile.read()

        if content == '':
            return None

        self.feedback.pushInfo('Read {} bytes'.format(len(content)))

        # Work around heinous lack of entity escaping on & characters in station names.
        p = re.compile('&([^;]{1,10})')   # match any & not followed by a ; within 10 characters
        content = p.sub(r'&amp;\1', content)

        # parse into an element tree
        return ET.fromstring(content) 

    def getStations(self):
        if getStationsLayer() != None:
            raise QgsProcessingException(tr('Existing tidal layers must be removed before creating new ones.'))

        (stationSink, stations_dest_id) = self.parameterAsSink(
            self.parameters, self.PrmStationsLayer, self.context,
            self.stationFields(),
            QgsWkbTypes.Point, epsg4326)

        self.getTideStations(stationSink)
        self.getCurrentStations(stationSink)

        if self.context.willLoadLayerOnCompletion(stations_dest_id):
            proc = StationsStylePostProcessor.create(
                tr('Tidal Stations'), 'stations.qml', StationsLayerType
            )
            self.context.layerToLoadOnCompletionDetails(stations_dest_id).setPostProcessor(proc)
 
        return stations_dest_id

    def getTideStations(self, stationSink):
        self.feedback.pushInfo("Requesting metadata for NOAA tide stations...")
        xmlparse = self.getMetadataTree(self.PrmTideStationsURI)
        if xmlparse is None:
            return

        # Get the list of stations
        root = xmlparse
        stations = root.findall('Station')

        # Build the features for all stations in the map.

        progress_count = 0

        tzl = TimeZoneLookup()

        fields = self.stationFields()
        for s in stations: 
            tpo = s.find('tidepredoffsets')

            f = QgsFeature(fields)

            lng = float(s.find('lng').text)
            lat = float(s.find('lat').text)
            geom = QgsGeometry(QgsPoint(lng, lat))
            f.setGeometry(geom)

            f['station'] = f['id'] = s.find('id').text
            f['name'] = s.find('name').text

            stationType = s.find('type').text
            flags = StationFlags.Tide | StationFlags.Surface
            if stationType == 'R':
                flags |= StationFlags.Reference
            if tpo.find('heightAdjustedType').text == 'F':
                flags |= StationFlags.FixedAdj
            f['flags'] = flags
            f['refStation'] = tpo.find('refStationId').text
            (f['timeZoneId'], f['timeZoneUTC']) = tzl.getZoneByCoordinates(lat, lng)
            f['maxTimeAdj'] = parseFloatNullable(tpo.find('timeOffsetHighTide').text)
            f['minTimeAdj'] = parseFloatNullable(tpo.find('timeOffsetLowTide').text)
            f['maxValueAdj'] = parseFloatNullable(tpo.find('heightOffsetHighTide').text)
            f['minValueAdj'] = parseFloatNullable(tpo.find('heightOffsetLowTide').text)

            stationSink.addFeature(f)

            progress_count += 1
            self.feedback.setProgress(50*progress_count/len(stations))

    def getCurrentStations(self, stationSink):
        self.feedback.pushInfo("Requesting metadata for NOAA current stations...")
        xmlparse = self.getMetadataTree(self.PrmCurrentStationsURI)
        if xmlparse is None:
            return

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

        # Now build the features for all stations in the map.

        progress_count = 0

        tzl = TimeZoneLookup()

        fields = self.stationFields()
        for key, s in stationMap.items():
            cpo = s.find('currentpredictionoffsets')

            f = QgsFeature(fields)
            flags = StationFlags.Current

            lng = float(s.find('lng').text)
            lat = float(s.find('lat').text)
            geom = QgsGeometry(QgsPoint(lng, lat))
            f.setGeometry(geom)

            f['station'] = key
            f['id'] = s.find('id').text
            f['bin'] = s.find('currbin').text
            f['name'] = s.find('name').text

            f['depth'] = parseFloatNullable(s.find('depth').text)
            f['depthType'] = s.find('depthType').text

            stationType = s.find('type').text
            if stationType == 'H':
                flags |= StationFlags.Reference

            if surfaceMap.get(f['id']) == s:
                flags |= StationFlags.Surface
            f['flags'] = flags

            refStationId = cpo.find('refStationId').text
            if refStationId:
                f['refStation'] = refStationId + '_' + cpo.find('refStationBin').text

            (f['timeZoneId'], f['timeZoneUTC']) = tzl.getZoneByCoordinates(lat, lng)

            f['meanFloodDir'] = parseFloatNullable(cpo.find('meanFloodDir').text)
            f['meanEbbDir'] = parseFloatNullable(cpo.find('meanEbbDir').text)
            f['maxTimeAdj'] = parseFloatNullable(cpo.find('mfcTimeAdjMin').text)
            f['minTimeAdj'] = parseFloatNullable(cpo.find('mecTimeAdjMin').text)
            f['risingZeroTimeAdj'] = parseFloatNullable(cpo.find('sbfTimeAdjMin').text)
            f['fallingZeroTimeAdj'] = parseFloatNullable(cpo.find('sbeTimeAdjMin').text)
            f['maxValueAdj'] = parseFloatNullable(cpo.find('mfcAmpAdj').text)
            f['minValueAdj'] = parseFloatNullable(cpo.find('mecAmpAdj').text)

            stationSink.addFeature(f)

            progress_count += 1
            self.feedback.setProgress(50 + (50*progress_count/len(stationMap)))

class StylePostProcessor(QgsProcessingLayerPostProcessorInterface):
    def __init__(self, layerName, styleName, layerType):
        super(StylePostProcessor, self).__init__()
        self.layerName = layerName
        self.styleName = styleName
        self.layerType = layerType

    def configureLayer(self, layer, context, feedback):
        # rename and style the output layer here
        layer.setName(self.layerName)
        layer.loadNamedStyle(os.path.join(os.path.dirname(__file__),'styles',self.styleName))
        layer.triggerRepaint()

        # set up custom variable identifying the added layers
        layer.setCustomProperty(NOAA_LAYER_TYPE, self.layerType)

        # if both layers are available (meaning both post processors have run) then configure joins and virtual fields
        stationsLayer = getStationsLayer()
        predictionsLayer = getPredictionsLayer()
        if stationsLayer is not None and predictionsLayer is not None:
            joinInfo = QgsVectorLayerJoinInfo()
            joinInfo.setJoinLayer(stationsLayer)
            joinInfo.setTargetFieldName('station')
            joinInfo.setJoinFieldName('station')
            joinInfo.setJoinFieldNamesSubset(['name','timeZoneId','timeZoneUTC'])
            joinInfo.setUsingMemoryCache(True)
            joinInfo.setPrefix('station_')
            predictionsLayer.addJoin(joinInfo)

            predictionsLayer.addExpressionField(
                'convert_to_time_zone(time, station_timeZoneUTC, station_timeZoneId)',
                QgsField('local_time', QVariant.DateTime)
            )
            predictionsLayer.addExpressionField(
                "format_date(convert_to_time_zone(time, station_timeZoneUTC, station_timeZoneId), 'MM/dd')",
                QgsField('display_date', QVariant.String)
            )
            predictionsLayer.addExpressionField(
                "format_date(convert_to_time_zone(time, station_timeZoneUTC, station_timeZoneId), 'hh:mm a')",
                QgsField('display_time', QVariant.String)
            )
            predictionsLayer.addExpressionField(
                "floor(flags/128) % 2",
                QgsField('surface', QVariant.Int)
            )
            predictionsLayer.addExpressionField(
                "floor(flags/64) % 2",
                QgsField('current', QVariant.Int)
            )
            predictionsLayer.updateFields()

            stationsLayer.addExpressionField(
                "floor(flags/2) % 2",
                QgsField('current', QVariant.Int)
            )
            stationsLayer.addExpressionField(
                "floor(flags/4) % 2",
                QgsField('surface', QVariant.Int)
            )
            stationsLayer.addExpressionField(
                "floor(flags/8) % 2",
                QgsField('reference', QVariant.Int)
            )
            stationsLayer.updateFields()


class StationsStylePostProcessor(StylePostProcessor):
    instance = None

    def postProcessLayer(self, layer, context, feedback):
        self.configureLayer(layer, context, feedback)

        stationIndex = layer.dataProvider().fields().indexOf('station')
        layer.dataProvider().createAttributeIndex(stationIndex)

    @staticmethod
    def create(layerName, styleName, layerType) -> 'StationsStylePostProcessor':
        StationsStylePostProcessor.instance = StationsStylePostProcessor(
            layerName, styleName, layerType
        )
        return StationsStylePostProcessor.instance

class PredictionsStylePostProcessor(StylePostProcessor):
    instance = None

    def postProcessLayer(self, layer, context, feedback):
        self.configureLayer(layer, context, feedback)

        stationIndex = layer.dataProvider().fields().indexOf('station')
        layer.dataProvider().createAttributeIndex(stationIndex)

    @staticmethod
    def create(layerName, styleName, layerType) -> 'StationsStylePostProcessor':
        PredictionsStylePostProcessor.instance = PredictionsStylePostProcessor(
            layerName, styleName, layerType
        )
        return PredictionsStylePostProcessor.instance

