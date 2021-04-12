import os
import math
import requests
from datetime import *
import xml.etree.ElementTree as ET

from qgis.core import (
    QgsPointXY, QgsPoint, QgsFeature, QgsGeometry, QgsField, QgsFields,
    QgsProject, QgsUnitTypes, QgsWkbTypes, QgsCoordinateTransform,
    QgsLineString, QgsDistanceArea, QgsPalLayerSettings,
    QgsLabelLineSettings, QgsVectorLayer, QgsVectorLayerSimpleLabeling, QgsVectorLayerJoinInfo
)

from qgis.core import (
    QgsProcessing,
    QgsProcessingAlgorithm,
    QgsProcessingLayerPostProcessorInterface,
    QgsProcessingFeedback,
    QgsProcessingParameterBoolean,
    QgsProcessingParameterDateTime,
    QgsProcessingParameterNumber,
    QgsProcessingParameterEnum,
    QgsProcessingParameterVectorLayer,
    QgsProcessingParameterField,
    QgsProcessingParameterExtent,
    QgsProcessingParameterFeatureSink,
    QgsNetworkContentFetcher)

from qgis.PyQt.QtGui import QIcon, QColor
from qgis.PyQt.QtCore import QVariant, QUrl, QUrlQuery, QDateTime, QTime, Qt, QTimeZone, QByteArray
from qgis.PyQt.QtNetwork import QNetworkRequest
from qgis.PyQt.QtXml import QDomDocument

from qgis.utils import iface

from .utils import *

class GetTidalPredictionsAlgorithm(QgsProcessingAlgorithm):
    PrmStationsLayer = 'StationsLayer'
    PrmOutputLayer = 'OutputLayer'
    PrmCurrentInterval = 'CurrentInterval'
    PrmCurrentVelType = 'CurrentVelType'
    PrmVisibleOnly = 'VisibleOnly'
    PrmStartDate = 'StartDate'
    PrmEndDate = 'EndDate'

    CURRENT_INTERVAL_OPTIONS = [tr('Max and slack'), tr('60 minutes'), tr('30 minutes'), tr('6 minutes')]
    CURRENT_INTERVAL_VALUES = ['MAX_SLACK', '60', '30', '6']

    CURRENT_VEL_TYPE_OPTIONS = [tr('Flood/ebb speed'), tr('Speed and direction (Harmonic only)')]
    CURRENT_VEL_TYPE_VALUES = ['default', 'speed_dir']

