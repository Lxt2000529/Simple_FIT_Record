import QtQuick 2.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
Item {
    property string img_source: "qrc:/image/touxiang.jpg"
    property int border_radius: 5
    Image {
        id:image
        anchors.centerIn: parent
        source: img_source
        smooth: true
        visible: false
        width: parent.width
        height: parent.height
        //保持长宽比进行裁剪
        fillMode: Image.PreserveAspectCrop
        antialiasing: true

        ShaderEffectSource {
            id: blurSource
            sourceItem: image
            recursive: true
            live: true
            width: image.width
            height: image.height
        }

        // 应用虚化效果
        GaussianBlur {
            anchors.fill: parent
            source: blurSource
            radius: 15 // 虚化半径，根据需要调整
        }

    }
    Rectangle{
        id:mask
        anchors.fill: parent
        color: "black"
        radius: border_radius
        visible: false
        smooth: true
        antialiasing: true


    }

    OpacityMask{
        anchors.fill:image
        source: image
        maskSource:mask
        visible: true
        antialiasing: true
    }

}
