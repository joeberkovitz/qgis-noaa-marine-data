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
from noaa_tidal_predictions.prediction_manager import *
from noaa_tidal_predictions.export_clustered_predictions import ExportClusteredPredictionsAlgorithm
from noaa_tidal_predictions.prediction_expressions import PredictionExpressions
from noaa_tidal_predictions.utils import *

from .test_prediction_manager import PredictionManagerTest
from .test_add_stations import StationsFixtures
from .utilities import *

QGIS_APP = get_qgis_app()

class ExportFixtures:
    def __init__(self):
        self.fixtures = StationsFixtures()
        self.fixtures.getFixtureLayer('currentRefSub.xml','tideRefSub.xml')

        self.alg = ExportClusteredPredictionsAlgorithm()
        self.alg.initAlgorithm({})
        self.alg.context = QgsProcessingContext()
        self.alg.feedback = get_feedback()
        self.alg.parameters = {
            'StationsLayer': self.dataFilename('testClusters.gpkg'),
            'ExportDirectory': self.exportFilename('.'),
            'ExportNewOnly': False,
            'ExportClusterStations': True,
            'StartDate': QDateTime(2020,1,2,0,0),
            'EndDate': QDateTime(2020,1,3,0,0),
            'ExportReport': self.exportFilename('report.html')
        }
        self.alg.initializeFromParams()
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

    def test_determine_cluster_ids(self):
        clusterIds = self.fixtures.alg.determineClusterIds()
        self.assertEqual(clusterIds, {129, 122, 148})

    def test_get_cluster_stations(self):
        stations = self.fixtures.alg.getClusterStations(148)
        self.assertEqual(set([feature['station'] for feature in stations]),{'8443970', 'BOS1111_14', 'ACT0926_1', '8447291'})

    @patch.object(PredictionRequest, 'doStart', PredictionManagerTest.mock_doStart)
    def test_export_clusters(self):
        self.fixtures.alg.exportClusters()

        exportFixturesDir = self.fixtures.dataFilename('export')
        for dir in os.listdir(exportFixturesDir):
            for file in os.listdir(os.path.join(exportFixturesDir, dir)):
                with open(os.path.join(exportFixturesDir, dir, file), 'r') as refFile:
                    with open(os.path.join(self.fixtures.exportFilename(dir), file), 'r') as testFile:
                        self.assertEqual(refFile.read(), testFile.read()) 


if __name__ == "__main__":
    suite = unittest.makeSuite(StationsTest)
    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(suite)
