import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtCharts 2.3

ChartView {
    width: 400
    height: 300
    antialiasing: true
    legend.alignment: Qt.AlignRight

    PieSeries {
        id: pieSeries
        MyPieSlice {
            label: "eaten"
            value: 94.9
        }
        MyPieSlice {
            label: "not yet eaten"
            value: 5.1
        }
    }

}

