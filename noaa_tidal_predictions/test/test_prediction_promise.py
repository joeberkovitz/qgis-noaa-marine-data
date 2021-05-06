from .utilities import get_qgis_app

import unittest
from unittest.mock import *
import os

from qgis.core import (
    QgsFeature,
    )

from noaa_tidal_predictions.prediction_manager import PredictionPromise

class PredictionPromiseTest(unittest.TestCase):
    """Test translations work."""

    def setUp(self):
        self.resolved = Mock('resolved')
        self.promise = PredictionPromise()
        self.promise.doStart = Mock('doStart')
        self.promise.resolved(self.resolved)

        return

    def tearDown(self):
        return

    def test_initial_state(self):
        self.promise.doStart.assert_not_called()
        self.resolved.assert_not_called()
        self.assertFalse(self.promise.isStarted)
        self.assertFalse(self.promise.isResolved)

    def test_start_only(self):
        self.promise.start()
        self.promise.doStart.assert_called_once()
        self.resolved.assert_not_called()
        self.assertTrue(self.promise.isStarted)
        self.assertFalse(self.promise.isResolved)

    def test_started_once(self):
        self.promise.start()
        self.promise.doStart.reset_mock()
        self.promise.start()
        self.promise.doStart.assert_not_called()
        self.resolved.assert_not_called()
        self.assertTrue(self.promise.isStarted)
        self.assertFalse(self.promise.isResolved)

    def test_resolved(self):
        self.promise.start()
        self.promise.resolve()
        self.resolved.assert_called_once()
        self.assertTrue(self.promise.isStarted)
        self.assertTrue(self.promise.isResolved)

    def test_dependencies(self):
        self.promise.doProcessing = Mock('doProcessing')

        dep1 = PredictionPromise()
        self.promise.addDependency(dep1)
        dep2 = PredictionPromise()
        self.promise.addDependency(dep2)

        self.assertFalse(dep1.isStarted or dep2.isStarted)
        self.promise.start()
        self.assertTrue(dep1.isStarted and dep2.isStarted)
        self.resolved.assert_not_called()
        self.promise.doProcessing.assert_not_called()

        dep1.resolve()
        self.resolved.assert_not_called()
        self.promise.doProcessing.assert_not_called()

        dep2.resolve()
        self.promise.doProcessing.assert_called_once()
        self.resolved.assert_called_once()


if __name__ == "__main__":
    suite = unittest.makeSuite(PredictionManagerTest)
    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(suite)
