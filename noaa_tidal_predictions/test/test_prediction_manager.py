from .utilities import get_qgis_app

import unittest
import os

from qgis.PyQt.QtCore import QCoreApplication
from noaa_tidal_predictions.prediction_manager import PredictionManager

QGIS_APP = get_qgis_app()


class PredictionManagerTest(unittest.TestCase):
    """Test translations work."""

    def setUp(self):
        return

    def tearDown(self):
        return

    def test_prediction_manager(self):
        pm = PredictionManager(None, None)
        return

if __name__ == "__main__":
    suite = unittest.makeSuite(PredictionManagerTest)
    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(suite)
