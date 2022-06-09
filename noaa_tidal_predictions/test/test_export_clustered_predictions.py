from .utilities import get_qgis_app

import unittest
from unittest.mock import *

import os

from qgis.PyQt.QtCore import QCoreApplication, QDateTime
from qgis.core import (
    QgsProject,
    QgsProcessingContext,
    QgsProcessingException,
    QgsProcessingFeedback,
    QgsProcessingUtils,
    QgsVectorLayer,
    QgsFeatureRequest,
    QgsFeature,
    NULL
    )
from noaa_tidal_predictions.export_clustered_predictions import ExportClusteredPredictionsAlgorithm
from noaa_tidal_predictions.prediction_expressions import PredictionExpressions
from noaa_tidal_predictions.utils import *

QGIS_APP = get_qgis_app()

class ExportFixtures:
    def __init__(self):
        self.alg = ExportClusteredPredictionsAlgorithm()
        self.alg.initAlgorithm({})
        self.alg.context = QgsProcessingContext()
        self.alg.feedback = Mock(spec=QgsProcessingFeedback)
        self.alg.parameters = {
            'StationsLayer': self.dataFilename('testClusters.gpkg'),
            'ExportDirectory': self.exportFilename('.'),
            'StartDate': QDateTime(2020,1,1,5,0,Qt.TimeSpec.UTC),
            'EndDate': QDateTime(2020,1,2,5,0,Qt.TimeSpec.UTC),
            'ExportReport': self.exportFilename('report.html')
        }
        PredictionExpressions.registerFunctions()

    def dataFilename(self, fn):
        if fn == '':
            return fn
        return os.path.join(os.path.dirname(__file__), 'data', fn)

    def exportFilename(self, fn):
        if fn == '':
            return fn
        return os.path.join(os.path.dirname(__file__), 'export', fn)


    def cleanUp(self):
        for layer in QgsProject.instance().mapLayers():
            QgsProject.instance().removeMapLayer(layer)
        PredictionExpressions.unregisterFunctions()
       
class ExportTest(unittest.TestCase):
    def setUp(self):
        self.fixtures = ExportFixtures()
        return

    def tearDown(self):
        self.fixtures.cleanUp()
        return

    def test_export_clusters(self):
        self.fixtures.alg.exportClusters()
        print('Doing nothing.')
        assert(False)



if __name__ == "__main__":
    suite = unittest.makeSuite(StationsTest)
    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(suite)
