import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
Rectangle{
    id:parent_rec
    property alias card_bac_image: card_image.img_source
    property string text1_value: "text1_value"
    property string text1_key: "text1_key"

    property string text2_value: "text2_value"
    property string text2_key: "text2_key"

    property string text3_value: "-"
    property string text3_key: "-"

    property string text4_value: "-"
    property string text4_key: "-"

    property string text5_value: "-"
    property string text5_key: "-"
    property int pointSize: 10
    property int currentSelectIndex: -1
    property int currentChildIndex: -1

    property bool isSuccess: false
    height: 90*2.8
    width: 160*2.8

    RoundImage{
        id:card_image
        anchors.fill: parent
        border_radius:10
    }
    RoundImage{
        id:stateImage
        anchors.right: parent_rec.right
        width: 80
        height: 80
        border_radius:80
        img_source:isSuccess?"qrc:/image/success.png":"qrc:/image/fail.png"
        MouseArea{
            hoverEnabled: true
            cursorShape: "OpenHandCursor"
            anchors.fill: parent
            onClicked: {
                successCardItem(selectIndex,index,currentChildIndex)
            }
        }
    }
    RoundImage{
        anchors.right: parent_rec.right
        anchors.top: stateImage.bottom
        anchors.rightMargin: 10
        anchors.topMargin: 10
        width: 60
        height: 60
        border_radius:80
        img_source:"qrc:/image/Logo.png"
        MouseArea{
            hoverEnabled: true
            cursorShape: "OpenHandCursor"
            anchors.fill: parent
            onClicked: {
                layoutPageView.showDetailPage(selectIndex,index,currentChildIndex)
            }
        }
    }
    ColumnLayout{
        anchors.fill: parent
        anchors.topMargin: 10
            Text {
                id:text1
                text: text1_key+": "+text1_value
                color: "white"
                font.family: window.wfontFamily
                font.pointSize:pointSize
                font.bold: true
                Layout.leftMargin: 10
                visible: text1_key==="-"|text1_value==="-"?false:true
            }
            Text {
                id:text2
                text: text2_key+": "+text2_value
                color: "white"
                font.family: window.wfontFamily
                font.pointSize:pointSize
                font.bold: true
                Layout.leftMargin: 10
                visible: text2_key==="-"|text2_value==="-"?false:true
            }
            Text {
                id:text3
                text: text3_key+": "+text3_value
                color: "white"
                font.family: window.wfontFamily
                font.pointSize:pointSize
                font.bold: true
                Layout.leftMargin: 10
                visible: text3_key==="-"|text3_value==="-"?false:true
            }
            Text {
                id:text4
                text: text4_key+": "+text4_value
                color: "white"
                font.family: window.wfontFamily
                font.pointSize:pointSize
                font.bold: true
                Layout.leftMargin: 10
                visible: text4_key==="-"|text4_value==="-"?false:true
            }
            Text {
                id:text5
                text: text5_key+": "+text5_value
                color: "white"
                font.family: window.wfontFamily
                font.pointSize:pointSize
                font.bold: true
                Layout.leftMargin: 10
                visible: text5_key==="-"|text5_value==="-"?false:true
            }
            Item {
                Layout.fillHeight: true
            }
            RowLayout{
                Layout.rightMargin: 10
                Layout.bottomMargin: 10
                Layout.fillHeight: true
                Layout.fillWidth: true
                RoundImage{
                    width: 40
                    height: 40
                    img_source:"qrc:/image/changeCardImage.png"
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape:"PointingHandCursor"
                        onClicked: {
                            imagePop.visible = true
                            imagePop.cardIndex = index
                            imagePop.currentSelectIndex = currentSelectIndex
                            imagePop.currentChildIndex = currentChildIndex
                        }
                    }
                }
                    Item {
                        Layout.fillWidth: true
                    }

                    RoundButton{

                        width: 80
                        height: 30
                        id:card_change_btn
                        text_color : "white"
                        bac_color : "blue"
                        textContent:"修改"
                        MouseArea{
                            hoverEnabled: true
                            cursorShape: "OpenHandCursor"
                            anchors.fill: parent
                            onEntered: {
                                card_change_btn.text_color = "blue"
                                card_change_btn.bac_color = "white"
                            }
                            onExited: {
                                card_change_btn.text_color = "white"
                                card_change_btn.bac_color = "blue"
                            }
                            onClicked: {
                                var quesList = moviePage.requestQuestionList(selectIndex,childIndex)
                                var question = moviePage.getPopQuestion(selectIndex,childIndex,quesList)
                                changePop.questionList = question
                                text1_value==="-"?"":changePop.popQuestionRepeater.itemAt(0).children[1].text = text1_value
                                text2_value==="-"?"":changePop.popQuestionRepeater.itemAt(1).children[1].text = text2_value
                                text3_value==="-"?"":changePop.popQuestionRepeater.itemAt(2).children[1].text = text3_value
                                text4_value==="-"?"":changePop.popQuestionRepeater.itemAt(3).children[1].text = text4_value
                                text5_value==="-"?"":changePop.popQuestionRepeater.itemAt(4).children[1].text = text5_value
                                changePop.visible = true
                                changePop.isChange = true
                                changePop.currentSelectIndex = currentSelectIndex
                                changePop.currentChildIndex = currentChildIndex
                                changePop.questionNum = question.length
                            }
                        }
                    }
                    RoundButton{
                        width: 80
                        height: 30
                        id:card_del_btn
                        text_color : "white"
                        bac_color : "red"
                        textContent:"删除"
                        MouseArea{
                            hoverEnabled: true
                            cursorShape: "OpenHandCursor"
                            anchors.fill: parent
                            onEntered: {
                                card_del_btn.text_color = "red"
                                card_del_btn.bac_color = "white"
                            }
                            onExited: {
                                card_del_btn.text_color = "white"
                                card_del_btn.bac_color = "red"
                            }
                            onClicked: {
                                deleteCardItem(currentSelectIndex,index,currentChildIndex)
                            }
                        }
                    }
                }

              }



    function deleteCardItem(selectIndex,itemIndex,childIndex){
        var list = []
        var list_total = []
        var list_local = []
        switch(selectIndex){
        case 0:
            list_total = needToDoSettings.value("watchList",0)
            list_local = list_total.filter(item=>item.classes===childIndex)
            list_local.splice(itemIndex,1)
            list_total = list_total.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list_total.push(list_local[i])
            }
            needToDoSettings.setValue("watchList",list_total)

            break
        case 1:
            list_total = needToDoSettings.value("tripList",0)
            list_local = list_total.filter(item=>item.classes===childIndex)
            list_local.splice(itemIndex,1)
            list_total = list_total.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list_total.push(list_local[i])
            }
            needToDoSettings.setValue("tripList",list_total)
            break
        case 2:
            list_total = needToDoSettings.value("eatList",0)
            list_local = list_total.filter(item=>item.classes===childIndex)
            list_local.splice(itemIndex,1)
            list_total = list_total.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list_total.push(list_local[i])
            }
            needToDoSettings.setValue("eatList",list_total)
            break
        case 3:
            list_total = needToDoSettings.value("playList",0)
            list_local = list_total.filter(item=>item.classes===childIndex)
            list_local.splice(itemIndex,1)
            list_total = list_total.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list_total.push(list_local[i])
            }
            needToDoSettings.setValue("playList",list_total)
            break

        }
        moviePage.chooseList(selectIndex,currentChildIndex)
    }
    function successCardItem(selectIndex,itemIndex,childIndex){
        var list_total = []
        var list_local = []
        switch(selectIndex){
        case 0:
            list_total = needToDoSettings.value("watchList",0)
            list_local = list_total.filter(item=>item.classes===childIndex)
            list_local[itemIndex].state =list_local[itemIndex].state === "success"? "fail":"success"
            list_total = list_total.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list_total.push(list_local[i])
            }
            needToDoSettings.setValue("watchList",list_total)

            break
        case 1:
            list_total = needToDoSettings.value("tripList",0)
            list_local = list_total.filter(item=>item.classes===childIndex)
            list_local[itemIndex].state =list_local[itemIndex].state === "success"? "fail":"success"
            list_total = list_total.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list_total.push(list_local[i])
            }
            needToDoSettings.setValue("tripList",list_total)
            break
        case 2:
            list_total = needToDoSettings.value("eatList",0)
            list_local = list_total.filter(item=>item.classes===childIndex)
            list_local[itemIndex].state =list_local[itemIndex].state === "success"? "fail":"success"
            list_total = list_total.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list_total.push(list_local[i])
            }
            needToDoSettings.setValue("eatList",list_total)
            break
        case 3:
            list_total = needToDoSettings.value("playList",0)
            list_local = list_total.filter(item=>item.classes===childIndex)
            list_local[itemIndex].state =list_local[itemIndex].state === "success"? "fail":"success"
            list_total = list_total.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list_total.push(list_local[i])
            }
            needToDoSettings.setValue("playList",list_total)
            break

        }
        moviePage.chooseList(selectIndex,currentChildIndex)
    }



    MyPopUp{
        height: 500
        id:changePop
        visible: false
    }

}