# boilerplate methods
    def name(self):
        return 'gettidalpredictions'

    def displayName(self):
        return tr('Get Tidal Predictions')

    def helpUrl(self):
        return ''

    def createInstance(self):
        return GetTidalPredictionsAlgorithm()

    # Set up this algorithm
    def initAlgorithm(self, config):
        stationsLayerName = 'Current stations'
        projectVars = QgsProject.instance().customVariables()

        if CurrentStationsLayerVar in projectVars:
            stationsLayerName = projectVars[CurrentStationsLayerVar]

        self.mapSettings = iface.mapCanvas().mapSettings()

        self.addParameter(
            QgsProcessingParameterVectorLayer(
                self.PrmStationsLayer,
                tr('Current stations input layer'),
                [QgsProcessing.TypeVectorPoint],
                stationsLayerName)
        )
        self.addParameter(
            QgsProcessingParameterBoolean(
                self.PrmVisibleOnly,
                tr('Features visible on main map only'),
                True)
        )

        self.addParameter(
            QgsProcessingParameterEnum(
                self.PrmCurrentInterval,
                tr('Prediction interval'),
                options=self.CURRENT_INTERVAL_OPTIONS,
                defaultValue=0,
                optional=False)
        )
        self.addParameter(
            QgsProcessingParameterEnum(
                self.PrmCurrentVelType,
                tr('Prediction speeds and directions'),
                options=self.CURRENT_VEL_TYPE_OPTIONS,
                defaultValue=0,
                optional=False)
        )

        today_start = QDateTime.currentDateTime()
        today_start.setTime(QTime(0, 0))        
        self.addParameter(
            QgsProcessingParameterDateTime(
                self.PrmStartDate,
                tr('Start time'),
                QgsProcessingParameterDateTime.DateTime,
                today_start)
        )

        today_end = QDateTime.currentDateTime()
        today_end.setTime(QTime(23, 59))        
        self.addParameter(
            QgsProcessingParameterDateTime(
                self.PrmEndDate,
                tr('End time'),
                QgsProcessingParameterDateTime.DateTime,
                today_end)
        )

        self.addParameter(
            QgsProcessingParameterFeatureSink(
                self.PrmOutputLayer,
                tr('Output layer'))
        )

    def processAlgorithm(self, parameters, context, feedback):
        self.context = context
        self.feedback = feedback

        # gather parameters
        self.startDate = self.parameterAsDateTime(parameters, self.PrmStartDate, context)
        self.endDate = self.parameterAsDateTime(parameters, self.PrmEndDate, context)
        self.currentsLayer = self.parameterAsVectorLayer(parameters, self.PrmStationsLayer, context)
        self.filterVisible = self.parameterAsBool(parameters, self.PrmVisibleOnly, context)
        self.velType = self.CURRENT_VEL_TYPE_VALUES[self.parameterAsInt(parameters, self.PrmCurrentVelType, context)]
        self.interval = self.CURRENT_INTERVAL_VALUES[self.parameterAsInt(parameters, self.PrmCurrentInterval, context)]

        # obtain our output sink
        fields = QgsFields()
        fields.append(QgsField("station", QVariant.String,'',16))
        fields.append(QgsField("id", QVariant.String,'',12))
        fields.append(QgsField("bin", QVariant.String,'',4))
        fields.append(QgsField("depth",  QVariant.Double))
        fields.append(QgsField("time",  QVariant.DateTime))
        fields.append(QgsField("date_break",  QVariant.Bool))
        fields.append(QgsField("value", QVariant.Double))  # signed value, on flood/ebb dimension for current
        fields.append(QgsField("dir", QVariant.Double))
        fields.append(QgsField("magnitude", QVariant.Double))  # value along direction if known
        fields.append(QgsField("type", QVariant.String))
        self.fields = fields

        # expression fields are added in the QML styling by the postprocessor

        (sink, dest_id) = self.parameterAsSink(
            parameters, self.PrmOutputLayer, context, fields,
            QgsWkbTypes.Point, epsg4326)

        if context.willLoadLayerOnCompletion(dest_id):
            context.layerToLoadOnCompletionDetails(dest_id).setPostProcessor(StylePostProcessor.create(self))

        # body goes here

        rect = None
        if self.filterVisible:
            xform = QgsCoordinateTransform(self.mapSettings.destinationCrs(),
                        QgsCoordinateReferenceSystem('EPSG:4326'),
                        QgsProject.instance())
            rect = xform.transform(self.mapSettings.visibleExtent())

        self.feedback.pushInfo('Starting...')

        requestList = []
        for index, feature in enumerate(self.currentsLayer.getFeatures()):
            if rect and not feature.geometry().intersects(rect):
                continue                
            requestList.append(CurrentPredictionRequest(self, sink, QgsFeature(feature)))

        index = 0
        for cpr in requestList:
            cpr.requestContent()
            if self.feedback.isCanceled():
                break

            index += 1
            self.feedback.setProgress(100*index/len(requestList))

        # all done
        return {self.PrmOutputLayer: dest_id}        
            
