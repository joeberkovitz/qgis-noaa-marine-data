import os

from qgis.PyQt import QtWidgets, uic
from qgis.PyQt.QtCore import QDate, QDateTime, QTime, QTimeZone, QTimer
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
    TEMPORAL_HACK_SECS = 1
    AUTOLOAD_TIMER_MSECS = 300

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
        self.dateEdit.dateChanged.connect(self.loadStationPredictions)
        self.timeEdit.timeChanged.connect(self.updateTime)

        self.nextDay.clicked.connect(lambda: self.adjustDay(1))
        self.prevDay.clicked.connect(lambda: self.adjustDay(-1))
        self.nextStep.clicked.connect(lambda: self.adjustStep(1))
        self.prevStep.clicked.connect(lambda: self.adjustStep(-1))

        self.predictionManager = None
        self.stationFeature = None
        self.stationZone = None
        self.active = False

        self.autoLoadTimer = QTimer()
        self.autoLoadTimer.setSingleShot(True)

    def activate(self):
        self.active = True
        self.predictionManager = PredictionManager(currentStationsLayer(), currentPredictionsLayer())
        QgsProject.instance()._pm = self.predictionManager ## HACK FOR TESTING
        self.show()
        self.setTemporalRange()
        self.loadMapExtentPredictions()

        self.autoLoadTimer.timeout.connect(self.loadMapExtentPredictions)
        self.canvas.extentsChanged.connect(self.triggerAutoLoad)

    def deactivate(self):
        self.canvas.extentsChanged.disconnect(self.triggerAutoLoad)
        self.autoLoadTimer.timeout.disconnect(self.loadMapExtentPredictions)
        self.autoLoadTimer.stop()

        self.hide()
        self.predictionManager = None
        self.active = False

    def maxAutoLoadCount(self):
        return 100;   # TODO: have a widget for this

    def triggerAutoLoad(self):
        self.autoLoadTimer.start(self.AUTOLOAD_TIMER_MSECS)

    def loadMapExtentPredictions(self):
        self.autoLoadTimer.stop()
        """ ensure all stations in visible extent of the map are loaded
        """
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

    def loadStationPredictions(self):
        """ load predictions for the selected station
        """
        if self.stationFeature is None:
            return

        self.stationData = self.predictionManager.getDataPromise(self.stationFeature, self.dateEdit.date())
        self.tableWidget.clearContents()
        self.stationData.resolved(self.predictionsResolved)

    def setTemporalRange(self):
        """ Set up the temporal range of either based on the current time, or on the temporal
            extents in the map canvas if those are defined.
        """
        if self.temporal.navigationMode() == QgsTemporalNavigationObject.NavigationMode.NavigationOff:
            startTime = QDateTime.currentDateTime().toUTC()
        else:
            startTime = self.temporal.temporalExtents().begin().addSecs(self.TEMPORAL_HACK_SECS)

        self.setDateTime(startTime)


    def setDateTime(self, datetime):
        """ Set our date and time choosers appropriately based on the given UTC time
            as interpreted for the current station if there is one, else base on local time.
        """
        if self.stationFeature:
            localtime = datetime.toTimeZone(stationTimeZone(self.stationFeature))
        else:
            localtime = datetime.toLocalTime()
        self.dateEdit.setDate(localtime.date())

        # round off the time to the nearest step
        displayTime = localtime.time()
        displayTime.setHMS(
            displayTime.hour(), 
            PredictionManager.STEP_MINUTES * (displayTime.minute() // PredictionManager.STEP_MINUTES),
            0)
        self.timeEdit.setTime(displayTime)

        self.updateTime()
        self.loadStationPredictions()


    def setCurrentStation(self, feature):
        """ set the panel's current prediction station to the one described by the given feature
        """
        self.stationFeature = feature
        self.stationZone = stationTimeZone(feature)
        self.stationLabel.setText(feature['name'])

        self.updateTime()
        self.updateStationLink()
        self.loadStationPredictions()

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
        self.loadMapExtentPredictions()
        self.updateStationLink()
        self.updateTime()

    def updateTime(self):
        self.temporal.setNavigationMode(QgsTemporalNavigationObject.NavigationMode.FixedRange)

        if self.stationZone is not None:
            datetime = QDateTime(self.dateEdit.date(), self.timeEdit.time(), self.stationZone).toUTC()
        else:
            datetime = QDateTime(self.dateEdit.date(), self.timeEdit.time()).toUTC()
        # Note: we hack around a memory provider range bug here by offsetting the window by 1 minute
        self.temporal.setTemporalExtents(
            QgsDateTimeRange(datetime.addSecs(-self.TEMPORAL_HACK_SECS),
                             datetime.addSecs((60 * PredictionManager.STEP_MINUTES) - self.TEMPORAL_HACK_SECS),
                             True, False
                             )
            )

    def updateStationLink(self):
        if self.stationFeature is not None:
            linkUrl = 'https://tidesandcurrents.noaa.gov/noaacurrents/Predictions?id={}&d={}&r=1&tz=LST%2FLDT'
            linkUrl = linkUrl.format(self.stationFeature['station'], self.dateEdit.date().toString('yyyy-MM-dd'))
            self.linkLabel.setText('<a href="{}">{} Station Page</a>'.format(linkUrl, self.stationFeature['id']))
        else:
            self.linkLabel.setText('')

    def predictionsResolved(self):
        """ when we have predictions for the current station, show them in the
            table widget.
        """

        self.tableWidget.setRowCount(len(self.stationData.predictions))
        for i, p in enumerate(self.stationData.predictions):
            dt = p['time']
            dt.setTimeSpec(Qt.TimeSpec.UTC)
            self.tableWidget.setItem(i, 0, QTableWidgetItem(dt.toTimeZone(self.stationZone).toString('h:mm AP')))
            if p['type'] == 'current' and p['dir'] != NULL:
                self.tableWidget.setItem(i, 1, QTableWidgetItem(str(round(p['dir'])) + 'º'))
                self.tableWidget.setItem(i, 2, QTableWidgetItem("{:.2f}".format(p['magnitude'])))
            else:
                self.tableWidget.setItem(i, 1, QTableWidgetItem(p['type']))
                self.tableWidget.setItem(i, 2, QTableWidgetItem("{:.2f}".format(p['value'])))

