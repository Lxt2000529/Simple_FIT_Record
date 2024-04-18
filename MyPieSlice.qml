import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtCharts 2.3
PieSlice {
    property alias label: self.label
    property alias value: self.value
    id:self
    onHovered: {
        exploded = !exploded
    }
}