class CurrentPredictionRequest:
    session = None

    def __init__(self, alg, sink, feature):
        self.algorithm = alg
        self.sink = sink
        self.feature = feature
        
    def requestContent(self):
        self.stationId = self.feature['id']

        timeZoneId = self.feature['timeZoneId']
        timeZoneUTC = self.feature['timeZoneUTC']
        floodDir = self.feature['meanFloodDir']
        ebbDir = self.feature['meanEbbDir']

        tz = None
        if timeZoneId:
            tz = QTimeZone(QByteArray(timeZoneId.encode()))
            if not tz.isValid():
                tz = None
        if not tz:
            tz = QTimeZone(QByteArray(timeZoneUTC.encode()))

        self.algorithm.feedback.pushInfo('Requesting predictions from {}'.format(self.feature['name']))

        query = QUrlQuery()
        query.addQueryItem('application',CoopsApplicationName)
        query.addQueryItem('station',self.stationId)
        query.addQueryItem('bin',str(self.feature['bin']))
        query.addQueryItem('begin_date',self.algorithm.startDate.toUTC().toString('yyyyMMdd hh:mm'))
        query.addQueryItem('end_date',self.algorithm.endDate.toUTC().toString('yyyyMMdd hh:mm'))
        query.addQueryItem('product','currents_predictions')
        query.addQueryItem('units','english')
        query.addQueryItem('time_zone','gmt')
        query.addQueryItem('vel_type',self.algorithm.velType)
        query.addQueryItem('interval',self.algorithm.interval)
        query.addQueryItem('format','xml')
        url = 'https://api.tidesandcurrents.noaa.gov/api/prod/datagetter?' + query.query()

        if self.session == None:
            self.session = requests.Session()

        r = self.session.get(url, timeout=30)
        if r.status_code != 200:
            return

        content = r.text
        if len(content) == 0:
            return
        
        # Parse the XML file into a DOM up front
        root = ET.fromstring(content) 

        # Get the list of stations
        cp = root.findall('cp')

        f = None
        last_date = None
        last_difference = None
        last_value = None
        
        for i in range(0, len(cp)):
            try:
                prediction = cp[i]

                dt = QDateTime.fromSecsSinceEpoch(round(float(datetime.fromisoformat(prediction.find('Time').text).timestamp())))
                dt.setTimeSpec(Qt.TimeSpec.UTC)   # just to be clear on this, this is a UTC time
                local_date = dt.toTimeZone(tz).date()

                f = QgsFeature(self.algorithm.fields)
                f.setGeometry(QgsGeometry(self.feature.geometry()))
                f['id'] = self.feature['id']
                f['bin'] = self.feature['bin']
                f['station'] = f['id'] + '_' + f['bin']
                f['depth'] = parseFloatNullable(prediction.find('Depth').text)
                f['time'] = dt   # TODO: time zone adjustment?
                f['date_break'] = (last_date == None) or (last_date != local_date)
                last_date = local_date
                
                # we have one of several different possibilities:
                #  - timed measurement, flood/ebb, signed velocity
                #  - max/slack measurement, flood/ebb, signed velocity
                #  - timed measurement, varying angle, unsigned velocity
                directionElement = prediction.find('Direction')
                if directionElement != None:
                    direction = parseFloatNullable(directionElement.text)
                    magnitude = float(prediction.find('Speed').text)
                    valtype = 'current'

                    # synthesize the value along flood/ebb dimension
                    floodFactor = math.cos(math.radians(floodDir - direction))
                    ebbFactor = math.cos(math.radians(ebbDir - direction))
                    if floodFactor > ebbFactor:
                        value = magnitude * floodFactor
                    else:
                        value = -magnitude * ebbFactor

                else:
                    vel = float(prediction.find('Velocity_Major').text)
                    if (vel >= 0):
                        direction = floodDir
                    else:
                        direction = ebbDir
                    value = vel
                    magnitude = abs(vel)
                    typeElement = prediction.find('Type')
                    if typeElement != None:
                        valtype = typeElement.text
                    else:
                        valtype = 'current'

                # synthesize a max/slack type if we are at an extremum or zero crossing
                # --for now this is unused since it needs debouncing, is one element off,
                #   and may cause times to vary from NOAA's announced times, so fie upon it.
                #
                # if valtype == 'current':
                #     if last_value != None:
                #         if math.copysign(1, value) != math.copysign(1, last_value):
                #             valtype = 'slack'
                #         difference = value - last_value
                #         if last_difference != None:
                #             if math.copysign(1, difference) != math.copysign(1, last_difference):
                #                 valtype = 'ebb' if value < 0 else 'flood'
                #         last_difference = difference
                #     last_value = value

                f['value'] = value
                f['dir'] = direction
                f['magnitude'] = magnitude
                f['type'] = valtype

                self.sink.addFeature(f)

            except Exception as err:
                self.algorithm.feedback.pushInfo('Error handling station{}'.format(self.feature['id']))
                raise err    

class StylePostProcessor(QgsProcessingLayerPostProcessorInterface):
    instance = None

    def __init__(self, alg):
        super(StylePostProcessor, self).__init__()
        self.algorithm = alg

    def postProcessLayer(self, layer, context, feedback):

        if not isinstance(layer, QgsVectorLayer):
            return

        # add a join to the station layer from which these predictions were derived
        joinInfo = QgsVectorLayerJoinInfo()
        joinInfo.setTargetFieldName('station')
        joinInfo.setJoinFieldName('station')
        joinInfo.setJoinLayer(self.algorithm.currentsLayer)
        joinInfo.setJoinFieldNamesSubset(['name','timeZoneId','timeZoneUTC'])
        joinInfo.setPrefix('station_')
        layer.addJoin(joinInfo)

        # force the new layer in the UI tree to be collapsed because its legend is ugly
        root = QgsProject.instance().layerTreeRoot()
        layerTreeNode = root.findLayer(layer)
        if layerTreeNode:
            layerTreeNode.setExpanded(False)

        # style the output layer here
        suffix = self.algorithm.startDate.toString('yyyy-MM-dd hh:mm')
        layer.setName(tr('Currents') + ' ' + suffix)
        layer.loadNamedStyle(os.path.join(os.path.dirname(__file__),'styles','current_predictions.qml'))
        layer.triggerRepaint()

    @staticmethod
    def create(proc) -> 'StylePostProcessor':
        StylePostProcessor.instance = StylePostProcessor(proc)
        return StylePostProcessor.instance

