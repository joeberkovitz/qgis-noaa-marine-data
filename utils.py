import math
import re
from qgis.PyQt.QtCore import QCoreApplication
from qgis.core import QgsProject, QgsUnitTypes, QgsPointXY, QgsCoordinateReferenceSystem

epsg4326 = QgsCoordinateReferenceSystem("EPSG:4326")

# project variable names
CurrentStationsLayerVar = 'noaa_current_stations_layer'
CurrentPredictionsLayerVar = 'noaa_current_predictions_layer'
TideStationsLayerVar = 'noaa_tide_stations_layer'
TidePredictionsLayerVar = 'noaa_tide_predictions_layer'

CoopsApplicationName = 'qgis-noaa-tidal-predictions'

def tr(string):
    return QCoreApplication.translate('@default', string)


def parseFloatNullable(str):
    return float(str) if str and str != 'null' else None

def getProjectByLayerVar(varName):
    layerId = QgsProject.instance().customVariables().get(varName)
    if layerId:
        layer = QgsProject.instance().mapLayer(layerId)
        if layer:
            return layer
        else:
            raise Exception('Could not find layer with id {}'.format(layerId))
    else:
        raise Exception('Could not find project variable {}'.format(varName))

def currentStationsLayer():
    return getProjectByLayerVar(CurrentStationsLayerVar)

def currentPredictionsLayer():
    return getProjectByLayerVar(CurrentPredictionsLayerVar)

def tideStationsLayer():
    return getProjectByLayerVar(TideStationsLayerVar)

def tidePredictionsLayer():
    return getProjectByLayerVar(TidePredictionsLayerVar)

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
