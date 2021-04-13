import os

from qgis.PyQt.QtCore import pyqtSignal, QSettings, QSizeF, QPointF, Qt
from qgis.PyQt.QtGui import QColor, QCursor
from qgis.core import (
    QgsProject, QgsGeometry, QgsPoint, QgsWkbTypes, QgsExpression, QgsExpressionContext, QgsExpressionContextUtils,
    QgsHtmlAnnotation, QgsFeature, QgsCoordinateReferenceSystem,
)

from qgis.gui import QgsMapToolIdentify, QgsMapCanvasAnnotationItem
from .utils import *

class TidalPredictionTool(QgsMapToolIdentify):

    def __init__(self, canvas, dock):
        super(QgsMapToolIdentify, self).__init__(canvas)
        self.canvas = canvas
        self.dock = dock

        self.selectionMode = self.AllLayers

        self.cursor = QCursor()
        self.cursor.setShape(Qt.ArrowCursor)
        self.setCursor(self.cursor)

    def canvasPressEvent(self, mouseEvent):
        return

    def canvasMoveEvent(self, mouseEvent):
        return

    def canvasReleaseEvent(self, mouseEvent):
        self.currentMoveAction = QgsMapCanvasAnnotationItem.NoAction
        self.setCursor(self.cursor)

        layers = []
        currentStationsLayerId = QgsProject.instance().customVariables()[CurrentStationsLayerVar]
        currentStationsLayer = QgsProject.instance().mapLayer(currentStationsLayerId)
        if currentStationsLayer is not None:
            layers.append(currentStationsLayer)

        results = self.identify(mouseEvent.x(), mouseEvent.y(), layers)
        for r in results:
            layer = r.mLayer

            if layer == currentStationsLayer:
                feature = r.mFeature
                self.dock.setCurrentStation(feature)
                break

    def activate(self):
        self.dock.show()

    def deactivate(self):
        self.dock.hide()
