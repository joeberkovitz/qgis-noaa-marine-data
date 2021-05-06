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
        self.rejected = Mock('rejected')
        self.promise = PredictionPromise()
        self.promise.doStart = Mock('doStart')
        self.promise.resolved(self.resolved)
        self.promise.rejected(self.rejected)

        return

    def tearDown(self):
        return

    def test_initial_state(self):
        self.promise.doStart.assert_not_called()
        self.resolved.assert_not_called()
        self.assertEqual(self.promise.state, PredictionPromise.InitialState)

    def test_start_only(self):
        self.promise.start()
        self.promise.doStart.assert_called_once()
        self.resolved.assert_not_called()
        self.assertEqual(self.promise.state, PredictionPromise.StartedState)

    def test_started_once(self):
        self.promise.start()
        self.promise.doStart.reset_mock()
        self.promise.start()
        self.promise.doStart.assert_not_called()
        self.resolved.assert_not_called()
        self.assertEqual(self.promise.state, PredictionPromise.StartedState)

    def test_resolved(self):
        self.promise.start()
        self.promise.resolve()
        self.resolved.assert_called_once()
        self.rejected.assert_not_called()
        self.assertEqual(self.promise.state, PredictionPromise.ResolvedState)

    def test_already_resolved(self):
        self.promise.start()
        self.promise.resolve()
        self.resolved.assert_called_once()

        # further resolved() calls should now result in an immediate callback
        resolved2 = Mock('resolved2')
        self.promise.resolved(resolved2)
        resolved2.assert_called_once()

    def test_rejected(self):
        self.promise.start()
        self.promise.reject()
        self.rejected.assert_called_once()
        self.resolved.assert_not_called()
        self.assertEqual(self.promise.state, PredictionPromise.RejectedState)

    def test_already_rejected(self):
        self.promise.start()
        self.promise.reject()
        self.rejected.assert_called_once()

        # further resolved() calls should now result in an immediate callback
        rejected2 = Mock('rejected2')
        self.promise.rejected(rejected2)
        rejected2.assert_called_once()

    def test_resolve_dependencies(self):
        self.promise.doProcessing = Mock('doProcessing')

        dep1 = PredictionPromise()
        self.promise.addDependency(dep1)
        dep2 = PredictionPromise()
        self.promise.addDependency(dep2)

        self.assertTrue(dep1.state == PredictionPromise.InitialState and dep2.state == PredictionPromise.InitialState)
        self.promise.start()
        self.assertTrue(dep1.state == PredictionPromise.StartedState and dep2.state == PredictionPromise.StartedState)
        self.resolved.assert_not_called()
        self.promise.doProcessing.assert_not_called()

        dep1.resolve()
        self.resolved.assert_not_called()
        self.promise.doProcessing.assert_not_called()

        dep2.resolve()
        self.promise.doProcessing.assert_called_once()
        self.resolved.assert_called_once()
        self.rejected.assert_not_called()

    def test_reject_dependencies1(self):
        self.promise.doProcessing = Mock('doProcessing')

        dep1 = PredictionPromise()
        self.promise.addDependency(dep1)
        dep2 = PredictionPromise()
        self.promise.addDependency(dep2)
        dep3 = PredictionPromise()
        self.promise.addDependency(dep3)
        self.promise.start()

        dep1.resolve()
        self.resolved.assert_not_called()
        self.rejected.assert_not_called()
        self.promise.doProcessing.assert_not_called()

        dep2.reject()
        self.resolved.assert_not_called()
        self.rejected.assert_called_once()
        self.promise.doProcessing.assert_not_called()

        self.rejected.reset_mock()
        dep3.resolve()
        self.resolved.assert_not_called()
        self.rejected.assert_not_called()
        self.promise.doProcessing.assert_not_called()


if __name__ == "__main__":
    suite = unittest.makeSuite(PredictionManagerTest)
    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(suite)
