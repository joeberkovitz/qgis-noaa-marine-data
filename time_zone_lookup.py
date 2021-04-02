import os

from qgis.core import (
    QgsPointXY, QgsPoint, QgsFeature, QgsGeometry,
    QgsGeometryEngine, QgsField, QgsFields, QgsVectorLayer)


from qgis.PyQt.QtCore import QDateTime, QTimeZone

TZ_IANA_ID = 'tz_name1st'
TZ_UTC_ID = 'time_zone'

class TimeZoneLookup:
    def __init__(self):
        self.zones = []
        self.tzLayer = None

    def getZoneByCoordinates(self, lat, lng):
        point = QgsPoint(lng, lat)
        for (zid, zutc, engine) in self.getZones():
            if engine.contains(point):
                return (zid, zutc)

        return None

    def getZones(self):
        self.ensureZonesLoaded()
        return self.zones

    def ensureZonesLoaded(self):
        if not self.tzLayer:
            filename = os.path.join(os.path.dirname(__file__),'data','timezones.gpkg')
            self.tzLayer = QgsVectorLayer(filename, 'timezones', 'ogr')

            for (index, feature) in enumerate(self.tzLayer.getFeatures()):
                zid = feature[TZ_IANA_ID]
                zutc = feature[TZ_UTC_ID]
                engine = QgsGeometry.createGeometryEngine(feature.geometry().constGet())
                engine.prepareGeometry()
                zone = (zid, zutc, engine)
                self.zones.append(zone)
