import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Popup {
    property int questionNum: 0
    property alias questionList: popQuestionRepeater.model
    property int currentSelectIndex: -1
    property int currentChildIndex : -1
    property bool isChange: false
    property alias popQuestionRepeater: popQuestionRepeater
    property int index: 0
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
                        isChange?changeInput(index,currentChildIndex):updateInput(currentSelectIndex,currentChildIndex)
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
    //添加卡片
    function updateInput(currentSelectIndex,classIndex){
        var addCurrent = []
        var list = []
        var first_value = popQuestionRepeater.itemAt(0).children[1].text?popQuestionRepeater.itemAt(0).children[1].text:"-"
        var second_value = popQuestionRepeater.itemAt(1).children[1].text?popQuestionRepeater.itemAt(1).children[1].text:"-"
        var third_value = popQuestionRepeater.itemAt(2).children[1].text?popQuestionRepeater.itemAt(2).children[1].text:"-"
        var fourth_value = popQuestionRepeater.itemAt(3).children[1].text?popQuestionRepeater.itemAt(3).children[1].text:"-"
        var cardImage = recordSettings.value("defaultImage_fit",0)[classIndex]
//        console.log(first_value,second_value,third_value,fourth_value)

        addCurrent = [{classes:classIndex,first_value:first_value,second_value:second_value,third_value:third_value,fourth_value:fourth_value,cardImage:cardImage}]

        switch(currentSelectIndex){
        case 0:
            list = recordSettings.value("fitList",0)?recordSettings.value("fitList",0):[]
            list.unshift(addCurrent[0])
            recordSettings.setValue("fitList",list)
                break;
        case 1:
            list = recordSettings.value("friendList",0)?recordSettings.value("friendList",0):[]
            addCurrent[0].cardImage = recordSettings.value("defaultImage_friend",0)
            if(list.length===0){
                list.push(addCurrent[0])
            }else{
                list.unshift(addCurrent[0])
            }

            recordSettings.setValue("friendList",list)
            break;
        }
        layoutRecordPage.chooseList(currentSelectIndex,currentChildIndex)

    }
    //修改卡片显示内容
    //------------------------------------------------------------------------和删除逻辑一样 for
    function changeInput(changeIndex,classIndex){
        var list = []
        var list_local = []
        var addCurrent = []
        var first_value = popQuestionRepeater.itemAt(0).children[1].text?popQuestionRepeater.itemAt(0).children[1].text:"-"
        var second_value = popQuestionRepeater.itemAt(1).children[1].text?popQuestionRepeater.itemAt(1).children[1].text:"-"
        var third_value = popQuestionRepeater.itemAt(2).children[1].text?popQuestionRepeater.itemAt(2).children[1].text:"-"
        var fourth_value = popQuestionRepeater.itemAt(3).children[1].text?popQuestionRepeater.itemAt(3).children[1].text:"-"
        var cardImage  = currentSelectIndex===0?recordSettings.value("fitList",0).filter(item=>item.classes===classIndex)[changeIndex].cardImage:recordSettings.value("friendList",0).filter(item=>item.classes===classIndex)[changeIndex].cardImage
        addCurrent = [{classes:classIndex,first_value:first_value,second_value:second_value,third_value:third_value,fourth_value:fourth_value,cardImage:cardImage}]
        switch(currentSelectIndex){
//        case 0:
//            list = recordSettings.value("fitList",0)
//            list[changeIndex] = addCurrent[0]
//            recordSettings.setValue("fitList",list)
//                break;
//        case 1:
//            list = recordSettings.value("friendList",0)
//            list[changeIndex] = addCurrent[0]
//            recordSettings.setValue("friendList",list)
//                break;
        case 0:
            list = recordSettings.value("fitList",0)
            list_local = list.filter(item=>item.classes===classIndex)
            list_local[changeIndex] = addCurrent[0]
            list = list.filter(item=>item.classes!==classIndex)
            for(var i = 0;i<list_local.length;i++){
                list.push(list_local[i])
            }
            recordSettings.setValue("fitList",list)
                break;
        case 1:
            list = recordSettings.value("friendList",0)?recordSettings.value("friendList",0):[]
            list_local = list.filter(item=>item.classes===classIndex)?list.filter(item=>item.classes===classIndex):[]
            list_local[changeIndex] = addCurrent[0]
            list = list.filter(item=>item.classes!==classIndex)
            for(var i = 0;i<list_local.length;i++){
                list.push(list_local[i])
            }
            recordSettings.setValue("friendList",list)
                break;
        }
        layoutRecordPage.chooseList(currentSelectIndex,currentChildIndex)
        isChange = false
    }
}
