from qgis.PyQt.QtCore import QSettings, QTranslator, QCoreApplication, Qt, QTimeZone, QDateTime, QByteArray

from qgis.core import qgsfunction, QgsExpression
from qgis.utils import iface

from datetime import *
import math

class PredictionExpressions:

    @staticmethod
    def registerFunctions():
        QgsExpression.registerFunction(PredictionExpressions.format_time_zone)
        QgsExpression.registerFunction(PredictionExpressions.convert_to_time_zone)
        QgsExpression.registerFunction(PredictionExpressions.is_time_visible)

    @staticmethod
    def unregisterFunctions():
        QgsExpression.unregisterFunction('format_time_zone')
        QgsExpression.unregisterFunction('is_time_visible')
        QgsExpression.unregisterFunction('convert_to_time_zone')

    # Custom expression function to determine whether a prediction feature's time is subject to temporal filtering or not
    @qgsfunction(args=-1, group='Date and Time', register=False)
    def convert_to_time_zone(values, feature, parent):
        """Converts the given datetime to a time zone.<br>
        <br>
        convert_to_time_zone(datetime, utcId[, ianaId])<br>
        <br>
        datetime -- a datetime to convert<br>
        utcId -- a required string UTC offset, e.g. 'UTC+01:00'
        ianaId -- an optional IANA timezone ID, e.g. 'America/Chicago'
        """
        dt = values[0]
        utcId = values[1]
        tz = None

        if len(values) >= 3:
            ianaId = values[2]
            if ianaId:
                tz = QTimeZone(QByteArray(ianaId.encode()))   # if we have IANA, we'll try it
                if not tz.isValid():
                    tz = None           # wasn't available on our system, we guess
        if not tz:
            tz = QTimeZone(QByteArray(utcId.encode()))   # our fallback position is to use UTC

        return dt.toTimeZone(tz)

    @qgsfunction(args=2, group='Date and Time', register=False)
    def format_time_zone(values, feature, parent):
        """Formats the time zone of the given datetime to a string.<br>
        <br>
        format_time_zone(datetime, format)<br>
        <br>
        datetime -- a datetime to format<br>
        format -- an integer determining the format: 0=default, 1=long, 2=short
        """
        return values[0].timeZone().displayName(values[0], values[1])

    # Custom expression function to check a time to see if it passes the current temporal filter
    @qgsfunction(args=1, group='Date and Time', register=False)
    def is_time_visible(values, feature, parent):
        """Returns True if the given datetime is within range of any temporal filter, or if there
        is no temporal filter, else returns False.<br>
        <br>
        is_time_visible(datetime)
        """

        canvas = iface.mapCanvas()
        if canvas and feature:
            if canvas.mapSettings().isTemporal():
                range = canvas.mapSettings().temporalRange()
                values[0].setTimeSpec(Qt.TimeSpec.UTC)
                if (values[0] >= range.begin() and values[0] < range.end()):
                    return True
                else:
                    return False
            else:
                return True

        return False
