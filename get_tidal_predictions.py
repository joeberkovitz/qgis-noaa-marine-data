import os
import math
import requests
from datetime import *

from qgis.core import (
    QgsPointXY, QgsPoint, QgsFeature, QgsGeometry, QgsField, QgsFields,
    QgsProject, QgsUnitTypes, QgsWkbTypes, QgsCoordinateTransform,
    QgsLineString, QgsDistanceArea, QgsPalLayerSettings,
    QgsLabelLineSettings, QgsVectorLayer, QgsVectorLayerSimpleLabeling,
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
    QgsProcessingParameterFeatureSource,
    QgsProcessingParameterField,
    QgsProcessingParameterExtent,
    QgsProcessingParameterFeatureSink,
    QgsNetworkContentFetcher)

from qgis.PyQt.QtGui import QIcon, QColor
from qgis.PyQt.QtCore import QVariant, QUrl, QUrlQuery, QDateTime
from qgis.PyQt.QtNetwork import QNetworkRequest
from qgis.PyQt.QtXml import QDomDocument

from qgis.utils import iface

from .utils import *

class GetTidalPredictionsAlgorithm(QgsProcessingAlgorithm):
    PrmStationsLayer = 'StationsLayer'
    PrmOutputLayer = 'OutputLayer'
    PrmVisibleOnly = 'VisibleOnly'
    PrmStartDate = 'StartDate'
    PrmEndDate = 'EndDate'

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
        stationsLayer = 'Current stations'
        projectVars = QgsProject.instance().customVariables()

        if CurrentStationsLayerVar in projectVars:
            stationsLayer = projectVars[CurrentStationsLayerVar]

        self.mapSettings = iface.mapCanvas().mapSettings()

        self.addParameter(
            QgsProcessingParameterFeatureSource(
                self.PrmStationsLayer,
                tr('Current stations input layer'),
                [QgsProcessing.TypeVectorPoint],
                stationsLayer)
        )
        self.addParameter(
            QgsProcessingParameterBoolean(
                self.PrmVisibleOnly,
                tr('Features visible on main map only'),
                True)
        )
        self.addParameter(
            QgsProcessingParameterDateTime(
                self.PrmStartDate,
                tr('Start date'),
                QgsProcessingParameterDateTime.Date,
                None)
        )
        self.addParameter(
            QgsProcessingParameterDateTime(
                self.PrmEndDate,
                tr('End date'),
                QgsProcessingParameterDateTime.Date,
                None)
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
        self.currentsSource = self.parameterAsSource(parameters, self.PrmStationsLayer, context)
        self.filterVisible = self.parameterAsBool(parameters, self.PrmVisibleOnly, context)

        # obtain our output sink
        fields = QgsFields()
        fields.append(QgsField("id", QVariant.String))
        fields.append(QgsField("depth",  QVariant.Double))
        fields.append(QgsField("time",  QVariant.DateTime))
        fields.append(QgsField("date_break",  QVariant.Bool))
        fields.append(QgsField("velocity", QVariant.Double))
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

        for index, feature in enumerate(self.currentsSource.getFeatures()):
            if rect and not feature.geometry().intersects(rect):
                continue                
            cpr = CurrentPredictionRequest(self, sink, QgsFeature(feature))
            cpr.requestContent()
            if self.feedback.isCanceled():
                break

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
        query.addQueryItem('begin_date',self.algorithm.startDate.toString('yyyyMMdd'))
        query.addQueryItem('end_date',self.algorithm.endDate.toString('yyyyMMdd'))
        query.addQueryItem('product','currents_predictions')
        query.addQueryItem('units','english')
        query.addQueryItem('time_zone','lst_ldt')
#        query.addQueryItem('interval','30')
#        query.addQueryItem('vel_type','speed_dir')
        query.addQueryItem('interval','MAX_SLACK')
        query.addQueryItem('format','xml')
        url = 'https://api.tidesandcurrents.noaa.gov/api/prod/datagetter?' + query.query()

        r = requests.get(url)
        if r.status_code != 200:
            return

        content = r.text
        if len(content) == 0:
            return
            
        self.dom = QDomDocument()
        self.dom.setContent(content)
        cp = self.dom.documentElement().elementsByTagName('cp')
        f = None
        last_date = None
        
        for i in range(0, cp.count()):
            try:
                prediction = cp.item(i).toElement()

                dt = QDateTime.fromSecsSinceEpoch(round(float(datetime.fromisoformat(self.tagValue(prediction, 'Time')).timestamp())))

                f = QgsFeature(self.algorithm.fields)
                f.setGeometry(QgsGeometry(self.feature.geometry()))
                f['id'] = self.feature['id']
                try:
                    f['depth'] = float(self.tagValue(prediction, 'Depth'))
                except:
                    f['depth'] = 0
                    
                f['time'] = dt
                f['date_break'] = (last_date == None) or (last_date != dt.date())
                last_date = dt.date()
                
                # we have one of several different possibilities:
                #  - timed measurement, flood/ebb, signed velocity
                #  - max/slack measurement, flood/ebb, signed velocity
                #  - timed measurement, varying angle, unsigned velocity
                direction = self.tagValue(prediction, 'Direction')
                if len(direction) > 0:
                    f['dir'] = float(self.tagValue(prediction, 'Direction'))
                    f['velocity'] = float(self.tagValue(prediction, 'Speed'))
                    f['type'] = 'current'
                else:
                    vel = float(self.tagValue(prediction, 'Velocity_Major'))
                    if (vel >= 0):
                        f['dir'] = float(self.tagValue(prediction, 'meanFloodDir'))
                    else:
                        f['dir'] = float(self.tagValue(prediction, 'meanEbbDir'))                    
                    f['velocity'] = abs(vel)
                    type = self.tagValue(prediction, 'Type')
                    if len(type) == 0:
                        f['type'] = 'current'
                    else:
                        f['type'] = type

                self.sink.addFeature(f)

            except Exception as err:
                self.algorithm.feedback.pushInfo('Error handling station{}'.format(self.feature['id']))
                raise err    

    def tagValue(self, element, tagName):
        return element.elementsByTagName(tagName).item(0).toElement().firstChild().nodeValue()

class StylePostProcessor(QgsProcessingLayerPostProcessorInterface):
    instance = None

    def __init__(self, alg):
        super(StylePostProcessor, self).__init__()
        self.algorithm = alg

    def postProcessLayer(self, layer, context, feedback):

        if not isinstance(layer, QgsVectorLayer):
            return

        # style the output layer here
        # TODO: but only if we freshly created it...
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

