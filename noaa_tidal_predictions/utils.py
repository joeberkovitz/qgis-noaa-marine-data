import os
from qgis.PyQt.QtCore import QCoreApplication, Qt, QTimeZone, QByteArray, QVariant
from qgis.core import QgsProject, QgsFields, QgsField, QgsUnitTypes, QgsPointXY, QgsCoordinateReferenceSystem

epsg4326 = QgsCoordinateReferenceSystem("EPSG:4326")

# project variable names
NOAA_LAYER_TYPE = 'noaa_tidal_predictions/layer_type'

StationsLayerType = 'stations'
PredictionsLayerType = 'predictions'

CoopsApplicationName = 'qgis-noaa-tidal-predictions'

def tr(string):
    return QCoreApplication.translate('@default', string)

class PredictionFlags:
    Time = 1 << 0        # values at some regular time interval
    Max = 1 << 1         # a local maximum, e.g. high tide or max flood current
    Min = 1 << 2         # a local minimum, e.g. low tide or max ebb current
    Zero = 1 << 3        # a local zero crossing e.g. slack current
    Event = Max | Min | Zero
    Type = Event | Time
    Rising = 1 << 4      # value trend is increasing (for Zero, indicates SBF)
    Falling = 1 << 5     # value trend is decreasing (for Zero, indicates SBE)
    Trend = Rising | Falling
    Current = 1 << 6
    Surface = 1 << 7

    currentTypeNames = {
        Time: tr('current'),
        Max: tr('flood'),
        Min: tr('ebb'),
        Zero: tr('slack')
    }

    tideTypeNames = {
        Time: tr('level'),
        Max: tr('high'),
        Min: tr('low'),
    }

class StationFlags:
    Tide = 1 << 0
    Current = 1 << 1
    Surface = 1 << 2
    Reference = 1 << 3
    FixedAdj = 1 << 4   # adjustment from ref station is a fixed offset

def parseFloatNullable(str):
    return float(str) if str and str != 'null' and str != 'NULL' else None

def getNoaaLayerByType(layerType):
    for layer in QgsProject.instance().mapLayers().values():
        if layer.customProperty(NOAA_LAYER_TYPE) == layerType:
            return layer
    return None

def getStationsLayer():
    return getNoaaLayerByType(StationsLayerType)

def getPredictionsLayer():
    return getNoaaLayerByType(PredictionsLayerType)

def layerStoragePath():
    return os.path.join(QgsProject.instance().homePath(), 'noaa_tidal_predictions')

def stationFields():
    fields = QgsFields()
    fields.append(QgsField("station", QVariant.String,'', 16))
    fields.append(QgsField("id", QVariant.String,'', 12))
    fields.append(QgsField("name", QVariant.String, '', 64))
    fields.append(QgsField("flags", QVariant.Int))
    fields.append(QgsField("bin", QVariant.String,'', 4))
    fields.append(QgsField("timeZoneId", QVariant.String, '', 32))
    fields.append(QgsField("timeZoneUTC", QVariant.String, '', 32))
    fields.append(QgsField("refStation", QVariant.String,'', 12))
    fields.append(QgsField("depth",  QVariant.Double))
    fields.append(QgsField("depthType",  QVariant.String, '', 1))
    fields.append(QgsField("meanFloodDir", QVariant.Double))
    fields.append(QgsField("meanEbbDir", QVariant.Double))
    fields.append(QgsField("maxTimeAdj", QVariant.Double))
    fields.append(QgsField("minTimeAdj", QVariant.Double))
    fields.append(QgsField("risingZeroTimeAdj", QVariant.Double))
    fields.append(QgsField("fallingZeroTimeAdj", QVariant.Double))
    fields.append(QgsField("maxValueAdj", QVariant.Double))
    fields.append(QgsField("minValueAdj", QVariant.Double))
    return fields

def predictionFields():
    fields = QgsFields()
    fields.append(QgsField("station", QVariant.String,'',16))
    fields.append(QgsField("depth",  QVariant.Double))
    fields.append(QgsField("time",  QVariant.DateTime))
    fields.append(QgsField("value", QVariant.Double))  # signed value, on flood/ebb dimension for current
    fields.append(QgsField("flags", QVariant.Int))
    fields.append(QgsField("dir", QVariant.Double))
    fields.append(QgsField("magnitude", QVariant.Double))  # value along direction if known
    return fields


def stationTimeZone(stationFeature):
    timeZoneId = stationFeature['timeZoneId']
    timeZoneUTC = stationFeature['timeZoneUTC']

    tz = None
    if timeZoneId:
        tz = QTimeZone(QByteArray(timeZoneId.encode()))
        if not tz.isValid():
            tz = None
    if not tz:
        tz = QTimeZone(QByteArray(timeZoneUTC.encode()))

    return tz
