from qgis.core import QgsProcessingProvider
from qgis.PyQt.QtGui import QIcon
from .add_station_layers import AddStationsLayerAlgorithm
from .export_clustered_predictions import ExportClusteredPredictionsAlgorithm

class NoaaTidalPredictionsProvider(QgsProcessingProvider):
    def unload(self):
        QgsProcessingProvider.unload(self)

    def loadAlgorithms(self):
        self.addAlgorithm(AddStationsLayerAlgorithm())
        self.addAlgorithm(ExportClusteredPredictionsAlgorithm())

    def id(self):
        return 'NoaaTidalPredictions'

    def name(self):
        return 'NOAA Tidal Predictions'

    def longName(self):
        return self.name()

