from .utilities import get_qgis_app

import unittest
from unittest.mock import *
import os

from qgis.PyQt.QtCore import QCoreApplication, QDateTime, QUrl
from qgis.PyQt.QtNetwork import QNetworkReply

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

    def getPredictions(self, filename, station, datetime, type, url=None, parseError=False):
        cpr = CurrentPredictionRequest(
            self.pm,
            station,
            datetime, datetime.addDays(1),
            type)
        resolved = Mock()
        cpr.resolved(resolved)
        rejected = Mock()
        cpr.rejected(rejected)
        cpr.fetcher.fetchContent = Mock(name='fetchContent')

        cpr.start()

        if url:
            cpr.fetcher.fetchContent.assert_called_once_with(url)
                
        with open(os.path.join(os.path.dirname(__file__), 'data', filename), 'r') as dataFile:
            cpr.fetcher.contentAsString = Mock(return_value=dataFile.read())
        cpr.processReply()

        if parseError:
            rejected.assert_called_once()
            return None
        else:
            resolved.assert_called_once()
            return cpr.predictions


    def test_current_request_error(self):
        features = self.getPredictions(
            'error.xml',
            self.subStation,
            QDateTime(2020,1,1,5,0),
            CurrentPredictionRequest.EventType,
            None,
            QNetworkReply.ContentNotFoundError)

        self.assertEqual(features, None)

    def test_current_event_requests(self):
        url = QUrl('https://api.tidesandcurrents.noaa.gov/api/prod/datagetter'
             '?application=qgis-noaa-tidal-predictions&begin_date=20200101 05:00&end_date=20200102 04:59'
             '&units=english&time_zone=gmt&product=currents_predictions&format=xml'
             '&station=ACT0926&bin=1&interval=MAX_SLACK')
        features = self.getPredictions(
            'ACT0926_1-20200101-max_slack.xml',
            self.subStation,
            QDateTime(2020,1,1,5,0),
            CurrentPredictionRequest.EventType,
            url)
        self.assertEqual(len(features), 8)
        feature = features[0]
        self.assertEqual(feature['station'], 'ACT0926_1')
        self.assertEqual(feature['depth'], 10.0)
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 6, 49, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], 0.62)
        self.assertEqual(feature['type'], 'flood')
        self.assertEqual(feature['dir'], 259.0)
        self.assertEqual(feature['magnitude'], 0.62)

        feature = features[1]
        self.assertEqual(feature['type'], 'slack')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 59, 0, 0, Qt.TimeSpec.UTC))

        feature = features[2]
        self.assertEqual(feature['type'], 'ebb')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 11, 46, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], -0.58)
        self.assertEqual(feature['dir'], 66.0)
        self.assertEqual(feature['magnitude'], 0.58)

    def test_current_speed_dir_requests(self):
        url = QUrl('https://api.tidesandcurrents.noaa.gov/api/prod/datagetter?'
            'application=qgis-noaa-tidal-predictions&begin_date=20200101 05:00&end_date=20200102 04:59'
            '&units=english&time_zone=gmt&product=currents_predictions&format=xml'
            '&station=BOS1111&bin=14&vel_type=speed_dir&interval=30')
        features = self.getPredictions(
            'BOS1111_14-20200101-speed_dir.xml',
            self.refStation,
            QDateTime(2020,1,1,5,0),
            CurrentPredictionRequest.SpeedDirectionType,
            url)
        self.assertEqual(len(features), 48)
        # strong flood current
        feature = features[0]
        self.assertEqual(feature['station'], 'BOS1111_14')
        self.assertEqual(feature['depth'], 8.0)
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 5, 0, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 1.0613531)
        self.assertEqual(feature['type'], 'current')
        self.assertEqual(feature['dir'], 262.0)
        self.assertEqual(feature['magnitude'], 1.062)
        # just on the flood side of the transition
        feature = features[6]
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 0, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 0.0774541)   # cosine-rule projection
        self.assertEqual(feature['type'], 'current')
        self.assertEqual(feature['dir'], 190.0)
        self.assertEqual(feature['magnitude'], 0.281)
        # just on the ebb side of the transition
        feature = features[7]
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 30, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], -0.1067157)   # cosine-rule projection
        self.assertEqual(feature['type'], 'current')
        self.assertEqual(feature['dir'], 185.0)
        self.assertEqual(feature['magnitude'], 0.365)

    def test_current_vel_major_requests(self):
        url = QUrl('https://api.tidesandcurrents.noaa.gov/api/prod/datagetter?'
            'application=qgis-noaa-tidal-predictions&begin_date=20200101 05:00&end_date=20200102 04:59'
            '&units=english&time_zone=gmt&product=currents_predictions&format=xml'
            '&station=BOS1111&bin=14&vel_type=default&interval=30')
        features = self.getPredictions(
            'BOS1111_14-20200101-vel_major.xml',
            self.refStation,
            QDateTime(2020,1,1,5,0),
            CurrentPredictionRequest.VelocityMajorType,
            url)
        self.assertEqual(len(features), 48)
        # strong flood current
        feature = features[0]
        self.assertEqual(feature['station'], 'BOS1111_14')
        self.assertEqual(feature['depth'], 8.0)
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 5, 0, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], 1.03)
        self.assertEqual(feature['type'], 'current')
        self.assertEqual(feature['dir'], 264.0)
        self.assertEqual(feature['magnitude'], 1.03)
        # just on the flood side of the transition
        feature = features[6]
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 0, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], 0.08)
        self.assertEqual(feature['type'], 'current')
        self.assertEqual(feature['dir'], 264.0)
        self.assertEqual(feature['magnitude'], 0.08)
        # just on the ebb side of the transition
        feature = features[7]
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 30, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], -0.21)   # cosine-rule projection
        self.assertEqual(feature['type'], 'current')
        self.assertEqual(feature['dir'], 112.0)
        self.assertEqual(feature['magnitude'], 0.21)

    def test_prediction_manager(self):
        return

if __name__ == "__main__":
    suite = unittest.makeSuite(PredictionManagerTest)
    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(suite)
