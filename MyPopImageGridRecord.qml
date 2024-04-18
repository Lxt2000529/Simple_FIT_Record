import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Qt.labs.platform 1.0
Popup {
    property int currentSelectIndex: -1
    property int currentChildIndex : -1
    property int cardIndex: -1
    property int currentIndex: -1
    property alias imageListViewModel: cardRepeater.model
    property bool changeDefault: false
    id:myself
    width: 1100
    height: 600
//    height: 90*8
    background: Rectangle{
        color: "#cc99ff"
        radius: 20
    }
    onVisibleChanged: {
        if(myself.visible===false){
            changeDefault = false
        }
    }

//    background:Back{
//        anchors.fill: parent


//    }
    Flickable{
        anchors.leftMargin: 30
        clip: true
        width: parent.width -30
        height: parent.height
//                    anchors.fill: parent
        interactive: true
        contentWidth: imageListView.width
        contentHeight: imageListView.height+60
    ColumnLayout{
        anchors.fill: parent
        RoundText{
            Layout.alignment: Qt.AlignCenter
            text_content:"点击选择新的背景(长按删除)"
        }
        RowLayout{


            Grid{
                id:imageListView
                columnSpacing: 30
                rowSpacing:30
                spacing: 20
                columns: 3
                Rectangle{
                    width: 320
                    height: 180
                    Layout.topMargin: 30
                    color: "#00000000"
                    border.color: "white"
                    border.width: 10
                    radius: 20
                    Text {
                        id:addText
                        anchors.centerIn: parent
                        text: "＋"
                        font.bold: true
                        color: "white"
                        font.pointSize: 24
                    }
                    Text {

                        anchors.top: addText.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 10
                        text: "添加卡片背景"
                        font.bold: true
                        color: "white"
                        font.pointSize: 24
                    }
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: "PointingHandCursor"
                        onClicked: {
                            addCardImageDialog.open()
                        }
                    }
                }
                Repeater{
                    id:cardRepeater
                    Layout.topMargin: 30
                    delegate: RoundImage{
                        id:deleItem
                        width: 320
                        height: 180
                        img_source : modelData
                        border_radius: 20
                           MouseArea{
                               anchors.fill: parent
                               hoverEnabled: true
                               cursorShape: "PointingHandCursor"
                               onEntered: {
                                   currentIndex = index
                                   imgSelectBig.start()

                               }
                               onExited: {
                                   imgSelectSmall.start()
                               }
                               onClicked: {

//                                   console.log(cardRepeater.model[index])
//                                   console.log("currentSelectIndex",currentSelectIndex,"cardIndex",cardIndex)
                                   changeDefault?changeCardDefaultImage(currentSelectIndex,currentChildIndex,cardRepeater.model[index]):changeCardItemImage(currentSelectIndex,cardIndex,cardRepeater.model[index],currentChildIndex)
                                   myself.visible = false
                               }
                               onPressAndHold: {
                                    deleteCardImage(index)
                               }
                           }

                    }
                }


            }
          }

        }
    }
    NumberAnimation {
        id:imgSelectBig
        target: cardRepeater.itemAt(currentIndex)
        property: "scale"
        from:1.0
        to:1.1
        duration: 400
    }
    NumberAnimation {
        id:imgSelectSmall
        target: cardRepeater.itemAt(currentIndex)
        property: "scale"
        from:1.1
        to:1.0
        duration: 400
    }
    FileDialog{
        id:addCardImageDialog
        fileMode: FileDialog.OpenFiles
        nameFilters: ["CardImageFile(*.png *.jpg)"]
        folder: "E:\\"
        acceptLabel: "确定"
        rejectLabel: "取消"
        onAccepted: {
            var list = cardImageSettings.value("imageUrlList",0)
            for(var index in files){
                var path = files[index]
                list.unshift(path)
            }
            cardImageSettings.setValue("imageUrlList",list)
            imageListViewModel = list

        }
    }
    function changeCardItemImage(selectIndex,itemIndex,imgUrl,classIndex){
        var list = []
        var list_local = []
        switch(selectIndex){
        case 0:
            list = recordSettings.value("fitList",0)?recordSettings.value("fitList",0):[]
            list_local = list.filter(item=>item.classes===classIndex)
            list_local[itemIndex].cardImage =imgUrl?imgUrl:"qrc:/image/touxiang.jpg"
            list = list.filter(item=>item.classes!==classIndex)
            for(var i = 0;i<list_local.length;i++){
                list.push(list_local[i])
            }
            recordSettings.setValue("fitList",list)
            break
        case 1:
            list = recordSettings.value("friendList",0)?recordSettings.value("friendList",0):[]
            list_local = list.filter(item=>item.classes===classIndex)
            list_local[itemIndex].cardImage =imgUrl?imgUrl:"qrc:/image/touxiang.jpg"
            list = list.filter(item=>item.classes!==classIndex)
            for(var i = 0;i<list_local.length;i++){
                list.push(list_local[i])
            }
            recordSettings.setValue("friendList",list)
            break

        }
        layoutRecordPage.chooseList(currentSelectIndex,currentChildIndex)
    }
    function changeCardDefaultImage(selectIndex,currentChildIndex,imgUrl){
        var list = []
        switch(selectIndex){
        case 0:
            list = recordSettings.value("defaultImage_fit",0)
            list[currentChildIndex] =imgUrl
            recordSettings.setValue("defaultImage_fit",list)
            break
        case 1:
            list = recordSettings.value("defaultImage_friend",0)
            list =[imgUrl]
            recordSettings.setValue("defaultImage_friend",list[0])
            break
        }
        layoutRecordPage.defaultImage = [recordSettings.value("defaultImage_fit",0),recordSettings.value("defaultImage_friend",0)]
        layoutRecordPage.defaultImageRound.img_source = selectIndex===0?defaultImage[0][childIndex]:defaultImage[1]
        //还需要改变界面的那个显示，目前只是文件里面改了

    }
    function deleteCardImage(index){
        var list =cardImageSettings.value("imageUrlList",0)
        list.splice(index,1)
        cardImageSettings.setValue("imageUrlList",list)
        imageListViewModel = list
    }

}
