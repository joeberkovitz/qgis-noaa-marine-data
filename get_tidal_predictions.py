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
from qgis.PyQt.QtCore import QVariant, QUrl, QUrlQuery, QDateTime, QTime
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
    PrmUseUTC = 'UseUTC'

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
            QgsProcessingParameterBoolean(
                self.PrmUseUTC,
                tr('Predictions in UTC'),
                False)
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
        self.useUTC = self.parameterAsBool(parameters, self.PrmUseUTC, context)
        self.currentsLayer = self.parameterAsVectorLayer(parameters, self.PrmStationsLayer, context)
        self.filterVisible = self.parameterAsBool(parameters, self.PrmVisibleOnly, context)
        self.velType = self.CURRENT_VEL_TYPE_VALUES[self.parameterAsInt(parameters, self.PrmCurrentVelType, context)]
        self.interval = self.CURRENT_INTERVAL_VALUES[self.parameterAsInt(parameters, self.PrmCurrentInterval, context)]

        # obtain our output sink
        fields = QgsFields()
        fields.append(QgsField("id_bin", QVariant.String,'',16))
        fields.append(QgsField("id", QVariant.String,'',12))
        fields.append(QgsField("bin", QVariant.String,'',4))
        fields.append(QgsField("depth",  QVariant.Double))
        fields.append(QgsField("time",  QVariant.DateTime))
        fields.append(QgsField("date_break",  QVariant.Bool))
        fields.append(QgsField("velocity", QVariant.Double))
        fields.append(QgsField("velocity_major", QVariant.Double))  # signed velocity along flood/ebb psuedo-dimension
        fields.append(QgsField("dir", QVariant.Double))
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
    def __init__(self, alg, sink, feature):
        self.algorithm = alg
        self.sink = sink
        self.feature = feature
        
    def requestContent(self):
        self.stationId = self.feature['id']
        self.algorithm.feedback.pushInfo('Requesting predictions from {}'.format(self.feature['name']))

        query = QUrlQuery()
        query.addQueryItem('station',self.stationId)
        query.addQueryItem('bin',str(self.feature['bin']))
        query.addQueryItem('begin_date',self.algorithm.startDate.toString('yyyyMMdd hh:mm'))
        query.addQueryItem('end_date',self.algorithm.endDate.toString('yyyyMMdd hh:mm'))
        query.addQueryItem('product','currents_predictions')
        query.addQueryItem('units','english')
        query.addQueryItem('time_zone','gmt' if self.algorithm.useUTC else 'lst_ldt')
        query.addQueryItem('vel_type',self.algorithm.velType)
        query.addQueryItem('interval',self.algorithm.interval)
        query.addQueryItem('format','xml')
        url = 'https://api.tidesandcurrents.noaa.gov/api/prod/datagetter?' + query.query()

        r = requests.get(url, timeout=30)
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
        
        for i in range(0, len(cp)):
            try:
                prediction = cp[i]

                dt = QDateTime.fromSecsSinceEpoch(round(float(datetime.fromisoformat(prediction.find('Time').text).timestamp())))

                f = QgsFeature(self.algorithm.fields)
                f.setGeometry(QgsGeometry(self.feature.geometry()))
                f['id'] = self.feature['id']
                f['bin'] = self.feature['bin']
                f['id_bin'] = f['id'] + '_' + f['bin']
                f['depth'] = parseFloatNullable(prediction.find('Depth').text)
                f['time'] = dt   # TODO: time zone adjustment?
                f['date_break'] = (last_date == None) or (last_date != dt.date())
                last_date = dt.date()
                
                # we have one of several different possibilities:
                #  - timed measurement, flood/ebb, signed velocity
                #  - max/slack measurement, flood/ebb, signed velocity
                #  - timed measurement, varying angle, unsigned velocity
                directionElement = prediction.find('Direction')
                if directionElement != None:
                    f['dir'] = parseFloatNullable(directionElement.text)
                    f['velocity'] = float(prediction.find('Speed').text)
                    f['type'] = 'current'
                else:
                    vel = float(prediction.find('Velocity_Major').text)
                    if (vel >= 0):
                        f['dir'] = parseFloatNullable(prediction.find('meanFloodDir').text)
                    else:
                        f['dir'] = parseFloatNullable(prediction.find('meanEbbDir').text)                    
                    f['velocity_major'] = vel
                    f['velocity'] = abs(vel)
                    typeElement = prediction.find('Type')
                    if typeElement != None:
                        f['type'] = typeElement.text
                    else:
                        f['type'] = 'current'

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
        joinInfo.setTargetFieldName('id_bin')
        joinInfo.setJoinFieldName('id_bin')
        joinInfo.setJoinLayer(self.algorithm.currentsLayer)
        joinInfo.setJoinFieldNamesSubset(['name'])
        joinInfo.setPrefix('station_')
        layer.addJoin(joinInfo)

        # style the output layer here
        suffix = self.algorithm.startDate.toString('yyyy-MM-dd')
        if self.algorithm.endDate != self.algorithm.startDate:
            suffix = suffix + ' ' + self.algorithm.endDate.toString('yyyy-MM-dd')
        layer.setName(tr('Currents') + ' ' + suffix)
        layer.loadNamedStyle(os.path.join(os.path.dirname(__file__),'styles','current_predictions.qml'))
        layer.triggerRepaint()

    @staticmethod
    def create(proc) -> 'StylePostProcessor':
        StylePostProcessor.instance = StylePostProcessor(proc)
        return StylePostProcessor.instance

