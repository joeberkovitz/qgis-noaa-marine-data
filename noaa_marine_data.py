# -*- coding: utf-8 -*-
"""
/***************************************************************************
 CompassRoutes
                                 A QGIS plugin
 This plugin creates layers that automatically label route legs with distance and magnetic bearing
 Generated by Plugin Builder: http://g-sherman.github.io/Qgis-Plugin-Builder/
                              -------------------
        begin                : 2021-03-05
        git sha              : $Format:%H$
        copyright            : (C) 2021 by Joe Berkovitz
        email                : joseph.berkovitz@gmail.com
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/
"""
from qgis.PyQt.QtCore import QSettings, QTranslator, QCoreApplication, Qt, QTimeZone, QDateTime, QByteArray
from qgis.PyQt.QtGui import QIcon, QColor
from qgis.PyQt.QtWidgets import QAction

from qgis.core import (
    Qgis, QgsApplication, QgsCoordinateTransform, QgsCoordinateReferenceSystem,
    QgsUnitTypes, QgsWkbTypes, QgsGeometry, QgsFields, QgsField,
    QgsProject, QgsVectorLayer, QgsFeature, QgsPoint, QgsPointXY, QgsLineString, QgsDistanceArea,
    QgsArrowSymbolLayer, QgsLineSymbol, QgsSingleSymbolRenderer,
    QgsPalLayerSettings, QgsVectorLayerSimpleLabeling, QgsSettings,QgsExpression,QgsExpressionContextUtils)

from qgis.core import qgsfunction

from qgis.utils import iface

from datetime import *
import math

# Initialize Qt resources from file resources.py
from .resources import *
from .utils import *
from .provider import NoaaMarineDataProvider
from .create_prediction_annotations import CreatePredictionAnnotationsTool

import os.path
import processing

