import os

from qgis.PyQt import QtWidgets, uic
from qgis.PyQt.QtCore import QDate, QDateTime, QTime, QTimeZone
from qgis.PyQt.QtWidgets import QTableWidget, QTableWidgetItem

from qgis.core import (
    QgsTemporalNavigationObject,
    QgsDateTimeRange,
)

from qgis.utils import iface

from .utils import *
from .prediction_manager import *

FORM_CLASS, _ = uic.loadUiType(os.path.join(
    os.path.dirname(__file__), 'tidal_prediction_widget.ui'))


class TidalPredictionWidget(QtWidgets.QDockWidget, FORM_CLASS):
    def __init__(self, parent, canvas):
        """Constructor."""
        super(TidalPredictionWidget, self).__init__(parent)
        self.canvas = canvas
        self.temporal = canvas.temporalController()
        self.setupUi(self)

        self.tableWidget.setColumnCount(3)
        self.tableWidget.setSortingEnabled(False)
        self.tableWidget.setHorizontalHeaderLabels([tr('Time'), tr('Type'), tr('Speed')])

        self.dateEdit.dateChanged.connect(self.updateTime)
        self.dateEdit.dateChanged.connect(self.updatePredictions)
        self.timeEdit.timeChanged.connect(self.updateTime)

        self.stationFeature = None
        self.stationZone = None

    def setupPredictions(self):
        self.predictionManager = PredictionManager(currentStationsLayer(), currentPredictionsLayer())
        if self.temporal.navigationMode() == QgsTemporalNavigationObject.NavigationMode.NavigationOff:
            self.setDateTime(QDateTime.currentDateTime().toUTC())
        else:
            self.setDateTime(self.temporal.temporalExtents().begin())

    def setDateTime(self, datetime):
        if self.stationFeature:
            localtime = datetime.toTimeZone(stationTimeZone(self.stationFeature))
        else:
            localtime = datetime.toLocalTime()
        self.dateEdit.setDate(localtime.date())
        self.timeEdit.setTime(localtime.time())
        self.updateTime()
        self.updatePredictions()


    def setCurrentStation(self, feature):
        self.stationFeature = feature
        self.stationZone = stationTimeZone(feature)
        self.stationLabel.setText(feature['name'])
        self.updateTime()
        self.updatePredictions()

    def updateTime(self):
        if self.stationFeature is None:
            return
        self.temporal.setNavigationMode(QgsTemporalNavigationObject.NavigationMode.FixedRange)
        datetime = QDateTime(self.dateEdit.date(), self.timeEdit.time(), self.stationZone).toUTC()
        self.temporal.setTemporalExtents(QgsDateTimeRange(datetime, datetime.addSecs(60*30), True, False))

    def updatePredictions(self):
        if self.stationFeature is None:
            return

        self.stationData = self.predictionManager.getDataPromise(self.stationFeature, self.dateEdit.date())
        self.tableWidget.clearContents()
        self.stationData.resolved(self.predictionsResolved)

    def predictionsResolved(self):
        self.tableWidget.setRowCount(len(self.stationData.predictions))
        for i, p in enumerate(self.stationData.predictions):
            self.tableWidget.setItem(i, 0, QTableWidgetItem(p['time'].toTimeZone(self.stationZone).toString('hh:mm')))
            self.tableWidget.setItem(i, 1, QTableWidgetItem(p['type']))
            self.tableWidget.setItem(i, 2, QTableWidgetItem("{:.2f}".format(p['value'])))




