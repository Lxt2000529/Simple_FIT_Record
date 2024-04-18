import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0

Rectangle{
    property alias bac_color: self.color
    property alias text_color: content_text.color
    property alias text_size: content_text.font.pointSize
    property alias text_content: content_text.text
    id:self
    Layout.leftMargin: 20
    Layout.preferredWidth: content_text.width+15
    Layout.preferredHeight: content_text.height+15
    radius: 10
    color: "#cc99ff"
    Text {
        id:content_text
        anchors.centerIn: parent
        text: "完成度"
        font.family: window.wfontFamily
        font.pointSize:window.wpointSize
        color: "white"
        font.bold: true
    }
}
