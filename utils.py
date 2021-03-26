import math
import re
from qgis.PyQt.QtCore import QCoreApplication
from qgis.core import QgsUnitTypes, QgsPointXY, QgsCoordinateReferenceSystem

epsg4326 = QgsCoordinateReferenceSystem("EPSG:4326")

# project variable names
CurrentStationsLayerVar = 'noaa_current_stations_layer'
TideStationsLayerVar = 'noaa_tide_stations_layer'

def tr(string):
    return QCoreApplication.translate('@default', string)


