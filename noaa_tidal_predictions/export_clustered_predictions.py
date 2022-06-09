import os
import codecs
import math
import re as re
from datetime import *

from qgis.core import (
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
    QgsProcessingParameterString)

from qgis.PyQt.QtGui import QIcon, QColor
from qgis.PyQt.QtCore import QVariant, QUrl, QDateTime

from .utils import *
from .time_zone_lookup import TimeZoneLookup

class ExportClusteredPredictionsAlgorithm(QgsProcessingAlgorithm):
    PrmStationsLayer = 'StationsLayer'
    PrmExportDirectory = 'ExportDirectory'
    PrmStartDate = 'StartDate'
    PrmEndDate = 'EndDate'
    PrmOutputFile = 'ExportReport'

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

    def exportClusters(self):
        self.feedback.pushInfo("Export complete.")
        self.output_file = self.parameters[self.PrmOutputFile]
        if self.output_file:
            print(self.parameters)
            self.createHTML(self.output_file, None)

    def processAlgorithm(self, parameters, context, feedback):
        self.context = context
        self.feedback = feedback
        self.parameters = parameters

        self.exportClusters()

        results = {}
        results[self.PrmOutputFile] = self.output_file

        return results

    def createHTML(self, outputFile, algData):
        with codecs.open(outputFile, 'w', encoding='utf-8') as f:
            f.write('<html><head>')
            f.write('<meta http-equiv="Content-Type" content="text/html; \
                     charset=utf-8" /></head><body>')
            f.write('<p>Forty-two.</p>')
            f.write('</body></html>')
