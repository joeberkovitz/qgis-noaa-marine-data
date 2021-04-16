import math
import xml.etree.ElementTree as ET

from qgis.core import (
    QgsPointXY, QgsPoint, QgsRectangle, QgsFeature, QgsGeometry, QgsField, QgsFields,
    QgsProject, QgsUnitTypes, QgsWkbTypes, QgsCoordinateTransform,
    QgsFeatureRequest, QgsNetworkContentFetcher,
)

from qgis.PyQt.QtCore import (
    pyqtSlot, pyqtSignal,
    QObject, QDate, QDateTime, QTime, QTimeZone, QUrl, QUrlQuery,
)

from .utils import *

# one of these for currents and one for tides
class PredictionManager:
    def __init__(self, stationsLayer, predictionsLayer):
        self.promiseDict = {}
        self.stationsLayer = stationsLayer
        self.predictionsLayer = predictionsLayer

    # maintains a map of stashed, unsent PredictionRequests. these are not sent until
    # the manager is told to initiate them, so that multiple requests can be folded.


    # get a PredictionDataPromise for 24-hour period starting with the given local-time date
    def getDataPromise(self, stationFeature, date):
        key = self.promiseKey(stationFeature, date)
        promise = self.promiseDict.get(key)
        if promise is None:
            # we have no cached data promise. make one
            promise = PredictionDataPromise(self, stationFeature, date)
            self.promiseDict[key] = promise
            promise.start()

        else:
            # we did have a cached one, so return it.
            print('Returning cached promise for {}'.format(key))

        return promise

    def getPredictions(self, feature, date):
        # return an iterable of prediction layer features for the given
        # station feature on the given local date. If any part of the range
        # is missing, return None
        return None

    def promiseKey(self, stationFeature, date):
        return stationFeature['station'] + '.' + date.toString('yyyyMMdd')


class PredictionPromise(QObject):
    _resolved = pyqtSignal()

    def __init__(self):
        super(PredictionPromise,self).__init__()
        self.isResolved = False
        self.dependencies = []

    def resolved(self, slot):
        if self.isResolved:
            slot()
        else:
            self._resolved.connect(slot)

    def resolve(self):
        self.isResolved = True
        self._resolved.emit()

    def checkDependencies(self):
        return next(filter(lambda p: not p.isResolved, self.dependencies), None) is None

# promise-like object for prediction date
class PredictionDataPromise(PredictionPromise):
    # initialize this promise and optionally prepopulate with a list of prediction features
    def __init__(self, manager, stationFeature, date, predictions=None):
        super(PredictionDataPromise, self).__init__()
        self.manager = manager
        self.stationFeature = stationFeature
        self.predictions = predictions

        # convert local station datetime to UTC 
        self.localDate = date
        self.datetime = QDateTime(date, QTime(0,0), stationTimeZone(stationFeature)).toUTC()

    def start(self):
        if self.predictions is not None:
            self.done()
            return

        # first see if we can pull data from the predictions layer
        startTime = self.datetime
        endTime = self.datetime.addDays(1)

        featureRequest = QgsFeatureRequest()
        stationPt = QgsPointXY(self.stationFeature.geometry().vertexAt(0))
        searchRect = QgsRectangle(stationPt, stationPt)
        searchRect.grow(0.01/60)   # in the neighborhood of .01 nm as 1/60 = 1 arc minute in this proj.
        featureRequest.setFilterRect(searchRect)
        expr = "time >= to_datetime('{}') and time < to_datetime('{}')".format(
                   startTime.toString('yyyy-MM-dd hh:mm'),
                   endTime.toString('yyyy-MM-dd hh:mm')
                )
        featureRequest.setFilterExpression(expr)
        featureRequest.addOrderBy('time')
        savedFeatureIterator = self.manager.predictionsLayer.getFeatures(featureRequest)
        savedFeatures = list(savedFeatureIterator)
        if len(savedFeatures) > 0:
            print ('Retrieved {} features from layer'.format(len(savedFeatures)))
            self.predictions = savedFeatures
            self.resolve()
        else:
            req = CurrentPredictionRequest(
                self.manager,
                self.stationFeature,
                startTime,
                endTime
            )
            print('Fetching features for {} on date {}'.format(self.stationFeature['station'],startTime.toString()))
            req.resolved(self.processRequest)
            self.dependencies.append(req)
            req.start()

    def processRequest(self):
        # TODO: some dependencies contribute data while others don't. Combining all of them is wrong sometimes.
        if self.checkDependencies():
            self.predictions = []
            for req in self.dependencies:
                self.predictions.extend(req.predictions)

            # TODO: sort the combined predictions here by time

            self.manager.predictionsLayer.startEditing()
            self.manager.predictionsLayer.addFeatures(self.predictions)
            self.manager.predictionsLayer.commitChanges()
            self.resolve()


