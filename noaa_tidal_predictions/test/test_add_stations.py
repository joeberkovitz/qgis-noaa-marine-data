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
from noaa_tidal_predictions.add_station_layers import AddStationsLayerAlgorithm
from noaa_tidal_predictions.prediction_expressions import PredictionExpressions
from noaa_tidal_predictions.utils import *

QGIS_APP = get_qgis_app()

class StationsFixtures:
    def __init__(self):
        self.alg = AddStationsLayerAlgorithm()
        self.alg.initAlgorithm({})
        self.alg.context = QgsProcessingContext()
        self.alg.feedback = Mock(spec=QgsProcessingFeedback)
        self.alg.parameters = {
            'StationsLayer': QgsProcessingUtils.generateTempFilename('stations.gpkg'),
            'PredictionsLayer': QgsProcessingUtils.generateTempFilename('predictions.gpkg'),
        }
        PredictionExpressions.registerFunctions()

    def dataFilename(self, fn):
        if fn == '':
            return fn
        return os.path.join(os.path.dirname(__file__), 'data', fn)

    def getMockRequest(self, filename, status_code=200):
        mockRequest = Mock()
        mockRequest.status_code = status_code
        with open(self.dataFilename(filename), 'r') as dataFile:
            mockRequest.text = dataFile.read()
        return mockRequest

    def loadOnCompletion(self):
        details = QgsProcessingContext.LayerDetails('stations', QgsProject.instance())
        self.alg.context.addLayerToLoadOnCompletion(self.alg.parameters['StationsLayer'], details)
        self.alg.context.addLayerToLoadOnCompletion(self.alg.parameters['PredictionsLayer'], details)

    def getFixtureLayer(self, currentFile, tideFile=''):
        self.alg.parameters['CurrentMetadataURI'] = self.dataFilename(currentFile)
        self.alg.parameters['TideMetadataURI'] = self.dataFilename(tideFile)
        self.loadOnCompletion()

        stations_dest_id = self.alg.getStations()
        predictions_dest_id = self.alg.getPredictions()
        for layer_id in [stations_dest_id, predictions_dest_id]:
            layer = QgsProcessingUtils.mapLayerFromString(layer_id, self.alg.context)
            QgsProject.instance().addMapLayer(layer)
            postProcessor = self.alg.context.layersToLoadOnCompletion().get(layer_id).postProcessor()
            postProcessor.postProcessLayer(layer, self.alg.context, self.alg.feedback)

        return QgsProcessingUtils.mapLayerFromString(stations_dest_id, self.alg.context)

    def getFeatures(self, currentFile, tideFile, expression):
        layer = self.getFixtureLayer(currentFile, tideFile)
        return list(layer.getFeatures(QgsFeatureRequest().setFilterExpression(expression)))

    def generateAssertions(self, feature):
        for name in feature.fields().names():
            print("self.assertEqual(feature['{}'], {})".format(name, repr(feature[name])))

    def cleanUp(self):
        for layer in QgsProject.instance().mapLayers():
            QgsProject.instance().removeMapLayer(layer)
        PredictionExpressions.unregisterFunctions()
       
