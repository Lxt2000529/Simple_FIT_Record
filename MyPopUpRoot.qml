import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Popup {
    property int questionNum: 2
    property var questionList:["id: ","sex: "]
    property alias popQuestionRepeater: popQuestionRepeater
    id:self
    width: 400
    height: 100*questionNum + 100
    background: Rectangle{
        color: "#cc99ff"
        radius: 20
    }
    ColumnLayout{
        anchors.fill: parent
//        anchors.margins: 10
        Repeater{
            Layout.preferredWidth:380
            id:popQuestionRepeater
            model: questionList
            delegate: popDelegate
        }
        RowLayout{
            Layout.fillWidth: true
            RoundButton{
                id:pop_confirm_btn
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                textContent: "确认"
                bac_color : "#FFBBFF"
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        pop_confirm_btn.bac_color = "#60FFBBFF"
                    }
                    onExited: {
                        pop_confirm_btn.bac_color = "#FFBBFF"
                    }
                    onClicked: {
                        changeInput()
                        self.visible = false
                }
            }
        }
            RoundButton{
                id:pop_cancle_btn
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                textContent: "取消"
                bac_color : "#FFBBFF"
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        pop_cancle_btn.bac_color = "#60FFBBFF"
                    }
                    onExited: {
                        pop_cancle_btn.bac_color = "#FFBBFF"
                    }
                    onClicked: {
                        self.visible = false
                    }
                }
            }
        }


    Component{
        id:popDelegate
        RowLayout{
            visible: modelData===""?false:true
            Layout.fillWidth: true
            Rectangle{
                Layout.preferredWidth: textItem.width+10
                Layout.preferredHeight: 50
                color: "#FFBBFF"
                radius: 10
                Text {
                    id:textItem
                    anchors.centerIn: parent
                    text: modelData
                    font.family: window.wfontFamily
                    font.pointSize:window.wpointSize
                    color: "white"
                    font.bold: true
                }
            }
            MyTextField {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                Layout.preferredWidth: 100
            }
        }

    }

    }
    //修改卡片显示内容
    function changeInput(){
        var id = popQuestionRepeater.itemAt(0).children[1].text?popQuestionRepeater.itemAt(0).children[1].text:"-"
        var sex = popQuestionRepeater.itemAt(1).children[1].text?popQuestionRepeater.itemAt(1).children[1].text:"-"
        rootSettimg.setValue("rootId",id)
        rootSettimg.setValue("sex",sex)
        personalCenterPage.id = id
        personalCenterPage.sex = sex
    }
}
