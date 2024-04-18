import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
Rectangle {
    width: 300
    height: 80
    id:rect
    RoundImage{
        id:roundImg
        img_source: "qrc:/image/player.jpg"
        anchors.fill: parent
        border_radius:50
    }

    // 其他矩形属性
    radius: 50
    border.color: "grey"
    border.width: 2
}

