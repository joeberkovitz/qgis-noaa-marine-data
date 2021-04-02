import os
from qgis.core import QgsProcessingProvider
from qgis.PyQt.QtGui import QIcon
from .add_station_layers import AddCurrentStationsLayerAlgorithm
#, AddTimeZonesLayerAlgorithm
from .get_tidal_predictions import GetTidalPredictionsAlgorithm

class NoaaMarineDataProvider(QgsProcessingProvider):
    def unload(self):
        QgsProcessingProvider.unload(self)

    def loadAlgorithms(self):
        #self.addAlgorithm(AddTimeZonesLayerAlgorithm())
        self.addAlgorithm(AddCurrentStationsLayerAlgorithm())
        self.addAlgorithm(GetTidalPredictionsAlgorithm())

    def id(self):
        return 'noaamarinedata'

    def name(self):
        return 'NOAA Marine Data'

    def longName(self):
        return self.name()
