import os
from qgis.PyQt.QtCore import QCoreApplication, Qt, QTimeZone, QByteArray
from qgis.core import QgsProject, QgsUnitTypes, QgsPointXY, QgsCoordinateReferenceSystem

epsg4326 = QgsCoordinateReferenceSystem("EPSG:4326")

# project variable names
NOAA_LAYER_TYPE = 'noaa_tidal_predictions/layer_type'

StationsLayerType = 'stations'
PredictionsLayerType = 'predictions'

CoopsApplicationName = 'qgis-noaa-tidal-predictions'

def tr(string):
    return QCoreApplication.translate('@default', string)


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
