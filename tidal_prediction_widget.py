import os

from qgis.PyQt import QtWidgets, uic

FORM_CLASS, _ = uic.loadUiType(os.path.join(
    os.path.dirname(__file__), 'tidal_prediction_widget.ui'))


class TidalPredictionWidget(QtWidgets.QDockWidget, FORM_CLASS):
    def __init__(self, parent=None):
        """Constructor."""
        super(TidalPredictionWidget, self).__init__(parent)
        self.setupUi(self)

    def setCurrentStation(self, feature):
        self.stationLabel.setText(feature['name'])