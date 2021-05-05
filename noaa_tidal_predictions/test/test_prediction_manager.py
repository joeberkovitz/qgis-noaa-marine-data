from .utilities import get_qgis_app

import unittest
from unittest.mock import *
import os

from qgis.PyQt.QtCore import QCoreApplication, QDateTime, QUrl
from qgis.core import (
    QgsFeature,
    QgsFields,
    QgsWkbTypes,
    QgsMemoryProviderUtils,
    NULL
    )

from noaa_tidal_predictions.prediction_manager import *
from noaa_tidal_predictions.utils import epsg4326
from .test_add_current_stations import CurrentStationsFixtures

QGIS_APP = get_qgis_app()


class PredictionManagerTest(unittest.TestCase):
    """Test translations work."""

    def setUp(self):
        self.currentFixtures = CurrentStationsFixtures()
        self.currentStationLayer = self.currentFixtures.getFixtureLayer('currentRefSub.xml')
        self.subStation = next(self.currentStationLayer.getFeatures(
            QgsFeatureRequest().setFilterExpression("station = 'ACT0926_1'")))
        self.refStation = next(self.currentStationLayer.getFeatures(
            QgsFeatureRequest().setFilterExpression("station = 'BOS1111_14'")))

        self.currentPredictionLayer = QgsMemoryProviderUtils.createMemoryLayer(
            'predictions', self.currentFixtures.alg.currentPredictionFields(), QgsWkbTypes.Point, epsg4326
        )
        self.pm = PredictionManager(self.currentStationLayer, self.currentPredictionLayer)
        return

    def tearDown(self):
        return

    def getPredictions(self, filename, station, datetime, type, url=None):
        cpr = CurrentPredictionRequest(
            self.pm,
            station,
            datetime, datetime.addDays(1),
            type)
        cpr.fetcher.fetchContent = Mock()
        cpr.start()

        if url:
            cpr.fetcher.fetchContent.assert_called_once_with(url)
                
        with open(os.path.join(os.path.dirname(__file__), 'data', filename), 'r') as dataFile:
            cpr.fetcher.contentAsString = Mock(return_value=dataFile.read())
        cpr.processReply()
        return cpr.predictions

    def test_current_prediction_request(self):
        url = QUrl('https://api.tidesandcurrents.noaa.gov/api/prod/datagetter'
             '?application=qgis-noaa-tidal-predictions&begin_date=20200101 00:00&end_date=20200101 23:59'
             '&units=english&time_zone=gmt&product=currents_predictions&format=xml'
             '&station=ACT0926&bin=1&interval=MAX_SLACK')
        features = self.getPredictions(
            'ACT0926_1-20200101-event.xml',
            self.subStation,
            QDateTime(2020,1,1,0,0),
            CurrentPredictionRequest.EventType,
            url)
        self.assertEqual(len(features), 1)
        feature = features[0]
        self.assertEqual(feature['station'], 'ACT0926_1')
        self.assertEqual(feature['depth'], 10.0)
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 6, 49, 0, 0, Qt.TimeSpec(1)))
        self.assertEqual(feature['value'], 0.62)
        self.assertEqual(feature['type'], 'flood')
        self.assertEqual(feature['dir'], 259.0)
        self.assertEqual(feature['magnitude'], 0.62)

    def test_prediction_manager(self):
        return

if __name__ == "__main__":
    suite = unittest.makeSuite(PredictionManagerTest)
    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(suite)
