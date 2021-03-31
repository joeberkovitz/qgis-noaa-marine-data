import os

from qgis.PyQt.QtCore import pyqtSignal, QSettings, QSizeF, QPointF
from qgis.PyQt.QtGui import QColor
from qgis.core import (
    QgsProject, QgsGeometry, QgsPoint, QgsWkbTypes, QgsExpression, QgsExpressionContext, QgsExpressionContextUtils,
    QgsHtmlAnnotation, QgsFeature, QgsCoordinateReferenceSystem,
)

from qgis.gui import QgsMapToolIdentify, QgsMapCanvasAnnotationItem


class CreatePredictionAnnotationsTool(QgsMapToolIdentify):

    def __init__(self, canvas):
        super(QgsMapToolIdentify, self).__init__(canvas)
        self.canvas = canvas
        self.selectionMode = self.ActiveLayer  # TODO: maybe this can use all layers 

    def canvasReleaseEvent(self, mouseEvent):
        results = self.identify(mouseEvent.x(), mouseEvent.y(), self.selectionMode, self.VectorLayer)
        for r in results:
            # TODO: filter out features in layers that aren't relevant
            if False:
                continue

            layer = r.mLayer
            feature = r.mFeature

            a = QgsHtmlAnnotation()
            a.setMapLayer(layer)
            html = os.path.join(os.path.dirname(__file__),'html','current_predictions_annotation.html')
            a.setSourceFile(html)
            a.setAssociatedFeature(feature)

            a.setFrameSize(QSizeF(100, 50))
            a.setFrameOffsetFromReferencePoint(QPointF(30, 30))
            a.setMapPosition(feature.geometry().asPoint())
            a.setMapPositionCrs(QgsCoordinateReferenceSystem(layer.crs()))

            QgsProject.instance().annotationManager().addAnnotation(a)
            break