# low-level request for data regarding a station feature around a date range
class PredictionRequest(PredictionPromise):
    INTERVAL_MAX_SLACK = 'MAX_SLACK'
    INTERVAL_DEFAULT = '30'
    VEL_TYPE_SPEED_DIR = 'speed_dir'

    # construct the request and save its state, but don't send it
    def __init__(self, manager, stationFeature, startTime, endTime):
        super(PredictionRequest, self).__init__()
        self.manager = manager
        self.stationFeature = stationFeature
        self.startTime = startTime
        self.endTime = endTime
        self.fetcher = QgsNetworkContentFetcher()
        self.fetcher.finished.connect(self.processReply)

    def start(self):
        self.fetcher.fetchContent(QUrl(self.url()))

    def url(self):
        query = QUrlQuery()
        query.addQueryItem('application', CoopsApplicationName)
        query.addQueryItem('begin_date', self.startTime.toString('yyyyMMdd hh:mm'))
        query.addQueryItem('end_date', self.endTime.addSecs(-1).toString('yyyyMMdd hh:mm'))
        query.addQueryItem('units', 'english')
        query.addQueryItem('time_zone', 'gmt')
        query.addQueryItem('product', self.productName)
        query.addQueryItem('format', 'xml')
        self.addQueryItems(query)

        return self.baseUrl + '?' + query.query()

    def addQueryItems(self, query):
        raise Exception('Override required')

    def parseContent(self, content):
        raise Exception('Override required')

    # process the reply from our content-fetching task
    def processReply(self):
        self.predictions = self.parseContent(self.fetcher.contentAsString())
        self.resolve()


class CurrentPredictionRequest(PredictionRequest):

    def __init__(self, manager, stationFeature, start, end):
        super(CurrentPredictionRequest, self).__init__(manager, stationFeature, start, end)
        self.productName = 'currents_predictions'
        self.baseUrl = 'https://api.tidesandcurrents.noaa.gov/api/prod/datagetter'

    def addQueryItems(self, query):
        query.addQueryItem('station', self.stationFeature['id'])
        query.addQueryItem('bin', str(self.stationFeature['bin']))
        query.addQueryItem('vel_type', PredictionRequest.VEL_TYPE_SPEED_DIR)
        query.addQueryItem('interval', PredictionRequest.INTERVAL_DEFAULT)

    def parseContent(self, content):
        root = ET.fromstring(content) 

        f = None
        layer = self.manager.predictionsLayer
        fields = layer.fields()
        features = []
        floodDir = self.stationFeature['meanFloodDir']
        ebbDir = self.stationFeature['meanEbbDir']

        # Get the list of predictions
        cp = root.findall('cp')
        for prediction in cp:
            dt = QDateTime.fromString(prediction.find('Time').text, 'yyyy-MM-dd hh:mm')
            dt.setTimeSpec(Qt.TimeSpec.UTC)   # just to be clear on this, this is a UTC time

            f = QgsFeature(fields)
            f.setGeometry(QgsGeometry(self.stationFeature.geometry()))

            f['station'] = self.stationFeature['station']
            f['depth'] = parseFloatNullable(prediction.find('Depth').text)
            f['time'] = dt
            
            # we have one of several different possibilities:
            #  - timed measurement, flood/ebb, signed velocity
            #  - max/slack measurement, flood/ebb, signed velocity
            #  - timed measurement, varying angle, unsigned velocity
            directionElement = prediction.find('Direction')
            if directionElement != None:
                direction = parseFloatNullable(directionElement.text)
                magnitude = float(prediction.find('Speed').text)
                valtype = 'current'

                # synthesize the value along flood/ebb dimension
                floodFactor = math.cos(math.radians(floodDir - direction))
                ebbFactor = math.cos(math.radians(ebbDir - direction))
                if floodFactor > ebbFactor:
                    value = magnitude * floodFactor
                else:
                    value = -magnitude * ebbFactor

            else:
                vel = float(prediction.find('Velocity_Major').text)
                if (vel >= 0):
                    direction = floodDir
                else:
                    direction = ebbDir
                value = vel
                magnitude = abs(vel)
                typeElement = prediction.find('Type')
                if typeElement != None:
                    valtype = typeElement.text
                else:
                    valtype = 'current'

            f['value'] = value
            f['dir'] = direction
            f['magnitude'] = magnitude
            f['type'] = valtype

            features.append(f)

        return features
