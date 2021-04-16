import os

from qgis.PyQt import QtWidgets, uic
from qgis.PyQt.QtCore import QDate, QDateTime
from qgis.PyQt.QtWidgets import QTableWidgetItem

from .utils import *
from .prediction_manager import *

FORM_CLASS, _ = uic.loadUiType(os.path.join(
    os.path.dirname(__file__), 'tidal_prediction_widget.ui'))


class TidalPredictionWidget(QtWidgets.QDockWidget, FORM_CLASS):
    def __init__(self, parent=None):
        """Constructor."""
        super(TidalPredictionWidget, self).__init__(parent)
        self.setupUi(self)

        self.dateEdit.setDate(QDate.currentDate())

        self.tableWidget.setColumnCount(4)
        self.tableWidget.setSortingEnabled(False)
        self.tableWidget.setHorizontalHeaderLabels([tr('Time'), tr('Type'), tr('Direction'), tr('Speed')])

    def setupPredictions(self):
        self.predictionManager = PredictionManager(currentStationsLayer(), currentPredictionsLayer())

    def setCurrentStation(self, feature):
        self.stationFeature = feature
        self.stationLabel.setText(feature['name'])
        self.stationData = self.predictionManager.getDataPromise(self.stationFeature, self.dateEdit.date())
        self.stationData.resolved(lambda: print([p['time'].toString() for p in self.stationData.predictions]))



