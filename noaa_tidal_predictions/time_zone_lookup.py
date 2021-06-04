import os

from qgis.core import (
    QgsPointXY, QgsPoint, QgsFeature, QgsGeometry,
    QgsGeometryEngine, QgsField, QgsFields, QgsVectorLayer)


from qgis.PyQt.QtCore import QDateTime, QTimeZone

TZ_IANA_ID = 'tz_name1st'
TZ_UTC_ID = 'time_zone'

class TimeZoneLookup:
    zones = []
    tzLayer = None

    def getZoneByCoordinates(self, lat, lng):
        point = QgsPoint(lng, lat)
        for (zid, zutc, engine) in self.getZones():
            if engine.contains(point):
                return (zid, zutc)

        raise Exception("No time zone found at {},{}".format(lat,lng))
    
    def getZones(self):
        self.ensureZonesLoaded()
        return TimeZoneLookup.zones

    def ensureZonesLoaded(self):
        if not TimeZoneLookup.tzLayer:
            filename = os.path.join(os.path.dirname(__file__),'data','timezones.gpkg')
            TimeZoneLookup.tzLayer = QgsVectorLayer(filename, 'timezones', 'ogr')

            for (index, feature) in enumerate(TimeZoneLookup.tzLayer.getFeatures()):
                zid = feature[TZ_IANA_ID]
                zutc = feature[TZ_UTC_ID]
                engine = QgsGeometry.createGeometryEngine(feature.geometry().constGet())
                engine.prepareGeometry()
                zone = (zid, zutc, engine)
                TimeZoneLookup.zones.append(zone)
