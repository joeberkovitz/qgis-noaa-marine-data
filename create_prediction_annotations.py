import os

from qgis.PyQt.QtCore import pyqtSignal, QSettings, QSizeF, QPointF, Qt
from qgis.PyQt.QtGui import QColor, QCursor
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
        self.currentMoveAction = QgsMapCanvasAnnotationItem.NoAction
        self.cursor = QCursor()
        self.cursor.setShape(Qt.ArrowCursor)
        self.setCursor(self.cursor)

    def canvasPressEvent(self, mouseEvent):
        self.lastMousePosition = mouseEvent.pos();

        item = self.selectedItem()
        if item:
            self.currentMoveAction = item.moveActionForPosition(mouseEvent.pos())
            if self.currentMoveAction != QgsMapCanvasAnnotationItem.NoAction:
                return

        # select a new item if there is one at this position
        if (not item) or self.currentMoveAction == QgsMapCanvasAnnotationItem.NoAction:
            self.canvas.scene().clearSelection()
            existingItem = self.itemAtPos(mouseEvent.pos())
            if existingItem:
                existingItem.setSelected(True)

    def canvasMoveEvent(self, mouseEvent):
        item = self.selectedItem()
        if not item:
          return

        annotation = item.annotation()
        if not annotation:
          return

        pixelToMmScale = 25.4 / self.canvas.logicalDpiX()
        if self.currentMoveAction == QgsMapCanvasAnnotationItem.MoveFramePosition:
            # move the entire frame
            newCanvasPos = item.pos() + (mouseEvent.pos() - self.lastMousePosition)
            if annotation.hasFixedMapPosition():
                deltaX = pixelToMmScale * (mouseEvent.pos().x() - self.lastMousePosition.x())
                deltaY = pixelToMmScale * (mouseEvent.pos().y() - self.lastMousePosition.y())
                annotation.setFrameOffsetFromReferencePointMm(
                    QPointF(annotation.frameOffsetFromReferencePointMm().x() + deltaX,
                            annotation.frameOffsetFromReferencePointMm().y() + deltaY))
                annotation.setRelativePosition(
                    QPointF(newCanvasPos.x() / self.canvas.width(),
                            newCanvasPos.y() / self.canvas.height()))
                item.update()
                QgsProject.instance().setDirty(True)

        elif self.currentMoveAction != QgsMapCanvasAnnotationItem.NoAction:
            # handle vertical frame resize actions only
            size = annotation.frameSizeMm()
            xmin = annotation.frameOffsetFromReferencePointMm().x()
            ymin = annotation.frameOffsetFromReferencePointMm().y()
            xmax = xmin + size.width();
            ymax = ymin + size.height();
            relPosX = annotation.relativePosition().x()
            relPosY = annotation.relativePosition().y()

            if (self.currentMoveAction == QgsMapCanvasAnnotationItem.ResizeFrameUp or
                    self.currentMoveAction == QgsMapCanvasAnnotationItem.ResizeFrameLeftUp or
                    self.currentMoveAction == QgsMapCanvasAnnotationItem.ResizeFrameRightUp):
                ymin += pixelToMmScale * ( mouseEvent.pos().y() - self.lastMousePosition.y() )
                relPosY = ( relPosY * self.canvas.height() + mouseEvent.pos().y() - self.lastMousePosition.y() ) / self.canvas.height()

            if (self.currentMoveAction == QgsMapCanvasAnnotationItem.ResizeFrameDown or
                    self.currentMoveAction == QgsMapCanvasAnnotationItem.ResizeFrameLeftDown or
                    self.currentMoveAction == QgsMapCanvasAnnotationItem.ResizeFrameRightDown):
                ymax += pixelToMmScale * ( mouseEvent.pos().y() - self.lastMousePosition.y() )

            # switch min / max if necessary
            if xmax < xmin:
                tmp = xmax
                xmax = xmin
                xmin = tmp
            if ymax < ymin:
                tmp = ymax
                ymax = ymin
                ymin = tmp
            annotation.setFrameOffsetFromReferencePointMm( QPointF( xmin, ymin ) )
            annotation.setFrameSizeMm( QSizeF( xmax - xmin, ymax - ymin ) )
            annotation.setRelativePosition( QPointF( relPosX, relPosY ) )
            item.update()
            QgsProject.instance().setDirty(True)

        moveAction = item.moveActionForPosition(mouseEvent.pos())
        cursor = QCursor()
        cursor.setShape(item.cursorShapeForAction(moveAction))
        self.setCursor(cursor)

        self.lastMousePosition = mouseEvent.pos()

    def canvasReleaseEvent(self, mouseEvent):
        self.currentMoveAction = QgsMapCanvasAnnotationItem.NoAction
        self.setCursor(self.cursor)

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
            # hack this by saving any temporal scope here to layer variables that can be accessed by the templatmouseEvent...
            # or to auxiliary storage attributes (ugh, but probably has correct behavior)

            # TODO: this size and offset are wack. Can we dynamically calculate from the content somehow?
            a.setFrameSize(QSizeF(200, 160))
            a.setFrameOffsetFromReferencePoint(QPointF(-200,-200))
            a.setMapPosition(feature.geometry().asPoint())
            a.setMapPositionCrs(QgsCoordinateReferenceSystem(layer.crs()))

            QgsProject.instance().annotationManager().addAnnotation(a)

            # select the just-created annotation to make it easy to move or resize
            item = self.itemForAnnotation(a)
            if item:
                self.canvas.scene().clearSelection()
                item.setSelected(True)
            break

    def keyPressEvent(self, keyEvent):
        item = self.selectedItem()
        if item:
            if keyEvent.key() == Qt.Key_Backspace or keyEvent.key() == Qt.Key_Delete:
                QgsProject.instance().annotationManager().removeAnnotation(item.annotation())
                self.setCursor(self.cursor)
                keyEvent.ignore()

    def selectedItem(self):
        for item in self.canvas.annotationItems():
            if item.isSelected():
                return item
        return None

    def itemAtPos(self, point):
        for item in self.canvas.annotationItems():
            if item.moveActionForPosition(point) == QgsMapCanvasAnnotationItem.MoveFramePosition:
                return item
        return None

    def itemForAnnotation(self, annotation):
        for item in self.canvas.annotationItems():
            if item.annotation() == annotation:
                return item
        return None

