import math
import xml.etree.ElementTree as ET

from qgis.core import (
    QgsPointXY, QgsPoint, QgsRectangle, QgsFeature, QgsGeometry, QgsField, QgsFields,
    QgsProject, QgsUnitTypes, QgsWkbTypes, QgsCoordinateTransform,
    QgsFeatureRequest, QgsNetworkContentFetcher,
    NULL
)

from qgis.PyQt.QtCore import (
    pyqtSlot, pyqtSignal,
    QObject, QDate, QDateTime, QTime, QTimeZone, QUrl, QUrlQuery,
)

from .utils import *


class PredictionManager:
    """Manager object overseeing the loading and caching of predictions
        organized by station-dates.
    """

    # The time increment used for prediction requests and temporal display control.
    STEP_MINUTES = 30

    # Each manager has a stations and a prediction layer. There's a manager for tides
    # and one for currents.
    def __init__(self, stationsLayer, predictionsLayer):
        # Initialize a map of cached PredictionDataPromises
        self.promiseDict = {}
        self.stationsLayer = stationsLayer
        self.predictionsLayer = predictionsLayer


    # Obtain a PredictionDataPromise for 24-hour period starting with the given local-station-time date
    def getDataPromise(self, stationFeature, date):
        key = self.promiseKey(stationFeature, date)
        promise = self.promiseDict.get(key)
        if promise is None:
            # we have no cached data promise. so make one. This implicitly requests the data
            # if it is not already in the predictions layer.
            promise = PredictionDataPromise(self, stationFeature, date)
            self.promiseDict[key] = promise
            promise.start()

        return promise

    # Return a list of station features included in the give rectangle.
    def getExtentStations(self, rect):
        return list(self.stationsLayer.getFeatures(rect))

    # Compute a key
    @staticmethod
    def promiseKey(stationFeature, date):
        return stationFeature['station'] + '.' + date.toString('yyyyMMdd')


class PredictionPromise(QObject):
    """ Abstract promise-like object that emits a resolved signal when done with something.
        A list of PredictionPromise dependencies is maintained.

    """
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

class PredictionDataPromise(PredictionPromise):
    """ Promise to obtain a full set of predictions (events and timeline) for a given station and local date.
    """

    # initialize this promise for a given manager, station and date.
    def __init__(self, manager, stationFeature, date):
        super(PredictionDataPromise, self).__init__()
        self.manager = manager
        self.stationFeature = stationFeature
        self.predictions = None

        # convert local station timezone QDate to a full UTC QDateTime.
        self.localDate = date
        self.datetime = QDateTime(date, QTime(0,0), stationTimeZone(stationFeature)).toUTC()

    """ Get all the data needed to resolve this promise
    """
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
        # TODO: append variable def scope to the feature req's expressioncontext
        # rather than the cheesy quoting business below. In fact, we should be able to
        # set up this scope in advance and just rebind the variables as needed.
            # ctx=req.expressionContext()
            # scope=QgsExpressionContextScope()
            # scope.setVariable('s','SFB1309_11')
            # ctx.appendScope(scope)

        expr = "time >= to_datetime('{}') and time < to_datetime('{}')".format(
                   startTime.toString('yyyy-MM-dd hh:mm'),
                   endTime.toString('yyyy-MM-dd hh:mm')
                )
        featureRequest.setFilterExpression(expr)
        featureRequest.addOrderBy('time')
        savedFeatureIterator = self.manager.predictionsLayer.getFeatures(featureRequest)
        savedFeatures = list(savedFeatureIterator)
        if len(savedFeatures) > 0:
            # We have some features, so go ahead and stash them in the layer and resolve this promise
            print ('{}: retrieved {} features from layer'.format(self.stationFeature['station'], len(savedFeatures)))
            self.predictions = savedFeatures
            self.resolve()
        else:
            # The layer didn't have what we wanted, so create a request as a dependency promise
            # and kick it off. It will let us know when we are done.
            req = CurrentPredictionRequest(
                self.manager,
                self.stationFeature,
                startTime,
                endTime
            )
            print('{}: Fetching features for {}'.format(self.stationFeature['station'],startTime.toString()))
            req.resolved(self.processRequest)
            self.dependencies.append(req)
            req.start()

    def processRequest(self):
        # TODO: some dependencies contribute data while others don't. Combining all of them is wrong sometimes.
        if self.checkDependencies():
            self.predictions = []
            for req in self.dependencies:
                print('{}: Fetched {} features'.format(self.stationFeature['station'],len(req.predictions)))
                self.predictions.extend(req.predictions)

            # TODO: sort the combined predictions here by time

            self.manager.predictionsLayer.startEditing()
            self.manager.predictionsLayer.addFeatures(self.predictions)
            self.manager.predictionsLayer.commitChanges()
            self.resolve()

            self.manager.predictionsLayer.triggerRepaint()


# low-level request for data regarding a station feature around a date range
class PredictionRequest(PredictionPromise):
    INTERVAL_MAX_SLACK = 'MAX_SLACK'
    INTERVAL_DEFAULT = str(PredictionManager.STEP_MINUTES)
    VEL_TYPE_SPEED_DIR = 'speed_dir'
    VEL_TYPE_DEFAULT = 'default'

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
        query.addQueryItem('interval', PredictionRequest.INTERVAL_DEFAULT)
        if self.stationFeature['meanFloodDir'] == NULL or self.stationFeature['meanEbbDir'] == NULL:
            query.addQueryItem('vel_type', PredictionRequest.VEL_TYPE_DEFAULT)
        else:
            query.addQueryItem('vel_type', PredictionRequest.VEL_TYPE_SPEED_DIR)

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
