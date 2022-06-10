import os
import codecs
import math
import re as re
from datetime import *

from qgis.core import (
    QgsFeatureRequest,
    QgsFields,
    QgsJsonExporter,
    QgsProcessing,
    QgsProcessingAlgorithm,
    QgsProcessingLayerPostProcessorInterface,
    QgsProcessingException,
    QgsProcessingFeedback,
    QgsProcessingParameterBoolean,
    QgsProcessingParameterDateTime,
    QgsProcessingParameterFileDestination,
    QgsProcessingParameterFolderDestination,
    QgsProcessingParameterNumber,
    QgsProcessingParameterEnum,
    QgsProcessingParameterFeatureSource,
    QgsProcessingParameterField,
    QgsProcessingParameterExtent,
    QgsProcessingParameterFeatureSink,
    QgsProcessingParameterString,
    QgsVectorLayerExporter,
    QgsWkbTypes)

from qgis.PyQt.QtGui import QIcon, QColor
from qgis.PyQt.QtCore import QVariant, QUrl, QDateTime, QDate, QTime

from .utils import *
from .time_zone_lookup import TimeZoneLookup
from .prediction_manager import PredictionManager

class ExportClusteredPredictionsAlgorithm(QgsProcessingAlgorithm):
    PrmStationsLayer = 'StationsLayer'
    PrmExportDirectory = 'ExportDirectory'
    PrmStartDate = 'StartDate'
    PrmEndDate = 'EndDate'
    PrmOutputFile = 'ExportReport'

    CLUSTER_ID = 'CLUSTER_ID'

# boilerplate methods
    def name(self):
        return 'exportclusteredpredictions'

    def displayName(self):
        return tr('Export Clustered Predictions')

    def helpUrl(self):
        return ''

    def createInstance(self):
        return ExportClusteredPredictionsAlgorithm()

    # Set up this algorithm
    def initAlgorithm(self, config):
        self.addParameter(
            QgsProcessingParameterFeatureSource(
                self.PrmStationsLayer,
                tr('Clustered stations layer'),
                [QgsProcessing.TypeVectorPoint]
                )
            )
        self.addParameter(
            QgsProcessingParameterDateTime(
                self.PrmStartDate,
                tr('Export start date')
            )
        )
        self.addParameter(
            QgsProcessingParameterDateTime(
                self.PrmEndDate,
                tr('Export end date')
            )
        )
        self.addParameter(
            QgsProcessingParameterFolderDestination(
                self.PrmExportDirectory,
                tr('Export to directory')
            )
        )
        self.addParameter(
            QgsProcessingParameterFileDestination(
                self.PrmOutputFile,
                tr('Export report'),
                tr('HTML files (*.html)'),
                None,
                True
            )
        )

        self.feedback = QgsProcessingFeedback()
        self.report = None

    def initializeFromParams(self):
        self.clusteredStationsLayer = self.parameterAsSource(self.parameters, self.PrmStationsLayer, self.context)
        if self.clusteredStationsLayer is None:
            raise QgsProcessingException(self.invalidSourceError(parameters, self.PrmStationsLayer))

    def determineClusterIds(self):
        fields = QgsFields()
        self.cluster_ids = []
        field_index = self.clusteredStationsLayer.fields().lookupField(self.CLUSTER_ID)
        if field_index < 0:
            self.feedback.reportError(tr('Invalid field name {}').format(self.CLUSTER_ID))
            return []
        else:
            field = self.clusteredStationsLayer.fields()[field_index]
            fields.append(field)
            return self.clusteredStationsLayer.uniqueValues(field_index)

    def getClusterStations(self, cluster_id):
        iter = self.clusteredStationsLayer.getFeatures(
            QgsFeatureRequest().setFilterExpression("{} = '{}'".format(self.CLUSTER_ID, cluster_id)))
        return [feature for feature in iter]

    def reportInfo(self, str):
        self.feedback.pushInfo(str)
        if self.report:
            self.report.write('<p>')
            self.report.write(str)
            self.report.write('</p>')

    def exportClusters(self):
        self.stationsLayer = getStationsLayer()
        self.predictionsLayer = getPredictionsLayer()
        self.predictionManager = PredictionManager(self.stationsLayer, self.predictionsLayer)
        self.predictionManager.blocking = True

        outputFile = self.parameters[self.PrmOutputFile]
        self.report = codecs.open(outputFile, 'w', encoding='utf-8')
        self.report.write('<html><head>')
        self.report.write('<meta http-equiv="Content-Type" content="text/html; \
                 charset=utf-8" /></head><body>')

        for cluster_id in self.determineClusterIds():
            stations = self.getClusterStations(cluster_id)
            self.reportInfo('Processing cluster {}; {} stations found.'.format(cluster_id, len(stations)))

            dt = self.parameters[self.PrmStartDate]
            while dt < self.parameters[self.PrmEndDate]:
                self.reportInfo('Date: {}'.format(dt.date().toString()))

                exportDir = os.path.join(self.parameters[self.PrmExportDirectory], str(cluster_id))
                if not os.path.exists(exportDir):
                    os.makedirs(exportDir)
                exportFile =  os.path.join(exportDir, dt.toString('yyyyMMdd') + '.geojson')
                # exporter = QgsVectorLayerExporter(
                #     exportFile,
                #     'geojson',
                #     self.predictionsLayer.fields(),
                #     QgsWkbTypes.Point,
                #     # self.predictionsLayer.geometryType(),
                #     self.predictionsLayer.crs(),
                #     True)
                exporter = QgsJsonExporter()
                exporter.setVectorLayer(self.predictionsLayer)

                with codecs.open(exportFile, 'w', encoding='utf-8') as f:
                    f.write('''{
"type": "FeatureCollection",
"name": "tidalPredictions",
"crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },
"features": [
''')
                    firstFeature = True
                    for stationFeature in stations:
                        self.reportInfo('Station {}:'.format(stationFeature['station']))
                        self.stationData = self.predictionManager.getDataPromise(stationFeature, dt.date())
                        self.stationData.start()
                        for feature in self.stationData.predictions:
                            if not firstFeature:
                                f.write(''',
''')
                            f.write(exporter.exportFeature(feature))
                            firstFeature = False
                    f.write(']}')

                dt = dt.addDays(1)

        self.reportInfo("Export complete.")
        self.report.write('</body></html>')
        self.report.close()

        results = {}
        results[self.PrmOutputFile] = outputFile
        return results

    def processAlgorithm(self, parameters, context, feedback):
        self.context = context
        self.feedback = feedback
        self.parameters = parameters

        self.initializeFromParams()
        results = self.exportClusters()

        return results

