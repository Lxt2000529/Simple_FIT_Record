import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0

RowLayout{
    property alias title: title.text
    property alias value: value.text
    Item{
        width: 20
    }
    Text {
       id:title
       Layout.alignment: Qt.AlignHCenter
       text:"总待做："
       font.pointSize: 14
       font.bold: true
       font.family: "微软雅黑"
       color: "white"
    }
    Item{
        width: 10
    }
    Text {
       id:value
      Layout.alignment: Qt.AlignHCenter
       text:"10"
       font.pointSize: 14
       font.bold: true
       font.family: "微软雅黑"
       color: "white"
    }
}