class StationsTest(unittest.TestCase):
    def setUp(self):
        self.fixtures = StationsFixtures()
        return

    def tearDown(self):
        self.fixtures.cleanUp()
        return

    @patch('requests.get')
    def test_request_url(self, mockGet):
        self.fixtures.alg.parameters['CurrentMetadataURI'] = 'http://example.com'
        self.fixtures.alg.parameters['TideMetadataURI'] = ''
        mockGet.return_value = self.fixtures.getMockRequest('currentSubordinate.xml')
        dest_id = self.fixtures.alg.getStations()
        mockGet.assert_called_once_with('http://example.com', timeout=30)

    @patch('requests.get')
    def test_bad_request(self, mockGet):
        self.fixtures.alg.parameters['CurrentMetadataURI'] = 'http://example.com'
        self.fixtures.alg.parameters['TideMetadataURI'] = ''
        mockGet.return_value = self.fixtures.getMockRequest('currentSubordinate.xml', 400)
        with self.assertRaises(QgsProcessingException):
            dest_id = self.fixtures.alg.getStations()

    def test_layers_already_exist(self):
        dest = self.fixtures.getFixtureLayer('currentRefSub.xml')
        with self.assertRaises(QgsProcessingException):
            dest = self.fixtures.getFixtureLayer('currentRefSub.xml')

    def test_add_current_subordinate(self):
        features = self.fixtures.getFeatures('currentSubordinate.xml', '', "station = 'ACT0926_1'")
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['station'], 'ACT0926_1')
        self.assertEqual(feature['id'], 'ACT0926')
        self.assertEqual(feature['name'], 'Bass Point, 1.2 n.mi. southeast of')
        self.assertEqual(feature['flags'], StationFlags.Current | StationFlags.Surface)
        self.assertTrue(feature['current'])
        self.assertTrue(feature['surface'])
        self.assertFalse(feature['reference'])
        self.assertEqual(feature['timeZoneId'], 'America/New_York')
        self.assertEqual(feature['timeZoneUTC'], 'UTC-05:00')
        self.assertEqual(feature['refStation'], 'BOS1111_14')
        self.assertEqual(feature['bin'], '1')
        self.assertEqual(feature['depth'], 10.0)
        self.assertEqual(feature['depthType'], 'S')
        self.assertEqual(feature['meanFloodDir'], 259.0)
        self.assertEqual(feature['meanEbbDir'], 66.0)
        self.assertEqual(feature['maxTimeAdj'], 85.0)
        self.assertEqual(feature['fallingZeroTimeAdj'], 53.0)
        self.assertEqual(feature['minTimeAdj'], -26.0)
        self.assertEqual(feature['risingZeroTimeAdj'], -31.0)
        self.assertEqual(feature['maxValueAdj'], 0.6)
        self.assertEqual(feature['minValueAdj'], 0.6) 
 
    def test_add_current_harmonic(self):
        features = self.fixtures.getFeatures('currentHarmonic.xml', '', "station = 'BOS1111_14'")
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['station'], 'BOS1111_14')
        self.assertEqual(feature['id'], 'BOS1111')
        self.assertEqual(feature['name'], 'Boston Harbor (Deer Island Light)')
        self.assertEqual(feature['flags'],  StationFlags.Current | StationFlags.Surface | StationFlags.Reference)
        self.assertTrue(feature['current'])
        self.assertTrue(feature['surface'])
        self.assertTrue(feature['reference'])
        self.assertEqual(feature['timeZoneId'], 'America/New_York')
        self.assertEqual(feature['timeZoneUTC'], 'UTC-05:00')
        self.assertEqual(feature['refStation'], NULL)
        self.assertEqual(feature['bin'], '14')
        self.assertEqual(feature['depth'], 8.0)
        self.assertEqual(feature['depthType'], 'B')
        self.assertEqual(feature['meanFloodDir'], 264.0)
        self.assertEqual(feature['meanEbbDir'], 112.0)
        self.assertEqual(feature['maxTimeAdj'], NULL)
        self.assertEqual(feature['fallingZeroTimeAdj'], NULL)
        self.assertEqual(feature['minTimeAdj'], NULL)
        self.assertEqual(feature['risingZeroTimeAdj'], NULL)
        self.assertEqual(feature['maxValueAdj'], NULL)
        self.assertEqual(feature['minValueAdj'], NULL)

    def test_add_tide_harmonic(self):
        features = self.fixtures.getFeatures('', 'tideRefSub.xml', "station = '8443970'")
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['station'], '8443970')
        self.assertEqual(feature['id'], '8443970')
        self.assertEqual(feature['name'], 'BOSTON')
        self.assertEqual(feature['flags'],  StationFlags.Tide | StationFlags.Surface | StationFlags.Reference)
        self.assertFalse(feature['current'])
        self.assertTrue(feature['surface'])
        self.assertTrue(feature['reference'])
        self.assertEqual(feature['timeZoneId'], 'America/New_York')
        self.assertEqual(feature['timeZoneUTC'], 'UTC-05:00')
        self.assertEqual(feature['refStation'], NULL)
        self.assertEqual(feature['maxTimeAdj'], 0)
        self.assertEqual(feature['minTimeAdj'], 0)
        self.assertEqual(feature['maxValueAdj'], 0)
        self.assertEqual(feature['minValueAdj'], 0)

    def test_add_tide_subordinate(self):
        features = self.fixtures.getFeatures('', 'tideRefSub.xml', "station = '8447291'")
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['station'], '8447291')
        self.assertEqual(feature['id'], '8447291')
        self.assertEqual(feature['name'], 'Pleasant Bay & Tyler Too')
        self.assertEqual(feature['flags'],  StationFlags.Tide | StationFlags.Surface)
        self.assertFalse(feature['current'])
        self.assertTrue(feature['surface'])
        self.assertFalse(feature['reference'])
        self.assertEqual(feature['timeZoneId'], 'America/New_York')
        self.assertEqual(feature['timeZoneUTC'], 'UTC-05:00')
        self.assertEqual(feature['refStation'], '8443970')
        self.assertEqual(feature['maxTimeAdj'], 148)
        self.assertEqual(feature['minTimeAdj'], 207)
        self.assertEqual(feature['maxValueAdj'], 0.34)
        self.assertEqual(feature['minValueAdj'], 0.34)

    def test_add_tide_subordinate_fixed(self):
        features = self.fixtures.getFeatures('', 'tideRefSub.xml', "station = '9440574'")
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['station'], '9440574')
        self.assertEqual(feature['id'], '9440574')
        self.assertEqual(feature['flags'],  StationFlags.Tide | StationFlags.Surface | StationFlags.FixedAdj)

    def test_detect_surface(self):
        dest = self.fixtures.getFixtureLayer('currentMultiDepth.xml')

        features = list(dest.getFeatures(QgsFeatureRequest().setFilterExpression("id = 'ACT0926'")))
        self.assertEqual(len(features), 3)

        features = list(dest.getFeatures(QgsFeatureRequest().setFilterExpression("station = 'ACT0926_1'")))
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['depth'], 10.0)
        self.assertTrue(feature['flags'] & StationFlags.Surface)

        features = list(dest.getFeatures(QgsFeatureRequest().setFilterExpression("station = 'ACT0926_2'")))
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['depth'], 45.0)
        self.assertFalse(feature['flags'] & StationFlags.Surface)

        features = list(dest.getFeatures(QgsFeatureRequest().setFilterExpression("station = 'ACT0926_3'")))
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['depth'], 60.0)
        self.assertFalse(feature['flags'] & StationFlags.Surface)

    def test_layer_utilities(self):
        stationsLayer = getStationsLayer()
        predictionsLayer = getPredictionsLayer()
        self.assertIsNone(stationsLayer)        
        self.assertIsNone(predictionsLayer)
        
        dest = self.fixtures.getFixtureLayer('currentRefSub.xml')

        stationsLayer = getStationsLayer()
        self.assertIsInstance(stationsLayer,QgsVectorLayer)
        self.assertEqual(stationsLayer.storageType(),'GPKG')

        features = list(dest.getFeatures(QgsFeatureRequest().setFilterExpression("station = 'BOS1111_14'")))
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['station'], 'BOS1111_14')
        self.assertEqual(stationTimeZone(feature).id(), 'America/New_York')

        predictionsLayer = getPredictionsLayer()
        self.assertIsInstance(predictionsLayer,QgsVectorLayer)
        self.assertEqual(predictionsLayer.storageType(),'GPKG')

    def test_prediction_station_join(self):
        dest = self.fixtures.getFixtureLayer('currentRefSub.xml')

        predictionsLayer = getPredictionsLayer()
        feature = QgsFeature(predictionsLayer.fields())
        feature['station'] = 'BOS1111_14'
        feature['time'] = QDateTime(2020, 1, 2, 3, 0, 0, 0, Qt.TimeSpec.UTC)
        predictionsLayer.startEditing()
        predictionsLayer.addFeature(feature)
        predictionsLayer.commitChanges()
        features = list(predictionsLayer.getFeatures(QgsFeatureRequest().setFilterExpression("station = 'BOS1111_14'")))
        self.assertEqual(len(features), 1)
        feature = features[0]

        self.assertEqual(feature['station_name'],'Boston Harbor (Deer Island Light)')
        self.assertEqual(feature['station_timeZoneId'],'America/New_York')
        self.assertEqual(feature['station_timeZoneUTC'],'UTC-05:00')

        time = feature['time']
        time.setTimeSpec(Qt.TimeSpec.UTC)
        self.assertEqual(time, QDateTime(2020, 1, 2, 3, 0, 0, 0, Qt.TimeSpec.UTC))

        localTime = time.toTimeZone(QTimeZone(b'America/New_York'))
        print(localTime)
        self.assertEqual(feature['local_time'],localTime)

        self.assertEqual(feature['display_date'],'01/01')
        self.assertEqual(feature['display_time'],'10:00 pm')


if __name__ == "__main__":
    suite = unittest.makeSuite(StationsTest)
    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(suite)
