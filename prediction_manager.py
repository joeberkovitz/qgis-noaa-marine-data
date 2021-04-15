import xml.etree.ElementTree as ET

from qgis.core import (
    QgsPointXY, QgsPoint, QgsFeature, QgsGeometry, QgsField, QgsFields,
    QgsProject, QgsUnitTypes, QgsWkbTypes, QgsCoordinateTransform
)

from qgis.PyQt.QtCore import pyqtSlot, pyqtSignal

# one of these for currents and one for tides
class PredictionManager:
    def __init__(self):
        self.promiseDict = {}

    # maintains a map of stashed, unsent PredictionRequests. these are not sent until
    # the manager is told to initiate them, so that multiple requests can be folded.


    # get a PredictionDataPromise for 24-hour period starting with the given UTC date
    def getDataPromise(self, stationFeature, date):
        key = self.promiseKey(stationFeature, date)
        promise = self.promiseDict.get(key)
        if promise is None:
            promise = PredictionDataPromise(self, stationFeature, date)
            self.promiseDict[key] = promise
            promise.start()
        return promise

    def getPredictions(self, feature, datetime):
        # return an iterable of prediction layer features for the given
        # station feature on the given local date. If any part of the range
        # is missing, return None
        return None

    def promiseKey(self, stationFeature, datetime):
        return stationFeature['station'] + '.' + datetime.toString('yyyyMMdd')


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
        self.datetime = QDateTime(date, QTime(0,0), stationTimeZone(stationFeature))

    def start(self):
        if self.predictions is not None:
            self.done()
            return

        req = CurrentPredictionRequest(
            self.manager,
            self.stationFeature,
            self.datetime,
            self.datetime.addDays(1),
        )
        req.resolved(self.processRequest)
        self.dependencies.append(req)
        req.start()

    def processRequest(self):
        if self.checkDependencies():
            self.predictions = []
            for req in self.dependencies:
                self.predictions.extend(req.predictions)
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
        query.addQueryItem('end_date', self.endTime.toString('yyyyMMdd hh:mm'))
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
        layer = currentPredictionsLayer()
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


