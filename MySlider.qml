import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
Slider{

    property int preferW: 280
    property int preferH: 10
    property int slider_radius: 5
    property alias slider_value: slider.value
    Layout.alignment: Qt.AlignCenter
    Layout.preferredHeight: preferH
    Layout.preferredWidth: preferW
    id:slider
    spacing: 0
    handle.visible: false
    enabled:false
    from:1
    value: 100
    to:100
    background: Rectangle{
        id:recc
        width: preferW
        height: preferH
        color: "white"
        radius: slider_radius
        Rectangle{
            width: slider.visualPosition*parent.width
            height: preferH
            color: "#FFBBFF"
            radius: slider_radius
        }
    }
    NumberAnimation {
        id:sliderChange
        target: slider
        property: "value"
        duration: 2000
        from:0
        to:slider.value
    }

    Component.onCompleted: {
        sliderChange.start()
    }

}
