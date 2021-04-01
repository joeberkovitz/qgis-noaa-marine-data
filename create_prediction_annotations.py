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

            # TODO: big problem in that temporal scope is not used to evaluate the HTML. may have to
            # hack this by saving any temporal scope here to layer variables that can be accessed by the template...
            # or to auxiliary storage attributes (ugh, but probably has correct behavior)

            # TODO: this size and offset are wack. Can we dynamically calculate from the content somehow?
            a.setFrameSize(QSizeF(200, 160))
            a.setFrameOffsetFromReferencePoint(QPointF(-200,-200))
            a.setMapPosition(feature.geometry().asPoint())
            a.setMapPositionCrs(QgsCoordinateReferenceSystem(layer.crs()))

            QgsProject.instance().annotationManager().addAnnotation(a)
            break