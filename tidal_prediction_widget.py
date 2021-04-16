import os

from qgis.PyQt import QtWidgets, uic
from qgis.PyQt.QtCore import QDate, QDateTime, QTime, QTimeZone
from qgis.PyQt.QtWidgets import QTableWidget, QTableWidgetItem

from qgis.core import (
    QgsTemporalNavigationObject,
    QgsDateTimeRange,
    NULL
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
        self.mapSettings = canvas.mapSettings()
        self.temporal = canvas.temporalController()
        self.setupUi(self)

        self.tableWidget.setColumnCount(3)
        self.tableWidget.setSortingEnabled(False)
        self.tableWidget.setHorizontalHeaderLabels([tr('Time'), tr('Direction'), tr('Speed (kt)')])

        self.dateEdit.dateChanged.connect(self.updateDate)
        self.dateEdit.dateChanged.connect(self.updatePredictions)
        self.timeEdit.timeChanged.connect(self.updateTime)

        self.nextDay.clicked.connect(lambda: self.adjustDay(1))
        self.prevDay.clicked.connect(lambda: self.adjustDay(-1))
        self.nextStep.clicked.connect(lambda: self.adjustStep(1))
        self.prevStep.clicked.connect(lambda: self.adjustStep(-1))

        self.predictionManager = None
        self.stationFeature = None
        self.stationZone = None
        self.active = False

    def activate(self):
        self.active = True
        self.predictionManager = PredictionManager(currentStationsLayer(), currentPredictionsLayer())
        self.canvas.extentsChanged.connect(self.autoLoadPredictions)
        self.show()
        self.setupPredictions()
        self.autoLoadPredictions()

    def deactivate(self):
        self.hide()
        self.predictionManager = None
        self.active = False
        self.canvas.extentsChanged.disconnect(self.autoLoadPredictions)

    def maxAutoLoadCount(self):
        return 100;   # TODO: have a widget for this

    def autoLoadPredictions(self):
        if self.active and self.predictionManager is not None:
            xform = QgsCoordinateTransform(self.mapSettings.destinationCrs(),
                        epsg4326,
                        QgsProject.instance())
            rect = xform.transform(self.canvas.extent())
            mapFeatures = self.predictionManager.getExtentStations(rect)
            print('autoloading ', len(mapFeatures))
            if len(mapFeatures) <= self.maxAutoLoadCount():
                for f in mapFeatures:
                    self.predictionManager.getDataPromise(f, self.dateEdit.date())
            if self.stationZone is None and len(mapFeatures) > 0:
                self.stationZone = stationTimeZone(mapFeatures[0])


    def setupPredictions(self):
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

        # round off to nearest step
        displayTime = localtime.time()
        displayTime.setHMS(
            displayTime.hour(), 
            PredictionManager.STEP_MINUTES * (displayTime.minute() // PredictionManager.STEP_MINUTES),
            0)
        self.timeEdit.setTime(displayTime)

        self.updateTime()
        self.updatePredictions()


    def setCurrentStation(self, feature):
        self.stationFeature = feature
        self.stationZone = stationTimeZone(feature)
        self.stationLabel.setText(feature['name'])
        self.updateTime()
        self.updatePredictions()

    def adjustDay(self, delta):
        self.dateEdit.setDate(self.dateEdit.date().addDays(delta))

    def adjustStep(self, delta):
        step = 60*PredictionManager.STEP_MINUTES*delta
        curTime =self.timeEdit.time()
        if step < 0 and curTime.hour() == 0 and curTime.minute() == 0:
            self.adjustDay(-1)
        curTime = curTime.addSecs(step)
        self.timeEdit.setTime(curTime)
        if step > 0 and curTime.hour() == 0 and curTime.minute() == 0:
            self.adjustDay(1)

    def updateDate(self):
        self.autoLoadPredictions()
        self.updateTime()

    def updateTime(self):
        self.temporal.setNavigationMode(QgsTemporalNavigationObject.NavigationMode.FixedRange)
        datetime = QDateTime(self.dateEdit.date(), self.timeEdit.time(), self.stationZone).toUTC()
        # may need to hack around memory provider bug here by subtracting 1 second from end of range
        self.temporal.setTemporalExtents(
            QgsDateTimeRange(datetime,
                             datetime.addSecs((60 * PredictionManager.STEP_MINUTES)),
                             True, False
                             )
            )

    def updatePredictions(self):
        if self.stationFeature is None:
            return

        self.stationData = self.predictionManager.getDataPromise(self.stationFeature, self.dateEdit.date())
        self.tableWidget.clearContents()
        self.stationData.resolved(self.predictionsResolved)

    def predictionsResolved(self):
        self.tableWidget.setRowCount(len(self.stationData.predictions))
        for i, p in enumerate(self.stationData.predictions):
            dt = p['time']
            dt.setTimeSpec(Qt.TimeSpec.UTC)
            self.tableWidget.setItem(i, 0, QTableWidgetItem(dt.toTimeZone(self.stationZone).toString('h:mm AP')))
            if p['type'] == 'current' and p['dir'] != NULL:
                self.tableWidget.setItem(i, 1, QTableWidgetItem(str(round(p['dir'])) + 'º'))
            else:
                self.tableWidget.setItem(i, 1, QTableWidgetItem(p['type']))
            self.tableWidget.setItem(i, 2, QTableWidgetItem("{:.2f}".format(p['value'])))

