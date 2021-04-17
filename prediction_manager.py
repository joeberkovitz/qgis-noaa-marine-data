import math
import xml.etree.ElementTree as ET

from qgis.core import (
    QgsPointXY, QgsPoint, QgsRectangle, QgsFeature, QgsGeometry, QgsField, QgsFields,
    QgsProject, QgsUnitTypes, QgsWkbTypes, QgsCoordinateTransform,
    QgsFeatureRequest, QgsNetworkContentFetcher,
    QgsExpressionContextScope, QgsExpressionContext, QgsFeatureSink,
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
        self.isStarted = False
        self.dependencies = []

    def resolved(self, slot):
        if self.isResolved:
            slot()
        else:
            self._resolved.connect(slot)

    def resolve(self):
        self.isResolved = True
        self._resolved.emit()

    def start(self):
        if self.isStarted:
            return
        self.isStarted = True
        self.doStart()

    def doStart(self):
        # subclasses should override this
        return

    def addDependency(self, p):
        self.dependencies.append(p)
        p.resolved(self.checkDependencies)

    def startDependencies(self):
        for p in self.dependencies:
            p.start()

    def checkDependencies(self):
        if next(filter(lambda p: not p.isResolved, self.dependencies), None) is None:
            self.processDependencies()

    def processDependencies(self):
        # subclasses should override this
        self.resolve()

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
    def doStart(self):
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

        # Create a time based query
        ctx = featureRequest.expressionContext()
        scope = QgsExpressionContextScope()
        scope.setVariable('startTime', startTime)
        scope.setVariable('endTime', endTime)
        ctx.appendScope(scope)
        featureRequest.setFilterExpression("time >= @startTime and time < @endTime")
        featureRequest.addOrderBy('time')

        savedFeatureIterator = self.manager.predictionsLayer.getFeatures(featureRequest)
        savedFeatures = list(savedFeatureIterator)
        if len(savedFeatures) > 0:
            # We have some features, so go ahead and stash them in the layer and resolve this promise
            print ('{}: retrieved {} features from layer'.format(self.stationFeature['station'], len(savedFeatures)))
            self.predictions = savedFeatures
            self.resolve()
        else:
            # The layer didn't have what we wanted, so we must request the data we need.
            # At this point, the situation falls into several possible cases.

            # Case 1: A Harmonic station with known flood/ebb directions. Here
            # we need two requests which can simply be combined and sorted:
            #   1a: EventType, i.e. slack, flood and ebb
            #   1b: SpeedDirType, as velocity can be calculated by projecting along flood/ebb
            #
            # Case 2: A Harmonic station with unknown flood and/or ebb.
            # We actually need to combine 3 requests:
            #   2a: EventType
            #   2b: SpeedDirType, which only provides vector magnitude/angle
            #   2c: VelocityMajorType, which only provides current velocity (but for same times as 2b)

            # Here we set up requests for cases 1 and 2
            if self.stationFeature['type'] == 'H':
                self.speedDirRequest = CurrentPredictionRequest(
                    self.manager,
                    self.stationFeature,
                    startTime,
                    endTime,
                    CurrentPredictionRequest.SpeedDirectionType)
                self.addDependency(self.speedDirRequest)

                self.eventRequest = CurrentPredictionRequest(
                    self.manager,
                    self.stationFeature,
                    startTime,
                    endTime,
                    CurrentPredictionRequest.EventType)
                self.addDependency(self.eventRequest)

                floodDir = self.stationFeature['meanFloodDir']
                ebbDir = self.stationFeature['meanEbbDir']
                if floodDir == NULL or ebbDir == NULL:
                    self.velocityRequest = CurrentPredictionRequest(
                        self.manager,
                        self.stationFeature,
                        startTime,
                        endTime,
                        CurrentPredictionRequest.VelocityMajorType)
                    self.addDependency(self.velocityRequest)
                else:
                    self.velocityRequest = None

            # Case 3: A Subordinate station which only knows its events. Here we need the following:
            #   3a: EventType (for this station)
            #   3b: A resolved data promise for the reference station (which may itself be Cases 1 or 2, but
            #       we don't care as long as its data is present.)
            else:
                self.eventRequest = CurrentPredictionRequest(
                    self.manager,
                    self.stationFeature,
                    startTime,
                    endTime,
                    CurrentPredictionRequest.EventType)
                self.addDependency(self.eventRequest)

                # TODO: get reference promise

            self.startDependencies()

    def processDependencies(self):
        if self.stationFeature['type'] == 'H':
            # We will always have a speed/direction request
            self.predictions = self.speedDirRequest.predictions

            # If we also had a velocity request with the same number of results
            # try to combine it with this one.
            if (self.velocityRequest is not None
                    and (len(self.velocityRequest.predictions) == len(self.predictions))):
                for i, p in enumerate(self.predictions):
                    p['value'] = self.velocityRequest.predictions[i]['value']

            # Now fold in the events and sort everything by time
            self.predictions.extend(self.eventRequest.predictions)
            self.predictions.sort(key=(lambda p: p['time']))
        else:
            # subordinate-station case
            self.predictions = self.eventRequest.predictions
            # TODO: use interpolated reference station data to fill this out

        # add everything into the predictions layer
        self.manager.predictionsLayer.startEditing()
        self.manager.predictionsLayer.addFeatures(self.predictions, QgsFeatureSink.FastInsert)
        self.manager.predictionsLayer.commitChanges()
        self.resolve()

        self.manager.predictionsLayer.triggerRepaint()


# low-level request for data regarding a station feature around a date range
class PredictionRequest(PredictionPromise):

    # construct the request and save its state, but don't send it
    def __init__(self, manager, stationFeature, startTime, endTime):
        super(PredictionRequest, self).__init__()
        self.manager = manager
        self.stationFeature = stationFeature
        self.startTime = startTime
        self.endTime = endTime
        self.fetcher = QgsNetworkContentFetcher()
        self.fetcher.finished.connect(self.processReply)

    def doStart(self):
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
    SpeedDirectionType = 0
    VelocityMajorType = 1
    EventType = 2

    INTERVAL_MAX_SLACK = 'MAX_SLACK'
    INTERVAL_DEFAULT = str(PredictionManager.STEP_MINUTES)
    VEL_TYPE_SPEED_DIR = 'speed_dir'
    VEL_TYPE_DEFAULT = 'default'

    def __init__(self, manager, stationFeature, start, end, requestType):
        super(CurrentPredictionRequest, self).__init__(manager, stationFeature, start, end)
        self.productName = 'currents_predictions'
        self.baseUrl = 'https://api.tidesandcurrents.noaa.gov/api/prod/datagetter'
        self.requestType = requestType
        print('{}: Requesting type {} for {}'.format(self.stationFeature['station'],self.requestType,start.toString()))

    def addQueryItems(self, query):
        query.addQueryItem('station', self.stationFeature['id'])
        query.addQueryItem('bin', str(self.stationFeature['bin']))
        if self.requestType == self.SpeedDirectionType:
            query.addQueryItem('vel_type', self.VEL_TYPE_SPEED_DIR)
            query.addQueryItem('interval', self.INTERVAL_DEFAULT)
        elif self.requestType == self.VelocityMajorType:
            query.addQueryItem('vel_type', self.VEL_TYPE_DEFAULT)
            query.addQueryItem('interval', self.INTERVAL_DEFAULT)
        else:
            query.addQueryItem('interval', self.INTERVAL_MAX_SLACK)

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

                # synthesize the value along flood/ebb dimension if possible
                if floodDir != NULL and ebbDir != NULL:
                    floodFactor = math.cos(math.radians(floodDir - direction))
                    ebbFactor = math.cos(math.radians(ebbDir - direction))
                    if floodFactor > ebbFactor:
                        value = magnitude * floodFactor
                    else:
                        value = -magnitude * ebbFactor
                else:
                    value = NULL  # we wil have to get this by asking for it explicily

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
