import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Popup {
    property int questionNum: 0
    property alias questionList: popQuestionRepeater.model
    property int currentSelectIndex: -1
    property int currentChildIndex : -1
    property var addNewContent: []
    property bool isChange: false
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
                        isChange?changeInput(index,currentChildIndex):updateInput()
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
    function updateInput(){
        var list = []
        var addCurrent = []
        var name = popQuestionRepeater.itemAt(0).children[1].text?popQuestionRepeater.itemAt(0).children[1].text:"-"
        var star = popQuestionRepeater.itemAt(1).children[1].text?popQuestionRepeater.itemAt(1).children[1].text:"-"
        if(questionNum===3){
            var remarks = popQuestionRepeater.itemAt(2).children[1].text?popQuestionRepeater.itemAt(2).children[1].text:"-"
            addCurrent = [{classes:currentChildIndex,text1_value:name,text2_value:star,text3_value:remarks,state:"fail",cardImage:"",detailImage:[]}]
        }
        if(questionNum===5){
            var allStep = popQuestionRepeater.itemAt(2).children[1].text?popQuestionRepeater.itemAt(2).children[1].text:"-"
            var step = popQuestionRepeater.itemAt(3)?(popQuestionRepeater.itemAt(3).children[1].text?popQuestionRepeater.itemAt(3).children[1].text:"-"):"-"
            var remarks = popQuestionRepeater.itemAt(4)?(popQuestionRepeater.itemAt(4).children[1].text?popQuestionRepeater.itemAt(4).children[1].text:"-"):"-"
            addCurrent = [{classes:currentChildIndex,text1_value:name,text2_value:star,text3_value:allStep,text4_value:step,text5_value:remarks,state:"fail",cardImage:"",detailImage:[]}]
        }
        switch(currentSelectIndex){

        case 0:
            list = needToDoSettings.value("watchList",0)?needToDoSettings.value("watchList",0):[]
            list.unshift(addCurrent[0])
            needToDoSettings.setValue("watchList",list)
                break;
        case 1:
            list = needToDoSettings.value("tripList",0)?needToDoSettings.value("tripList",0):[]
            list.unshift(addCurrent[0])
            needToDoSettings.setValue("tripList",list)
                break;
        case 2:
            list = needToDoSettings.value("eatList",0)?needToDoSettings.value("eatList",0):[]
            list.unshift(addCurrent[0])
            needToDoSettings.setValue("eatList",list)
                break;
        case 3:
            list = needToDoSettings.value("playList",0)?needToDoSettings.value("playList",0):[]
            list.unshift(addCurrent[0])
            needToDoSettings.setValue("playList",list)
            break;

        }
        moviePage.chooseList(currentSelectIndex,currentChildIndex)



    }
    //修改卡片显示内容
    function changeInput(changeIndex,classIndex){
        var addCurrent = []
        var list = []
        var list_local = []
        var name = popQuestionRepeater.itemAt(0).children[1].text?popQuestionRepeater.itemAt(0).children[1].text:"-"
        var star = popQuestionRepeater.itemAt(1).children[1].text?popQuestionRepeater.itemAt(1).children[1].text:"-"

        if(questionNum===3){
            var remarks = popQuestionRepeater.itemAt(2).children[1].text?popQuestionRepeater.itemAt(2).children[1].text:"-"
            addCurrent = [{classes:currentChildIndex,text1_value:name,text2_value:star,text3_value:remarks,state:"fail"}]
        }
        if(questionNum===5){
            var allStep = popQuestionRepeater.itemAt(2).children[1].text?popQuestionRepeater.itemAt(2).children[1].text:"-"
            var step = popQuestionRepeater.itemAt(3)?(popQuestionRepeater.itemAt(3).children[1].text?popQuestionRepeater.itemAt(3).children[1].text:"-"):"-"
            var remarks = popQuestionRepeater.itemAt(4)?(popQuestionRepeater.itemAt(4).children[1].text?popQuestionRepeater.itemAt(4).children[1].text:"-"):"-"
            addCurrent = [{classes:currentChildIndex,text1_value:name,text2_value:star,text3_value:allStep,text4_value:step,text5_value:remarks,state:"fail"}]
        }
        switch(currentSelectIndex){
        case 0:

            list =  needToDoSettings.value("watchList",0)
            list_local = list.filter(item=>item.classes===classIndex)
            addCurrent = addCurrent.map(function(item) {
                item.detailImage = list_local[changeIndex].detailImage
                item.cardImage =list_local[changeIndex].cardImage
                return item;
            });
            list_local[changeIndex] = addCurrent[0]
            list = list.filter(item=>item.classes!==classIndex)
            for(var i = 0;i<list_local.length;i++){
                list.push(list_local[i])
            }
            needToDoSettings.setValue("watchList",list)
            break;
        case 1:
            list =  needToDoSettings.value("tripList",0)
            list_local = list.filter(item=>item.classes===classIndex)
            addCurrent = addCurrent.map(function(item) {
                item.detailImage = list_local[changeIndex].detailImage
                item.cardImage =list_local[changeIndex].cardImage
                return item;
            });
            list_local[changeIndex] = addCurrent[0]
            list = list.filter(item=>item.classes!==classIndex)
            for(var i = 0;i<list_local.length;i++){
                list.push(list_local[i])
            }
            needToDoSettings.setValue("tripList",list)
            break;
        case 2:
            list =  needToDoSettings.value("eatList",0)
            list_local = list.filter(item=>item.classes===classIndex)
            addCurrent = addCurrent.map(function(item) {
                item.detailImage = list_local[changeIndex].detailImage
                item.cardImage =list_local[changeIndex].cardImage
                return item;
            });
            list_local[changeIndex] = addCurrent[0]
            list = list.filter(item=>item.classes!==classIndex)
            for(var i = 0;i<list_local.length;i++){
                list.push(list_local[i])
            }
            needToDoSettings.setValue("eatList",list)
            break;
        case 3:
            list =  needToDoSettings.value("playList",0)
            list_local = list.filter(item=>item.classes===classIndex)
            addCurrent = addCurrent.map(function(item) {
                item.detailImage = list_local[changeIndex].detailImage
                item.cardImage =list_local[changeIndex].cardImage
                return item;
            });
            list_local[changeIndex] = addCurrent[0]
            list = list.filter(item=>item.classes!==classIndex)
            for(var i = 0;i<list_local.length;i++){
                list.push(list_local[i])
            }
            needToDoSettings.setValue("playList",list)
            break;

        }
        moviePage.chooseList(currentSelectIndex,currentChildIndex)
        isChange = false
    }
}
