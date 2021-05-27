from .utilities import get_qgis_app

import unittest
from unittest.mock import *

import os

from qgis.PyQt.QtCore import QCoreApplication
from qgis.core import (
    QgsProject,
    QgsProcessingContext,
    QgsProcessingFeedback,
    QgsProcessingUtils,
    QgsVectorLayer,
    QgsFeatureRequest,
    QgsFeature,
    NULL
    )
from noaa_tidal_predictions.add_station_layers import AddCurrentStationsLayerAlgorithm
from noaa_tidal_predictions.utils import *

QGIS_APP = get_qgis_app()

class CurrentStationsFixtures:
    def __init__(self):
        self.alg = AddCurrentStationsLayerAlgorithm()
        self.alg.initAlgorithm({})
        self.alg.context = QgsProcessingContext()
        self.alg.feedback = Mock(spec=QgsProcessingFeedback)
        self.alg.parameters = {'CurrentStationsLayer': QgsProcessingUtils.generateTempFilename('stations.gpkg')}

    def getMockRequest(self, filename, status_code=200):
        mockRequest = Mock()
        mockRequest.status_code = status_code
        with open(os.path.join(os.path.dirname(__file__), 'data', filename), 'r') as dataFile:
            mockRequest.text = dataFile.read()
        return mockRequest

    def loadOnCompletion(self):
        details = QgsProcessingContext.LayerDetails('stations', QgsProject.instance())
        self.alg.context.addLayerToLoadOnCompletion(self.alg.parameters['CurrentStationsLayer'], details)

    def getFixtureLayer(self, filename):
        self.loadOnCompletion()
        with patch('requests.get') as mockGet:
            mockGet.return_value = self.getMockRequest(filename)
            dest_id = self.alg.getCurrentStations()
            layer = QgsProcessingUtils.mapLayerFromString(dest_id, self.alg.context)
            if self.alg.context.willLoadLayerOnCompletion(dest_id):
                QgsProject.instance().addMapLayer(layer)
                postProcessor = self.alg.context.layersToLoadOnCompletion().get(dest_id).postProcessor()
                postProcessor.postProcessLayer(layer, self.alg.context, self.alg.feedback)
            return layer

    def getFeatures(self, filename, expression):
        layer = self.getFixtureLayer(filename)
        return list(layer.getFeatures(QgsFeatureRequest().setFilterExpression(expression)))

    def generateAssertions(self, feature):
        for name in feature.fields().names():
            print("self.assertEqual(feature['{}'], {})".format(name, repr(feature[name])))

    def cleanUp(self):
        for layer in QgsProject.instance().mapLayers():
            QgsProject.instance().removeMapLayer(layer)
       
