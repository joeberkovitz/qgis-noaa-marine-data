from .utilities import get_qgis_app

import unittest
from unittest.mock import *

import os

from qgis.PyQt.QtCore import QCoreApplication
from qgis.core import (
    QgsProject,
    QgsProcessingContext,
    QgsProcessingUtils,
    QgsFeatureRequest,
    NULL
    )
from noaa_tidal_predictions.time_zone_lookup import TimeZoneLookup

QGIS_APP = get_qgis_app()


class TimeZoneLookupTest(unittest.TestCase):
    def setUp(self):
        self.tz = TimeZoneLookup()
        return

    def tearDown(self):
        return

    def test_regular_timezone(self):
        (zid, zutc) = self.tz.getZoneByCoordinates(48.52,-55.64)
        self.assertEqual(zid, 'America/St_Johns')
        self.assertEqual(zutc, 'UTC-03:30')

    def test_unnamed_timezone(self):
        (zid, zutc) = self.tz.getZoneByCoordinates(79.580,-176.200)
        self.assertEqual(zid, NULL)
        self.assertEqual(zutc, 'UTC-12:00')

    def test_invalid_timezone(self):
        with self.assertRaises(Exception):
            (zid, zutc) = self.tz.getZoneByCoordinates(100,0)

if __name__ == "__main__":
    suite = unittest.makeSuite(CurrentStationsTest)
    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(suite)
