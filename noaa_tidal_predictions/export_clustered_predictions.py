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
from .prediction_manager import PredictionManager, PredictionPromise

class ExportClusteredPredictionsAlgorithm(QgsProcessingAlgorithm):
    PrmStationsLayer = 'StationsLayer'
    PrmExportDirectory = 'ExportDirectory'
    PrmExportNewOnly = 'ExportNewOnly'
    PrmExportClusterStations = 'ExportClusterStations'
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
            QgsProcessingParameterBoolean(
                self.PrmExportNewOnly,
                tr('Only export new files'),
                False
            )
        )
        self.addParameter(
            QgsProcessingParameterBoolean(
                self.PrmExportClusterStations,
                tr('Export cluster stations'),
                True
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
        self.predictionManager.savePredictions = False

        predictionFieldNames = ['station','depth','time','value','flags','dir','magnitude']
        predictionFieldIndices = [self.predictionsLayer.fields().lookupField(name) for name in predictionFieldNames]

        stationFieldNames = ['station','id','name','flags','timeZoneId','refStation','meanFloodDir','meanEbbDir']
        stationFieldIndices = [self.stationsLayer.fields().lookupField(name) for name in stationFieldNames]

        outputFile = self.parameters[self.PrmOutputFile]
        self.report = codecs.open(outputFile, 'w', encoding='utf-8')
        self.report.write('<html><head>')
        self.report.write('<meta http-equiv="Content-Type" content="text/html; \
                 charset=utf-8" /></head><body>')

        # Create map of clusters to station lists
        clusterStations = {}
        clusterDirs = {}
        for cluster_id in self.determineClusterIds():
            clusterStations[cluster_id] = self.getClusterStations(cluster_id)

            exportDir = os.path.join(self.parameters[self.PrmExportDirectory], str(cluster_id))
            if not os.path.exists(exportDir):
                os.makedirs(exportDir)
            clusterDirs[cluster_id] = exportDir

            if self.parameters[self.PrmExportClusterStations]:
                clusterFile = os.path.join(exportDir, 'stations.geojson')
                exporter = QgsJsonExporter()
                exporter.setVectorLayer(self.stationsLayer)
                exporter.setAttributes(stationFieldIndices)

                with codecs.open(clusterFile, 'w', encoding='utf-8') as f:
                    f.write(exporter.exportFeatures([s for s in clusterStations[cluster_id] if s['surface']]))


        # now loop over dates, then clusters, then stations
        dt = self.parameters[self.PrmStartDate]
        while dt < self.parameters[self.PrmEndDate]:
            self.reportInfo('Date: {}'.format(dt.date().toString()))

            for cluster_id in clusterStations.keys():
                stations = clusterStations[cluster_id]

                exportDir = clusterDirs[cluster_id]
                exportFile =  os.path.join(exportDir, dt.toString('yyyyMMdd') + '.geojson')
                # If the path already exists, don't regenerate this data
                if self.parameters[self.PrmExportNewOnly] and os.path.exists(exportFile):
                    continue
                exporter = QgsJsonExporter()
                exporter.setVectorLayer(self.predictionsLayer)
                exporter.setAttributes(predictionFieldIndices)

                features = []

                for retry_count in range(0,3):   # we will try stations 3 times before giving up
                    self.reportInfo('Processing cluster {}: {} stations.'.format(cluster_id, len(stations)))
                    failed_stations = []
                    for stationFeature in stations:
                        if stationFeature['surface'] == 0:
                            continue
                        stationData = self.predictionManager.getDataPromise(stationFeature, dt.date())
                        stationData.start()

                        if stationData.state != PredictionPromise.ResolvedState:
                            self.reportInfo('Station {} failed with state {}'.format(stationFeature['station'], stationData.state))
                            failed_stations.append(stationFeature)
                            continue

                        features += stationData.predictions

                    if len(failed_stations) == 0:
                        break                       # no failures, don't do any retries
                    else:
                        stations = failed_stations  # attempt again with the failed stations

                with codecs.open(exportFile, 'w', encoding='utf-8') as f:
                    f.write(exporter.exportFeatures(features))

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

