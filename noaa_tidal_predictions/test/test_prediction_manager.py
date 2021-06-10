from .utilities import get_qgis_app

import unittest
from unittest.mock import *
import os

import requests

from qgis.PyQt.QtCore import pyqtSlot, pyqtSignal, QCoreApplication, QDateTime, QUrl, QUrlQuery
from qgis.PyQt.QtNetwork import QNetworkReply

from qgis.core import (
    QgsFeature,
    QgsFields,
    QgsWkbTypes,
    QgsMemoryProviderUtils,
    QgsNetworkContentFetcherTask,
    NULL
    )

from noaa_tidal_predictions.prediction_manager import *
from noaa_tidal_predictions.utils import *
from .test_add_stations import StationsFixtures

QGIS_APP = get_qgis_app()


class PredictionManagerTest(unittest.TestCase):
    request_urls = None
    download_data_files = False    # set to True to download new data files that don't exist yet

    """Test suite for many aspects of PredictionManager and its associated classes. """

    def setUp(self):
        self.fixtures = StationsFixtures()
        self.stationsLayer = self.fixtures.getFixtureLayer('currentRefSub.xml','tideRefSub.xml')
        self.subCurrentStation = next(self.stationsLayer.getFeatures(
            QgsFeatureRequest().setFilterExpression("station = 'ACT0926_1'")))
        self.refCurrentStation = next(self.stationsLayer.getFeatures(
            QgsFeatureRequest().setFilterExpression("station = 'BOS1111_14'")))
        self.refTideStation = next(self.stationsLayer.getFeatures(
            QgsFeatureRequest().setFilterExpression("station = '8443970'")))
        self.subTideStation = next(self.stationsLayer.getFeatures(
            QgsFeatureRequest().setFilterExpression("station = '8447291'")))
        self.refFixedTideStation = next(self.stationsLayer.getFeatures(
            QgsFeatureRequest().setFilterExpression("station = '9439040'")))
        self.subFixedTideStation = next(self.stationsLayer.getFeatures(
            QgsFeatureRequest().setFilterExpression("station = '9440574'")))

        self.predictionsLayer = getPredictionsLayer()
        self.pm = PredictionManager(self.stationsLayer, self.predictionsLayer)

        PredictionManagerTest.request_urls = []

        return

    def tearDown(self):
        self.fixtures.cleanUp()
        return

    def timeToSecs(self, timeString):
        return QTime(0,0).secsTo(QTime.fromString(timeString))

    def print_predictions(self, predictions):
        for feature in predictions:
            print('{} {} {} {} {}'.format(feature['station'],feature['time'].toString('yyyyMMdd hh:mm'),feature['flags'],feature['dir'],feature['value']))

    def getPredictions(self, filename, station, datetime, type, url=None, parseError=False):
        if station['flags'] & StationFlags.Current:
            pr = CurrentPredictionRequest(
                self.pm,
                station,
                datetime, datetime.addDays(1),
                type)
        else:
            pr = TidePredictionRequest(
                self.pm,
                station,
                datetime, datetime.addDays(1),
                type)
        resolved = Mock()
        pr.resolved(resolved)
        rejected = Mock()
        pr.rejected(rejected)

        pr.start()

        if url:
            self.assertIsNotNone(pr.fetcher)
                
        pr.fetcher = Mock(QgsNetworkContentFetcherTask)
        with open(os.path.join(os.path.dirname(__file__), 'data', filename), 'r') as dataFile:
            pr.content = dataFile.read()
        pr.processFinish()

        if parseError:
            rejected.assert_called_once()
            return None
        else:
            resolved.assert_called_once()
            return pr.predictions


    def mock_doStartPrepare(self):
        PredictionManagerTest.request_urls.append(self.url())

        query = QUrlQuery(QUrl(self.url()))
        query_date = query.queryItemValue('begin_date').replace(' ','T')
        query_vel_type = query.queryItemValue('vel_type')
        query_interval = query.queryItemValue('interval')
        query_station = query.queryItemValue('station')
        query_bin = query.queryItemValue('bin')
        if query_bin:
            filename = '{}_{}-{}-{}-{}.xml'.format(query_station,query_bin,query_date,query_vel_type,query_interval)
        else:
            filename = '{}-{}-{}-{}.xml'.format(query_station,query_date,query_vel_type,query_interval)
        self.fetcher = Mock(QgsNetworkContentFetcherTask)
        path = os.path.join(os.path.dirname(__file__), 'data', filename)

        if PredictionManagerTest.download_data_files and not os.path.exists(path):
            print('downloading ', filename)
            r = requests.get(self.url())
            with open(path, 'w') as dataFile:
                dataFile.write(r.text)

        with open(path, 'r') as dataFile:
            self.content = dataFile.read()

    """ This patch to the doStart() method of PredictionRequest causes files to be loaded
        from a fixture rather than from the network.
    """
    def mock_doStart(self):
        PredictionManagerTest.mock_doStartPrepare(self)
        self.processFinish()


    """ Test the ability to mock out CurrentPredictionRequests by loading files based on query parameters
        without touching any other classes. Also verifies generated URL contents.
    """
    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_mocked_current_request(self):
        self.assertEqual(len(PredictionManagerTest.request_urls), 0)
        resolver = Mock()
        datetime = QDateTime(2020,1,1,5,0)
        cpr = CurrentPredictionRequest(
            self.pm,
            self.subCurrentStation,
            datetime, datetime.addDays(1),
            CurrentPredictionRequest.EventType)
        cpr.resolved(resolver)
        resolver.assert_not_called()
        cpr.start()
        resolver.assert_called_once()
        self.assertEqual(len(cpr.predictions), 9)
        self.assertEqual(len(PredictionManagerTest.request_urls), 1)
        self.assertEqual(PredictionManagerTest.request_urls[0],
            'https://api.tidesandcurrents.noaa.gov/api/prod/datagetter?application=qgis-noaa-tidal-predictions&begin_date=20200101 05:00&end_date=20200102 04:59&units=english&time_zone=gmt&product=currents_predictions&format=xml&station=ACT0926&bin=1&interval=MAX_SLACK')

    """ Test the ability to mock out TidePredictionRequests by loading files based on query parameters
        without touching any other classes. Also verifies generated URL contents.
    """
    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_mocked_tide_request(self):
        self.assertEqual(len(PredictionManagerTest.request_urls), 0)
        resolver = Mock()
        datetime = QDateTime(2020,1,1,5,0)
        cpr = TidePredictionRequest(
            self.pm,
            self.subTideStation,
            datetime, datetime.addDays(1),
            TidePredictionRequest.EventType)
        cpr.resolved(resolver)
        resolver.assert_not_called()
        cpr.start()
        resolver.assert_called_once()
        self.assertEqual(len(cpr.predictions), 4)
        self.assertEqual(len(PredictionManagerTest.request_urls), 1)
        self.maxDiff = None
        self.assertEqual(PredictionManagerTest.request_urls[0],
            'https://api.tidesandcurrents.noaa.gov/api/prod/datagetter?application=qgis-noaa-tidal-predictions&begin_date=20200101 05:00&end_date=20200102 04:59&units=english&time_zone=gmt&product=predictions&format=xml&datum=MLLW&station=8447291&interval=hilo')

    """ Test a CurrentDataPromise for a harmonic station with known flood/ebb directions
    """
    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_harmonic_current(self):
        datetime = QDate(2020,1,1)
        pdp = CurrentDataPromise(
            self.pm,
            self.refCurrentStation,
            datetime)
        pdp.start()
        features = pdp.predictions
        self.assertEqual(len(features), 56)  # 48 time intervals plus 8 events

        # verify that the data is present and sorted in the way we would expect

        feature = features[0]
        self.assertEqual(feature['station'], 'BOS1111_14')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 5, 0, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 1.0613530582942798)
        self.assertTrue(feature['flags'] & PredictionFlags.Time)
        self.assertEqual(feature['dir'], 262.0)
        self.assertEqual(feature['magnitude'], 1.062)

        feature = features[1]
        # BOS1111_14 20200101 05:24 flood 264.0 1.04
        self.assertEqual(feature['station'], 'BOS1111_14')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 5, 24, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], 1.04)
        self.assertTrue(feature['flags'] & PredictionFlags.Max)
        self.assertEqual(feature['dir'], 264.0)

        # just on the flood side of the transition
        feature = features[7]
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 0, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 0.0774541)   # cosine-rule projection
        self.assertTrue(feature['flags'] & PredictionFlags.Time)
        self.assertEqual(feature['dir'], 190.0)
        self.assertEqual(feature['magnitude'], 0.281)

        feature = features[8]
        # BOS1111_14 20200101 08:06 slack 264.0 0.02
        self.assertEqual(feature['station'], 'BOS1111_14')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 6, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], 0.02)
        self.assertTrue(feature['flags'] & PredictionFlags.Zero)
        self.assertEqual(feature['dir'], 264.0)

        # just on the ebb side of the transition
        feature = features[9]
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 30, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], -0.1067157)   # cosine-rule projection
        self.assertTrue(feature['flags'] & PredictionFlags.Time)
        self.assertEqual(feature['dir'], 185.0)
        self.assertEqual(feature['magnitude'], 0.365)

    """ Test a CurrentDataPromise for a harmonic station with Unknown flood/ebb directions
    """
    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_no_flood_ebb_current(self):
        self.refCurrentStation = next(self.stationsLayer.getFeatures(
            QgsFeatureRequest().setFilterExpression("station = 'SFB1212_9'")))
        datetime = QDate(2020,1,1)
        pdp = CurrentDataPromise(
            self.pm,
            self.refCurrentStation,
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
        self.assertTrue(feature['flags'] & PredictionFlags.Time)
        self.assertEqual(feature['dir'], 35.0)

        feature = features[4]
        self.assertEqual(feature['station'], 'SFB1212_9')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 9, 36, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], 1.22)
        self.assertAlmostEqual(feature['magnitude'], 1.22)
        self.assertTrue(feature['flags'] & PredictionFlags.Max)
        self.assertEqual(feature['dir'], NULL)


    """ Test a CurrentDataPromise for a harmonic station with known flood/ebb directions
    """
    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_subordinate_current(self):
        datetime = QDate(2020,1,2)
        pdp = CurrentDataPromise(
            self.pm,
            self.subCurrentStation,
            datetime)
        pdp.start()
        features = pdp.predictions
        self.assertEqual(len(features), 56)  # 40 time intervals plus 8 events

        currents = list(filter(lambda p: p['flags'] & PredictionFlags.Time, features))
        self.assertEqual(len(currents), 48)
        events = list(filter(lambda p: not p['flags'] & PredictionFlags.Time, features))
        self.assertEqual(len(events), 8)

        feature = events[0]
        self.assertEqual(feature['station'], 'ACT0926_1')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 2, 7, 49, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], 0.57)
        self.assertTrue(feature['flags'] & PredictionFlags.Max)
        self.assertEqual(feature['dir'], 259.0)
        self.assertEqual(feature['magnitude'], 0.57)
        self.assertTrue(feature['surface'])

        feature = currents[4]
        self.assertEqual(feature['station'], 'ACT0926_1')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 2, 7, 0, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 0.6826690037)
        self.assertTrue(feature['flags'] & PredictionFlags.Time)
        self.assertEqual(feature['dir'], 259.0)
        self.assertAlmostEqual(feature['magnitude'], 0.6826690037)
        self.assertTrue(feature['surface'])

    """ Test a TideDataPromise for a harmonic tide station
    """
    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_harmonic_tide(self):
        datetime = QDate(2020,1,1)
        pdp = TideDataPromise(
            self.pm,
            self.refTideStation,
            datetime)
        pdp.start()
        features = pdp.predictions
        self.assertEqual(len(features), 52)  # 48 time intervals plus 4 events

        # verify that the data is present and sorted in the way we would expect
        feature = features[0]
        self.assertEqual(feature['station'], '8443970')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 5, 0, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 4.098)
        self.assertTrue(feature['flags'] & PredictionFlags.Time)

        feature = features[7]
        self.assertEqual(feature['station'], '8443970')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 21, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 8.606)
        self.assertTrue(feature['flags'] & PredictionFlags.Max)

        feature = features[20]
        self.assertEqual(feature['station'], '8443970')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 14, 21, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], 1.578)
        self.assertTrue(feature['flags'] & PredictionFlags.Min)
        self.assertTrue(feature['surface'])

    """ Test a TideDataPromise for a subordinate tide station using ratio adjustment
    """
    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_subordinate_tide_ratio_adj(self):
        datetime = QDate(2020,1,2)
        pdp = TideDataPromise(
            self.pm,
            self.subTideStation,
            datetime)
        pdp.start()
        features = pdp.predictions
        self.assertEqual(len(features), 52)  # 48 time intervals plus 4 events

        # verify that the data is present and sorted in the way we would expect
        feature = features[0]
        self.assertEqual(feature['station'], '8447291')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 2, 5, 0, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 0.5804967373)
        self.assertTrue(feature['flags'] & PredictionFlags.Time)

        feature = features[3]
        self.assertEqual(feature['station'], '8447291')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 2, 6, 17, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 0.334)
        self.assertTrue(feature['flags'] & PredictionFlags.Min)

    """ Test a TideDataPromise for a subordinate tide station using fixed (offset) adjustment
    """
    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_subordinate_tide_fixed_adj(self):
        datetime = QDate(2020,1,2)
        pdp = TideDataPromise(
            self.pm,
            self.subFixedTideStation,
            datetime)
        pdp.start()
        features = pdp.predictions
        self.assertEqual(len(features), 52)  # 48 time intervals plus 4 events

        # verify that the data is present and sorted in the way we would expect
        feature = features[11]
        self.assertEqual(feature['time'], QDateTime(2020, 1, 2, 13, 30, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 6.84221308)
        self.assertTrue(feature['flags'] & PredictionFlags.Time)

        feature = features[12]
        self.assertEqual(feature['time'], QDateTime(2020, 1, 2, 13, 45, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 6.884)
        self.assertTrue(feature['flags'] & PredictionFlags.Max)

        feature = features[24]
        self.assertEqual(feature['time'], QDateTime(2020, 1, 2, 19, 30, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 3.34045046)
        self.assertTrue(feature['flags'] & PredictionFlags.Time)

        feature = features[25]
        self.assertEqual(feature['time'], QDateTime(2020, 1, 2, 19, 39, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 3.331)
        self.assertTrue(feature['flags'] & PredictionFlags.Min)

    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_prediction_data_promise_layer_cache(self):
        datetime = QDate(2020,1,1)
        pdp1 = CurrentDataPromise(
            self.pm,
            self.refCurrentStation,
            datetime)
        pdp1.start()
        self.assertEqual(len(pdp1.predictions), 56)  # 48 time intervals plus 8 events
        self.assertEqual(len(PredictionManagerTest.request_urls), 2) # events and currents

        # the second call should pull the data from the predictions layer with no new requests
        pdp2 = CurrentDataPromise(
            self.pm,
            self.refCurrentStation,
            datetime)
        pdp2.start()
        self.assertEqual(len(pdp2.predictions), 56)  # 48 time intervals plus 8 events
        self.assertEqual(len(PredictionManagerTest.request_urls), 2)

        # Verify that this is not just the same object being coughed up
        self.assertIsNot(pdp2, pdp1)

        # This is for a different date, so new requests again
        datetime = QDate(2020,1,2)
        pdp3 = CurrentDataPromise(
            self.pm,
            self.refCurrentStation,
            datetime)
        pdp3.start()
        self.assertEqual(len(pdp3.predictions), 56)  # 48 time intervals plus 8 events
        self.assertEqual(len(PredictionManagerTest.request_urls), 4)

    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_current_interpolator(self):
        refPromises = []
        subPromises = []
        date = QDate(2020,1,1)
        for dt in [date.addDays(i) for i in range(0,3)]:
            dp = self.pm.getDataPromise(self.refCurrentStation, dt)
            refPromises.append(dp)
            ep = self.pm.getEventPromise(self.subCurrentStation, dt)
            subPromises.append(ep)
            dp.start()
            ep.start()

        """ sub station specs this:
                <mfcTimeAdjMin>85</mfcTimeAdjMin>
                <sbeTimeAdjMin>53</sbeTimeAdjMin>
                <mecTimeAdjMin>-26</mecTimeAdjMin>
                <sbfTimeAdjMin>-31</sbfTimeAdjMin>
                <mfcAmpAdj>0.7</mfcAmpAdj>
                <mecAmpAdj>0.6</mecAmpAdj>

            for 2020-01-02, sub station events include:
                flood, 07:49, 0.57
                slack, 09:47, 0.01
                ebb, 12:16, -0.56
        """

        datetime = QDateTime(2020, 1, 2, 5, 0, 0, 0, Qt.TimeSpec.UTC)
        interp = PredictionInterpolator(self.subCurrentStation, datetime, subPromises, refPromises)

        timeInterp = interp.timeInterpolation()
        def timeDiff(str):
            t = self.timeToSecs(str)
            return (t - timeInterp([t])[0]) / 60

        # exact results
        self.assertAlmostEqual(timeDiff('02:49'), 85)  # note the times are local since relative to datetime
        self.assertAlmostEqual(timeDiff('04:47'), 53)
        self.assertAlmostEqual(timeDiff('07:16'), -26)

        # interpolated results
        self.assertAlmostEqual(timeDiff('02:48'),  84.630573248)
        self.assertAlmostEqual(timeDiff('02:50'),  84.72881355)
        self.assertAlmostEqual(timeDiff('03:48'), 69)
        self.assertAlmostEqual(timeDiff('07:15'),  -25.469798657)

        factorInterp = interp.factorInterpolation()
        # exact results
        self.assertAlmostEqual(factorInterp(self.timeToSecs('02:49')), 0.7)
        self.assertAlmostEqual(factorInterp(self.timeToSecs('07:16')), 0.6)

        # interpolated results
        self.assertAlmostEqual(factorInterp(self.timeToSecs('04:47')), 0.6567736)

        """ ref station predictions include:
                0.877, 05:00
                0.939, 05:30
                0.984, 06:00
                1.009, 06:30
                0.974, 07:00
                0.839, 07:30
                0.611, 08:00
                0.362, 08:30
                0.284, 09:00
        """
        valueInterp = interp.valueInterpolation()
        # exact results
        self.assertAlmostEqual(valueInterp(self.timeToSecs('02:00')), 0.974)
        # interpolated
        self.assertAlmostEqual(valueInterp(self.timeToSecs('01:59')), 0.97671513)
        self.assertAlmostEqual(valueInterp(self.timeToSecs('02:01')), 0.97111623)

    @patch.object(PredictionRequest, 'doStart', mock_doStart)
    def test_prediction_data_promise_object_cache(self):
        datetime = QDate(2020,1,1)
        pdp1 = self.pm.getDataPromise(
            self.refCurrentStation,
            datetime)
        pdp1.start()
        self.assertEqual(len(pdp1.predictions), 56)  # 48 time intervals plus 8 events
        self.assertEqual(len(PredictionManagerTest.request_urls), 2) # events and currents

        # the second call should return exactly the same promise object
        pdp2 = self.pm.getDataPromise(
            self.refCurrentStation,
            datetime)
        pdp2.start()
        self.assertEqual(len(pdp2.predictions), 56)  # 48 time intervals plus 8 events
        self.assertEqual(len(PredictionManagerTest.request_urls), 2)

        # Verify that this IS just the same object being coughed up
        self.assertIs(pdp2, pdp1)

    @patch.object(PredictionRequest, 'doStart', mock_doStartPrepare)
    def test_prediction_progress(self):
        self.assertEqual(self.pm.progressValue(), 100)

        progressList = []
        def appendProgress(p):
            progressList.append(p)
        self.pm.progressChanged.connect(appendProgress)

        datetime = QDate(2020,1,1)
        pdp1 = self.pm.getDataPromise(
            self.refCurrentStation,
            datetime)
        pdp1.start()

        self.assertEqual(progressList,[0])

        # the second call should return exactly the same promise object
        pdp2 = self.pm.getDataPromise(
            self.refCurrentStation,
            datetime.addDays(1))
        pdp2.start()

        self.assertEqual(progressList,[0, 0])

        for dep in pdp1.dependencies:
            dep.processFinish()

        self.assertEqual(progressList,[0, 0, 50])

        for dep in pdp2.dependencies:
            dep.processFinish()

        self.assertEqual(progressList,[0, 0, 50, 100])

    def test_current_request_error(self):
        features = self.getPredictions(
            'error.xml',
            self.subCurrentStation,
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
            self.subCurrentStation,
            QDateTime(2020,1,1,5,0),
            CurrentPredictionRequest.EventType,
            url)
        self.assertEqual(len(features), 9)
        feature = features[1]
        self.assertEqual(feature['station'], 'ACT0926_1')
        self.assertEqual(feature['depth'], 10.0)
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 6, 49, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], 0.62)
        self.assertTrue(feature['flags'] & PredictionFlags.Max)
        self.assertEqual(feature['dir'], 259.0)
        self.assertEqual(feature['magnitude'], 0.62)
        self.assertTrue(feature['surface'])

        feature = features[2]
        self.assertTrue(feature['flags'] & PredictionFlags.Zero)
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 59, 0, 0, Qt.TimeSpec.UTC))
        self.assertTrue(feature['surface'])

        feature = features[3]
        self.assertTrue(feature['flags'] & PredictionFlags.Min)
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 11, 46, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], -0.58)
        self.assertEqual(feature['dir'], 66.0)
        self.assertEqual(feature['magnitude'], 0.58)
        self.assertTrue(feature['surface'])

    def test_tide_event_requests(self):
        url = QUrl('https://api.tidesandcurrents.noaa.gov/api/prod/datagetter'
             '?application=qgis-noaa-tidal-predictions&begin_date=20200101 05:00&end_date=20200102 04:59'
             '&units=english&time_zone=gmt&product=predictions&format=xml'
             '&station=8443970&interval=hilo')
        features = self.getPredictions(
            '8443970-20200101T05:00--hilo.xml',
            self.refTideStation,
            QDateTime(2020,1,1,5,0),
            TidePredictionRequest.EventType,
            url)
        self.assertEqual(len(features), 4)
        feature = features[0]
        self.assertEqual(feature['station'], '8443970')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 21, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], 8.606)
        self.assertTrue(feature['flags'] & PredictionFlags.Max)
        self.assertTrue(feature['surface'])

        feature = features[1]
        self.assertEqual(feature['station'], '8443970')
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 14, 21, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], 1.578)
        self.assertTrue(feature['flags'] & PredictionFlags.Min)
        self.assertTrue(feature['surface'])

    def test_current_speed_dir_requests(self):
        url = QUrl('https://api.tidesandcurrents.noaa.gov/api/prod/datagetter?'
            'application=qgis-noaa-tidal-predictions&begin_date=20200101 05:00&end_date=20200102 04:59'
            '&units=english&time_zone=gmt&product=currents_predictions&format=xml'
            '&station=BOS1111&bin=14&vel_type=speed_dir&interval=30')
        features = self.getPredictions(
            'BOS1111_14-20200101T05:00-speed_dir-30.xml',
            self.refCurrentStation,
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
        self.assertTrue(feature['flags'] & PredictionFlags.Time)
        self.assertEqual(feature['dir'], 262.0)
        self.assertEqual(feature['magnitude'], 1.062)
        # just on the flood side of the transition
        feature = features[6]
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 0, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], 0.0774541)   # cosine-rule projection
        self.assertTrue(feature['flags'] & PredictionFlags.Time)
        self.assertEqual(feature['dir'], 190.0)
        self.assertEqual(feature['magnitude'], 0.281)
        # just on the ebb side of the transition
        feature = features[7]
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 30, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], -0.1067157)   # cosine-rule projection
        self.assertTrue(feature['flags'] & PredictionFlags.Time)
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
            self.refCurrentStation,
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
        self.assertTrue(feature['flags'] & PredictionFlags.Time)
        self.assertEqual(feature['dir'], 264.0)
        self.assertEqual(feature['magnitude'], 1.03)
        # just on the flood side of the transition
        feature = features[6]
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 0, 0, 0, Qt.TimeSpec.UTC))
        self.assertEqual(feature['value'], 0.08)
        self.assertTrue(feature['flags'] & PredictionFlags.Time)
        self.assertEqual(feature['dir'], 264.0)
        self.assertEqual(feature['magnitude'], 0.08)
        # just on the ebb side of the transition
        feature = features[7]
        self.assertEqual(feature['time'], QDateTime(2020, 1, 1, 8, 30, 0, 0, Qt.TimeSpec.UTC))
        self.assertAlmostEqual(feature['value'], -0.21)   # cosine-rule projection
        self.assertTrue(feature['flags'] & PredictionFlags.Time)
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
