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
from .provider import NoaaTidalPredictionsProvider
from .tidal_prediction_tool import TidalPredictionTool
from .tidal_prediction_widget import TidalPredictionWidget

import os.path
import processing

class NoaaTidalPredictions:
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
        self.provider = NoaaTidalPredictionsProvider()
        self.toolbar = self.iface.addToolBar('NOAA Tidal Predictions Toolbar')
        self.toolbar.setObjectName('NoaaTidalPredictionsToolbar')

        # initialize plugin directory
        self.plugin_dir = os.path.dirname(__file__)

        # initialize locale
        locale = QSettings().value('locale/userLocale')[0:2]
        locale_path = os.path.join(
            self.plugin_dir,
            'i18n',
            'NoaaTidalPredictions_{}.qm'.format(locale))

        if os.path.exists(locale_path):
            translator = QTranslator()
            translator.load(locale_path)
            QCoreApplication.installTranslator(translator)

        # Declare instance attributes
        self.actions = []
        self.menu = tr(u'&NOAA Tidal Predictions')

        self.dock = TidalPredictionWidget(None, self.canvas)
        self.iface.addDockWidget(Qt.RightDockWidgetArea, self.dock)
        self.dock.hide()

        self.predictionTool = None

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
        checkable_flag=False,
        add_to_menu=True,
        add_to_toolbar=True,
        status_tip=None,
        whats_this=None,
        parent=None):

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
            self.toolbar.addAction(action)

        if add_to_menu:
            self.iface.addPluginToMenu(
                self.menu,
                action)

        if checkable_flag:
            action.setCheckable(True)

        self.actions.append(action)

        return action

    def initGui(self):
        """Create the menu entries and toolbar icons inside the QGIS GUI."""

        self.add_action(
            os.path.join(self.plugin_dir, 'svg/add_current_stations_layer.svg'),
            text=tr(u'Add Current Stations Layer'),
            callback=self.addCurrentStationsLayer,
            parent=self.iface.mainWindow())

        self.predictionAction = self.add_action(
            os.path.join(self.plugin_dir, 'svg/get_tidal_predictions.svg'),
            text=tr(u'Get Tidal Predictions'),
            callback=self.getTidalPredictions,
            checkable_flag=True,
            parent=self.iface.mainWindow())

        self.savedMapTool = self.canvas.mapTool()
        if self.predictionTool == None:
            self.predictionTool = TidalPredictionTool(self.canvas, self.dock)

        self.canvas.mapToolSet.connect(self.unsetTool)

    def unsetTool(self, tool):
        try:
            if not isinstance(tool, TidalPredictionTool):
                self.predictionAction.setChecked(False)
        except Exception:
            pass

    def unload(self):
        self.dock.hide()
        if self.canvas.mapTool() == self.predictionTool:
            self.canvas.setMapTool(self.savedMapTool)

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


    def addCurrentStationsLayer(self):
        processing.execAlgorithmDialog('NoaaTidalPredictions:addcurrentstationslayer', {})

    def getTidalPredictions(self):
        self.predictionAction.setChecked(True)
        self.canvas.setMapTool(self.predictionTool)

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
                values[0].setTimeSpec(Qt.TimeSpec.UTC)
                if (values[0] >= range.begin() and values[0] < range.end()):
                    return True
                else:
                    return False
            else:
                return True

        return False