class CurrentStationsTest(unittest.TestCase):
    def setUp(self):
        self.fixtures = CurrentStationsFixtures()
        return

    def tearDown(self):
        self.fixtures.cleanUp()
        return

    @patch('requests.get')
    def test_request_url(self, mockGet):
        mockGet.return_value = self.fixtures.getMockRequest('currentSubordinate.xml')
        dest_id = self.fixtures.alg.getCurrentStations()
        mockGet.assert_called_once_with('https://api.tidesandcurrents.noaa.gov/mdapi/prod/webapi/stations.xml?type=currentpredictions&expand=currentpredictionoffsets', timeout=30)

    @patch('requests.get')
    def test_bad_request(self, mockGet):
        mockGet.return_value = self.fixtures.getMockRequest('currentSubordinate.xml', 400)
        dest_id = self.fixtures.alg.getCurrentStations()
        self.fixtures.alg.feedback.reportError.assert_called()

    def test_add_subordinate(self):
        features = self.fixtures.getFeatures('currentSubordinate.xml', "station = 'ACT0926_1'")
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['station'], 'ACT0926_1')
        self.assertEqual(feature['id'], 'ACT0926')
        self.assertEqual(feature['name'], 'Bass Point, 1.2 n.mi. southeast of')
        self.assertEqual(feature['type'], 'S')
        self.assertEqual(feature['timeZoneId'], 'America/New_York')
        self.assertEqual(feature['timeZoneUTC'], 'UTC-05:00')
        self.assertEqual(feature['refStation'], 'BOS1111_14')
        self.assertEqual(feature['bin'], '1')
        self.assertEqual(feature['depth'], 10.0)
        self.assertEqual(feature['depthType'], 'S')
        self.assertEqual(feature['surface'], 1)
        self.assertEqual(feature['meanFloodDir'], 259.0)
        self.assertEqual(feature['meanEbbDir'], 66.0)
        self.assertEqual(feature['mfcTimeAdjMin'], 85.0)
        self.assertEqual(feature['sbeTimeAdjMin'], 53.0)
        self.assertEqual(feature['mecTimeAdjMin'], -26.0)
        self.assertEqual(feature['sbfTimeAdjMin'], -31.0)
        self.assertEqual(feature['mfcAmpAdj'], 0.6)
        self.assertEqual(feature['mecAmpAdj'], 0.6) 
 
    def test_add_harmonic(self):
        features = self.fixtures.getFeatures('currentHarmonic.xml', "station = 'BOS1111_14'")
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['station'], 'BOS1111_14')
        self.assertEqual(feature['id'], 'BOS1111')
        self.assertEqual(feature['name'], 'Boston Harbor (Deer Island Light)')
        self.assertEqual(feature['type'], 'H')
        self.assertEqual(feature['timeZoneId'], 'America/New_York')
        self.assertEqual(feature['timeZoneUTC'], 'UTC-05:00')
        self.assertEqual(feature['refStation'], NULL)
        self.assertEqual(feature['bin'], '14')
        self.assertEqual(feature['depth'], 8.0)
        self.assertEqual(feature['depthType'], 'B')
        self.assertEqual(feature['surface'], 1)
        self.assertEqual(feature['meanFloodDir'], 264.0)
        self.assertEqual(feature['meanEbbDir'], 112.0)
        self.assertEqual(feature['mfcTimeAdjMin'], NULL)
        self.assertEqual(feature['sbeTimeAdjMin'], NULL)
        self.assertEqual(feature['mecTimeAdjMin'], NULL)
        self.assertEqual(feature['sbfTimeAdjMin'], NULL)
        self.assertEqual(feature['mfcAmpAdj'], NULL)
        self.assertEqual(feature['mecAmpAdj'], NULL)

    def test_detect_surface(self):
        dest = self.fixtures.getFixtureLayer('currentMultiDepth.xml')

        features = list(dest.getFeatures(QgsFeatureRequest().setFilterExpression("id = 'ACT0926'")))
        self.assertEqual(len(features), 3)

        features = list(dest.getFeatures(QgsFeatureRequest().setFilterExpression("station = 'ACT0926_1'")))
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['depth'], 10.0)
        self.assertEqual(feature['surface'], 1)

        features = list(dest.getFeatures(QgsFeatureRequest().setFilterExpression("station = 'ACT0926_2'")))
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['depth'], 45.0)
        self.assertEqual(feature['surface'], 0)

        features = list(dest.getFeatures(QgsFeatureRequest().setFilterExpression("station = 'ACT0926_3'")))
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['depth'], 60.0)
        self.assertEqual(feature['surface'], 0)

    def test_layer_utilities(self):
        stationsLayer = currentStationsLayer()
        predictionsLayer = currentPredictionsLayer()
        self.assertIsNone(stationsLayer)        
        self.assertIsNone(predictionsLayer)
        
        dest = self.fixtures.getFixtureLayer('currentRefSub.xml')

        stationsLayer = currentStationsLayer()
        self.assertIsInstance(stationsLayer,QgsVectorLayer)
        self.assertEqual(stationsLayer.storageType(),'GPKG')

        features = list(dest.getFeatures(QgsFeatureRequest().setFilterExpression("station = 'BOS1111_14'")))
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['station'], 'BOS1111_14')
        self.assertEqual(stationTimeZone(feature).id(), 'America/New_York')

        predictionsLayer = currentPredictionsLayer()
        self.assertIsInstance(predictionsLayer,QgsVectorLayer)
        self.assertEqual(predictionsLayer.storageType(),'Memory storage')

    def test_prediction_station_join(self):
        dest = self.fixtures.getFixtureLayer('currentRefSub.xml')

        predictionsLayer = currentPredictionsLayer()
        feature = QgsFeature(predictionsLayer.fields())
        feature['station'] = 'BOS1111_14'
        predictionsLayer.startEditing()
        predictionsLayer.addFeature(feature)
        predictionsLayer.commitChanges()
        features = list(predictionsLayer.getFeatures(QgsFeatureRequest().setFilterExpression("station = 'BOS1111_14'")))
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['station_name'],'Boston Harbor (Deer Island Light)')




if __name__ == "__main__":
    suite = unittest.makeSuite(CurrentStationsTest)
    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(suite)