class NoaaMarineData:
    """QGIS Plugin Implementation."""

    def __init__(self, iface):
        """Constructor.

        :param iface: An interface instance that will be passed to this class
            which provides the hook by which you can manipulate the QGIS
            application at run time.
        :type iface: QgsInterface
        """
        # Save reference to the QGIS interface
        self.iface = iface
        self.canvas = iface.mapCanvas()
        self.provider = NoaaMarineDataProvider()

        # initialize plugin directory
        self.plugin_dir = os.path.dirname(__file__)

        # initialize locale
        locale = QSettings().value('locale/userLocale')[0:2]
        locale_path = os.path.join(
            self.plugin_dir,
            'i18n',
            'NoaaMarineData_{}.qm'.format(locale))

        if os.path.exists(locale_path):
            translator = QTranslator()
            translator.load(locale_path)
            QCoreApplication.installTranslator(translator)

        # Declare instance attributes
        self.actions = []
        self.menu = tr(u'&NOAA Marine Data')

        QgsApplication.processingRegistry().addProvider(self.provider)

        QgsExpression.registerFunction(self.format_time_zone)
        QgsExpression.registerFunction(self.convert_to_time_zone)
        QgsExpression.registerFunction(self.is_time_visible)

    def add_action(
        self,
        icon_path,
        text,
        callback,
        enabled_flag=True,
        add_to_menu=True,
        add_to_toolbar=True,
        status_tip=None,
        whats_this=None,
        parent=None):
        """Add a toolbar icon to the toolbar.

        :param icon_path: Path to the icon for this action. Can be a resource
            path (e.g. ':/plugins/foo/bar.png') or a normal file system path.
        :type icon_path: str

        :param text: Text that should be shown in menu items for this action.
        :type text: str

        :param callback: Function to be called when the action is triggered.
        :type callback: function

        :param enabled_flag: A flag indicating if the action should be enabled
            by default. Defaults to True.
        :type enabled_flag: bool

        :param add_to_menu: Flag indicating whether the action should also
            be added to the menu. Defaults to True.
        :type add_to_menu: bool

        :param add_to_toolbar: Flag indicating whether the action should also
            be added to the toolbar. Defaults to True.
        :type add_to_toolbar: bool

        :param status_tip: Optional text to show in a popup when mouse pointer
            hovers over the action.
        :type status_tip: str

        :param parent: Parent widget for the new action. Defaults None.
        :type parent: QWidget

        :param whats_this: Optional text to show in the status bar when the
            mouse pointer hovers over the action.

        :returns: The action that was created. Note that the action is also
            added to self.actions list.
        :rtype: QAction
        """

        icon = QIcon(icon_path)
        action = QAction(icon, text, parent)
        action.triggered.connect(callback)
        action.setEnabled(enabled_flag)

        if status_tip is not None:
            action.setStatusTip(status_tip)

        if whats_this is not None:
            action.setWhatsThis(whats_this)

        if add_to_toolbar:
            # Adds plugin icon to Plugins toolbar
            self.iface.addToolBarIcon(action)

        if add_to_menu:
            self.iface.addPluginToMenu(
                self.menu,
                action)

        self.actions.append(action)

        return action

    def initGui(self):
        """Create the menu entries and toolbar icons inside the QGIS GUI."""

        icon_path = ':/plugins/noaa_marine_data/icon.png'

        self.add_action(
            icon_path,
            text=tr(u'Add Current Stations Layer'),
            callback=self.addCurrentStationsLayer,
            parent=self.iface.mainWindow())

        self.add_action(
            icon_path,
            text=tr(u'Get Tidal Predictions'),
            callback=self.getTidalPredictions,
            parent=self.iface.mainWindow())

        self.add_action(
            icon_path,
            text=tr(u'Annotate Predictions'),
            callback=self.annotateTidalPredictions,
            parent=self.iface.mainWindow())

        self.annotationTool = CreatePredictionAnnotationsTool(self.canvas)

        self.savedMapTool = self.canvas.mapTool()


    def unload(self):
        """Removes the plugin menu item and icon from QGIS GUI."""
        for action in self.actions:
            self.iface.removePluginMenu(
                self.menu,
                action)
            self.iface.removeToolBarIcon(action)

        QgsApplication.processingRegistry().removeProvider(self.provider)

        QgsExpression.unregisterFunction('format_time_zone')
        QgsExpression.unregisterFunction('is_time_visible')
        QgsExpression.unregisterFunction('convert_to_time_zone')

        if self.canvas.mapTool() == self.annotationTool:
            self.canvas.setMapTool(self.savedMapTool)


    def addCurrentStationsLayer(self):
        processing.execAlgorithmDialog('noaamarinedata:addcurrentstationslayer', {})

    def getTidalPredictions(self):
        processing.execAlgorithmDialog('noaamarinedata:gettidalpredictions', {
            'mapSettings': iface.mapCanvas().mapSettings()
        })

    def annotateTidalPredictions(self):
        self.canvas.setMapTool(self.annotationTool)

    # Custom expression function to determine whether a prediction feature's time is subject to temporal filtering or not
    @qgsfunction(args=-1, group='Date and Time', register=False)
    def convert_to_time_zone(values, feature, parent):
        """Converts the given datetime to a time zone.<br>
        <br>
        convert_to_time_zone(datetime, utcId[, ianaId])<br>
        <br>
        datetime -- a datetime to convert<br>
        utcId -- a required string UTC offset, e.g. 'UTC+01:00'
        ianaId -- an optional IANA timezone ID, e.g. 'America/Chicago'
        """
        dt = values[0]
        utcId = values[1]
        tz = None

        if len(values) >= 3:
            ianaId = values[2]
            if ianaId:
                tz = QTimeZone(QByteArray(ianaId.encode()))   # if we have IANA, we'll try it
                if not tz.isValid():
                    tz = None           # wasn't available on our system, we guess
        if not tz:
            tz = QTimeZone(QByteArray(utcId.encode()))   # our fallback position is to use UTC

        return dt.toTimeZone(tz)

    @qgsfunction(args=2, group='Date and Time', register=False)
    def format_time_zone(values, feature, parent):
        """Formats the time zone of the given datetime to a string.<br>
        <br>
        format_time_zone(datetime, format)<br>
        <br>
        datetime -- a datetime to format<br>
        format -- an integer determining the format: 0=default, 1=long, 2=short
        """
        return values[0].timeZone().displayName(values[0], values[1])

    # Custom expression function to check a time to see if it passes the current temporal filter
    @qgsfunction(args=1, group='Date and Time', register=False)
    def is_time_visible(values, feature, parent):
        """Returns True if the given datetime is within range of any temporal filter, or if there
        is no temporal filter, else returns False.<br>
        <br>
        is_time_visible(datetime)
        """

        canvas = iface.mapCanvas()
        if canvas and feature:
            if canvas.mapSettings().isTemporal():
                range = canvas.mapSettings().temporalRange()
                return (values[0] >= range.begin() and values[0] < range.end())
            else:
                return True

        return False
