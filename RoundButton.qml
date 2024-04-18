import QtQuick 2.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
Item {
    property int textSize: 8
    property string textContent: "value"
    property alias bac_color: bac.color
    property alias text_color: mytext.color
    Button {
        id:button
        anchors.centerIn: parent
        smooth: true
        width: parent.width
        height: parent.height
        antialiasing: true
        background: Rectangle{
            id:bac
            color: "#cc99ff"
            radius: 10
        }
        Text{
            id:mytext
            anchors.centerIn: parent
            text: textContent
            font.bold: true
            color: "white"
            font.family: window.wfontFamily
            font.pointSize: textSize
        }

    }

}
