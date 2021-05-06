import math
import numpy as np
from scipy.interpolate import interp1d
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

    # Return a list of surface station features included in the given rectangle.
    def getExtentStations(self, rect):
        return list(filter(lambda f: f['surface'] > 0, self.stationsLayer.getFeatures(rect)))

    # Return a station feature by its unique identifier
    def getStation(self, stationId):
        req = QgsFeatureRequest()
        req.setFilterExpression("station = '{}'".format(stationId))
        for f in self.stationsLayer.getFeatures(req):
            return f
        return None

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
        for p in self.dependencies:
            p.start()

    def doStart(self):
        # subclasses should override this
        return

    # add a promise on which we are dependent. when all dependents are resolved, this one will too.
    def addDependency(self, p):
        self.dependencies.append(p)
        p.resolved(self.checkDependencies)

    def checkDependencies(self):
        if next(filter(lambda p: not p.isResolved, self.dependencies), None) is None:
            self.doProcessing()
            self.resolve()

    def doProcessing(self):
        # subclasses should override this to process dependencies or other intermediate results
        return

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
        scope.setVariable('station', self.stationFeature['station'])
        ctx.appendScope(scope)
        featureRequest.setFilterExpression("station = @station and time >= @startTime and time < @endTime")
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

                # get reference station promise
                refStation = self.manager.getStation(self.stationFeature['refStation'])
                if refStation is None:
                    print("Could not find ref station {} for {}".format(self.stationFeature['refStation'], self.stationFeature['station']))
                    self.refStationData = None
                else:
                    self.refStationData = self.manager.getDataPromise(refStation, self.localDate)
                    self.addDependency(self.refStationData)

    def doProcessing(self):
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

            if self.refStationData is not None:
                print('Interpolating ref station {} for {}'.format(self.refStationData.stationFeature['station'],self.stationFeature['station']))
                # use interpolated reference station data to fill this out
                valueInterpolation = self.refStationData.valueInterpolation()

                # create a time interpolation function that maps events in the subordinate station
                # to adjusted and filtered times in the reference station
                timeInterpolation = self.timeInterpolation()

                firstEventTime = self.datetime.secsTo(self.predictions[0]['time'])
                lastEventTime = self.datetime.secsTo(self.predictions[-1]['time'])
                subTimes = list(range(firstEventTime, lastEventTime, PredictionManager.STEP_MINUTES * 60))
                refTimes = timeInterpolation(np.array(subTimes))

                i = 0
                while refTimes[i] < 0:
                    i += 1
                maxSecs = ((24 * 60) - PredictionManager.STEP_MINUTES) * 60
                j = len(refTimes)
                while refTimes[j-1] > maxSecs:
                    j -= 1
                subTimes = subTimes[i:j]
                refTimes = refTimes[i:j]

                refValues = valueInterpolation(refTimes)
                ebbDir = self.stationFeature['meanEbbDir'] 
                ebbFactor = self.stationFeature['mecAmpAdj']
                floodDir = self.stationFeature['meanFloodDir'] 
                floodFactor = self.stationFeature['mfcAmpAdj']
                refValues = [v * (ebbFactor if v < 0 else floodFactor) for v in refValues]

                fields = self.manager.predictionsLayer.fields()
                for i in range(0, len(subTimes)):
                    f = QgsFeature(fields)
                    f.setGeometry(QgsGeometry(self.stationFeature.geometry()))
                    f['station'] = self.stationFeature['station']
                    f['depth'] = self.stationFeature['depth']
                    f['time'] = self.datetime.addSecs(int(subTimes[i]))
                    f['value'] = float(refValues[i])
                    f['dir'] = ebbDir if refValues[i] < 0 else floodDir
                    f['magnitude'] = abs(f['value'])
                    f['type'] = 'current'
                    self.predictions.append(f)

                self.predictions.sort(key=(lambda p: p['time']))

        # add everything into the predictions layer
        self.manager.predictionsLayer.startEditing()
        self.manager.predictionsLayer.addFeatures(self.predictions, QgsFeatureSink.FastInsert)
        self.manager.predictionsLayer.commitChanges()
        self.manager.predictionsLayer.triggerRepaint()

    def timeInterpolation(self):
        """ return a function that takes an array of time offsets in seconds on this (subordinate) station
            and returns an array of time offsets in seconds on the reference station, relative
            to the start date of this prediction set.
        """

        # search for events, ignoring any initial slack event
        phase = 0    # unknown whether we are in ebb or flood initially
        initialSlack = False
        subTimes = []
        refTimes = []
        phases = []
        for p in self.predictions:
            ptype = p['type']
            time = self.datetime.secsTo(p['time'])
            subTimes.append(time)

            if ptype == 'slack':
                if phase > 0:
                    # slack before ebb (after flood)
                    refTimes.append(time - 60*self.stationFeature['sbeTimeAdjMin'])
                elif phase < 0:
                    # slack before flood (after ebb)
                    refTimes.append(time - 60*self.stationFeature['sbfTimeAdjMin'])
                else:
                    initialSlack = True
                    refTimes.append(time) # we'll correct this after we know what the first phase is
            elif ptype == 'flood':
                phase = 1
                refTimes.append(time - 60*self.stationFeature['mfcTimeAdjMin'])
            elif ptype == 'ebb':
                phase = -1
                refTimes.append(time - 60*self.stationFeature['mecTimeAdjMin'])
            else:
                raise Exception('Unexpected event type ' + ptype)

            phases.append(phase)

        # now fix up any initial slack event we found
        if initialSlack:
            initialPhase = phases[0]
            if initialPhase < 0:
                refTimes[0] = (subTimes[0] - 60*self.stationFeature['sbeTimeAdjMin'])
            else:
                refTimes[0] = (subTimes[0] - 60*self.stationFeature['sbfTimeAdjMin'])

        return interp1d(subTimes, refTimes, 'linear')

    def valueInterpolation(self):
        """ return a function that takes an array of offsets from the start time in seconds, and returns an
            array of interpolated velocities from this object's predictions.
        """
        currentPredictions = list(filter(lambda p: p['type'] == 'current', self.predictions))
        times = np.array([self.datetime.secsTo(p['time']) for p in currentPredictions])
        values = np.array([p['value'] for p in currentPredictions])
        return interp1d(times, values, 'cubic')


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
