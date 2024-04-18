import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtQml 2.0
import QtQuick.Controls.Styles 1.4
TextField {
    property alias fieldText: self.text
    id:self
    Layout.preferredWidth: parent.width*0.65
    Layout.preferredHeight: parent.height*0.5

    placeholderText: "Enter text"
    background: Rectangle{
        color:"#cc99ff"
        radius: 15
        border.width: 3
        border.color: "white"
    }
    placeholderTextColor: "white"
    font:{

        font.bold = true
        color = "white"
        font.pointSize = 12
    }

}

