import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
ColumnLayout{
    property alias textContent: mytext.text
    property alias sliderValue: slider.value
    Rectangle {
        width: 300
        height: 80
        id:rect
        RoundImage{
            id:roundImg
            img_source: "qrc:/image/player.jpg"
            anchors.fill: parent
            border_radius:10
        }

        // 其他矩形属性
        radius: 10
        border.color: "grey"
        border.width: 2
        Text {
            id: mytext
            font.family: window.wfontFamily
            font.pointSize: window.wpointSize
            color:"white"
            font.bold: true
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: "PointingHandCursor"
            onClicked: {
                console.log(index)
            }
            onEntered: {
                bigScale.start()
            }
            onExited: {
                smallScale.start()
            }

        }

        NumberAnimation {
            id:bigScale
            target:roundImg
            property: "scale"
            duration: 200
            from:1.0
            to:1.1
        }
        NumberAnimation {
            id:smallScale
            target:roundImg
            property: "scale"
            duration: 200
            from:1.1
            to:1.0
        }
    }
        RowLayout{

            MySlider{

                id:slider

            }


           Text {
                width: 20
                id: name
                text: parseInt(slider.value)
            }
        }



}
