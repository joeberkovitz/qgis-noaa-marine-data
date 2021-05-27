from .utilities import get_qgis_app

import unittest
from unittest.mock import *
import os

from qgis.PyQt.QtCore import pyqtSlot, pyqtSignal, QCoreApplication, QDateTime, QUrl, QUrlQuery
from qgis.PyQt.QtNetwork import QNetworkReply

from qgis.core import (
    QgsFeature,
    QgsFields,
    QgsWkbTypes,
    QgsMemoryProviderUtils,
    QgsNetworkContentFetcher,
    NULL
    )

from noaa_tidal_predictions.prediction_manager import *
from noaa_tidal_predictions.utils import *
from .test_add_current_stations import CurrentStationsFixtures

QGIS_APP = get_qgis_app()

class PredictionManagerTest(unittest.TestCase):
    request_urls = None

    """Test translations work."""

    def setUp(self):
        self.currentFixtures = CurrentStationsFixtures()
        self.currentStationsLayer = self.currentFixtures.getFixtureLayer('currentRefSub.xml')
        self.subStation = next(self.currentStationsLayer.getFeatures(
            QgsFeatureRequest().setFilterExpression("station = 'ACT0926_1'")))
        self.refStation = next(self.currentStationsLayer.getFeatures(
            QgsFeatureRequest().setFilterExpression("station = 'BOS1111_14'")))

        self.currentPredictionsLayer = currentPredictionsLayer()
        self.pm = PredictionManager(self.currentStationsLayer, self.currentPredictionsLayer)

        PredictionManagerTest.request_urls = []

        return

    def tearDown(self):
        self.currentFixtures.cleanUp()
        return

    def print_predictions(self, predictions):
        for feature in predictions:
            print('{} {} {} {} {}'.format(feature['station'],feature['time'].toString('yyyyMMdd hh:mm'),feature['type'],feature['dir'],feature['value']))

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


    """ This patch to the doStart() method of PredictionRequest causes files to be loaded
        from a fixture rather than from the network.
    """
    def mock_doStart(self):
        PredictionManagerTest.request_urls.append(self.url())

        query = QUrlQuery(QUrl(self.url()))
        query_date = query.queryItemValue('begin_date').replace(' ','T')
        query_vel_type = query.queryItemValue('vel_type')
        query_interval = query.queryItemValue('interval')
        query_station = query.queryItemValue('station')
        query_bin = query.queryItemValue('bin')
        filename = '{}_{}-{}-{}-{}.xml'.format(query_station,query_bin,query_date,query_vel_type,query_interval)
        self.fetcher = Mock(QgsNetworkContentFetcher)
        with open(os.path.join(os.path.dirname(__file__), 'data', filename), 'r') as dataFile:
            self.fetcher.contentAsString = Mock(return_value=dataFile.read())
        self.processReply()


    """ Test the ability to mock out PredictionRequests by loading files based on query parameters
        without touching any other classes.
    """
    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_mocked_request(self):
        self.assertEqual(len(PredictionManagerTest.request_urls), 0)
        resolver = Mock()
        datetime = QDateTime(2020,1,1,5,0)
        cpr = CurrentPredictionRequest(
            self.pm,
            self.subStation,
            datetime, datetime.addDays(1),
            CurrentPredictionRequest.EventType)
        cpr.resolved(resolver)
        resolver.assert_not_called()
        cpr.start()
        resolver.assert_called_once()
        self.assertEqual(len(cpr.predictions), 8)
        self.assertEqual(len(PredictionManagerTest.request_urls), 1)
        self.assertEqual(PredictionManagerTest.request_urls[0], 'https://api.tidesandcurrents.noaa.gov/api/prod/datagetter?application=qgis-noaa-tidal-predictions&begin_date=20200101 05:00&end_date=20200102 04:59&units=english&time_zone=gmt&product=currents_predictions&format=xml&station=ACT0926&bin=1&interval=MAX_SLACK')

    """ Test a PredictionDataPromise for a harmonic station with known flood/ebb directions
    """
    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_harmonic_prediction_data_promise(self):
        datetime = QDate(2020,1,1)
        pdp = PredictionDataPromise(
            self.pm,
            self.refStation,
            datetime)
        pdp.start()
        features = pdp.predictions
        self.assertEqual(len(features), 56)  # 48 time intervals plus 8 events

        # verify that the data is present and sorted in the way we would expect

        feature = features[0]
        self.assertEqual(feature['station'], 'BOS1111_14')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 5, 0, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 1.0613530582942798)
        self.assertEqual(feature['type'], 'current')
        self.assertEqual(feature['dir'], 262.0)
        self.assertEqual(feature['magnitude'], 1.062)

        feature = features[1]
        # BOS1111_14 20200101 05:24 flood 264.0 1.04
        self.assertEqual(feature['station'], 'BOS1111_14')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 5, 24, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], 1.04)
        self.assertEqual(feature['type'], 'flood')
        self.assertEqual(feature['dir'], 264.0)

        # just on the flood side of the transition
        feature = features[7]
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 0, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 0.0774541)   # cosine-rule projection
        self.assertEqual(feature['type'], 'current')
        self.assertEqual(feature['dir'], 190.0)
        self.assertEqual(feature['magnitude'], 0.281)

        feature = features[8]
        # BOS1111_14 20200101 08:06 slack 264.0 0.02
        self.assertEqual(feature['station'], 'BOS1111_14')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 6, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], 0.02)
        self.assertEqual(feature['type'], 'slack')
        self.assertEqual(feature['dir'], 264.0)

        # just on the ebb side of the transition
        feature = features[9]
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 30, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], -0.1067157)   # cosine-rule projection
        self.assertEqual(feature['type'], 'current')
        self.assertEqual(feature['dir'], 185.0)
        self.assertEqual(feature['magnitude'], 0.365)

        # verify that value interpolation is working
        interp = pdp.valueInterpolation()([0, 3*3600, 3.5*3600, 3.499*3600])
        self.assertAlmostEqual(interp[0], 1.06135306)
        self.assertAlmostEqual(interp[1], 0.0774541)
        self.assertAlmostEqual(interp[2], -0.1067157)
        self.assertAlmostEqual(interp[3], -0.10613375)

    """ Test a PredictionDataPromise for a harmonic station with Unknown flood/ebb directions
    """
    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_no_flood_ebb_prediction_data_promise(self):
        self.refStation = next(self.currentStationsLayer.getFeatures(
            QgsFeatureRequest().setFilterExpression("station = 'SFB1212_9'")))
        datetime = QDate(2020,1,1)
        pdp = PredictionDataPromise(
            self.pm,
            self.refStation,
            datetime)
        pdp.start()
        features = pdp.predictions
        self.assertEqual(len(features), 56)  # 48 time intervals plus 8 events

        # verify that the data is present and sorted in the way we would expect

        feature = features[0]
        self.assertEqual(feature['station'], 'SFB1212_9')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 0, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 0.62)
        self.assertAlmostEqual(feature['magnitude'], 0.672)
        self.assertEqual(feature['type'], 'current')
        self.assertEqual(feature['dir'], 35.0)

        feature = features[4]
        self.assertEqual(feature['station'], 'SFB1212_9')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 9, 36, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], 1.22)
        self.assertAlmostEqual(feature['magnitude'], 1.22)
        self.assertEqual(feature['type'], 'flood')
        self.assertEqual(feature['dir'], NULL)


    """ Test a PredictionDataPromise for a harmonic station with known flood/ebb directions
    """
    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_subordinate_prediction_data_promise(self):
        datetime = QDate(2020,1,1)
        pdp = PredictionDataPromise(
            self.pm,
            self.subStation,
            datetime)
        pdp.start()
        features = pdp.predictions
        self.assertEqual(len(features), 48)  # 40 time intervals plus 8 events

        currents = list(filter(lambda p: p['type'] == 'current', features))
        self.assertEqual(len(currents), 40)
        events = list(filter(lambda p: p['type'] != 'current', features))
        self.assertEqual(len(events), 8)

        feature = events[0]
        self.assertEqual(feature['station'], 'ACT0926_1')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 6, 49, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], 0.62)
        self.assertEqual(feature['type'], 'flood')
        self.assertEqual(feature['dir'], 259.0)
        self.assertEqual(feature['magnitude'], 0.62)

        feature = currents[4]
        self.assertEqual(feature['station'], 'ACT0926_1')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 49, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 0.08397517)
        self.assertEqual(feature['type'], 'current')
        self.assertEqual(feature['dir'], 259.0)
        self.assertAlmostEqual(feature['magnitude'], 0.08397517)


    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_prediction_data_promise_layer_cache(self):
        datetime = QDate(2020,1,1)
        pdp1 = PredictionDataPromise(
            self.pm,
            self.refStation,
            datetime)
        pdp1.start()
        self.assertEqual(len(pdp1.predictions), 56)  # 48 time intervals plus 8 events
        self.assertEqual(len(PredictionManagerTest.request_urls), 2) # events and currents

        # the second call should pull the data from the predictions layer with no new requests
        pdp2 = PredictionDataPromise(
            self.pm,
            self.refStation,
            datetime)
        pdp2.start()
        self.assertEqual(len(pdp2.predictions), 56)  # 48 time intervals plus 8 events
        self.assertEqual(len(PredictionManagerTest.request_urls), 2)

        # Verify that this is not just the same object being coughed up
        self.assertIsNot(pdp2, pdp1)

        # This is for a different date, so new requests again
        datetime = QDate(2020,1,2)
        pdp3 = PredictionDataPromise(
            self.pm,
            self.refStation,
            datetime)
        pdp3.start()
        self.assertEqual(len(pdp3.predictions), 56)  # 48 time intervals plus 8 events
        self.assertEqual(len(PredictionManagerTest.request_urls), 4)

    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_prediction_data_promise_object_cache(self):
        datetime = QDate(2020,1,1)
        pdp1 = self.pm.getDataPromise(
            self.refStation,
            datetime)
        self.assertEqual(len(pdp1.predictions), 56)  # 48 time intervals plus 8 events
        self.assertEqual(len(PredictionManagerTest.request_urls), 2) # events and currents

        # the second call should return exactly the same promise object
        pdp2 = self.pm.getDataPromise(
            self.refStation,
            datetime)
        self.assertEqual(len(pdp2.predictions), 56)  # 48 time intervals plus 8 events
        self.assertEqual(len(PredictionManagerTest.request_urls), 2)

        # Verify that this IS just the same object being coughed up
        self.assertIs(pdp2, pdp1)

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
            'ACT0926_1-20200101T05:00--MAX_SLACK.xml',
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
            'BOS1111_14-20200101T05:00-speed_dir-30.xml',
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
        # note that end time is 04:58, to work around a CO-OPS server side caching bug (see CurrentPredictionManager source)
        url = QUrl('https://api.tidesandcurrents.noaa.gov/api/prod/datagetter?'
            'application=qgis-noaa-tidal-predictions&begin_date=20200101 05:00&end_date=20200102 04:58'
            '&units=english&time_zone=gmt&product=currents_predictions&format=xml'
            '&station=BOS1111&bin=14&vel_type=default&interval=30')
        features = self.getPredictions(
            'BOS1111_14-20200101T05:00-default-30.xml',
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

    def test_extent_stations(self):
        # BOS1111
        lat = 42.33778
        lng = -70.95578
        d = 0.0001
        rect = QgsRectangle(lng-d, lat-d, lng+d, lat+d)
        stations = self.pm.getExtentStations(rect)
        self.assertEqual(len(stations), 1)
        self.assertEqual(stations[0]['station'], 'BOS1111_14')

        lat += 0.1
        rect = QgsRectangle(lng-d, lat-d, lng+d, lat+d)
        stations = self.pm.getExtentStations(rect)
        self.assertEqual(len(stations), 0)

    def test_get_station(self):
        station = self.pm.getStation('BOS1111_14')
        self.assertEqual(station['station'], 'BOS1111_14')

        station = self.pm.getStation('BOS1111_15')
        self.assertIsNone(station)


if __name__ == "__main__":
    suite = unittest.makeSuite(PredictionManagerTest)
    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(suite)
