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
    onVisibleChanged: {
        if(self.visible===false){
            changeDefault = false
        }
    }
    id:self
    width: 1100
//    height: 90*8
    background: Rectangle{
        color: "#cc99ff"
        radius: 20
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
                                   changeDefault?changeCardDefaultImage(currentSelectIndex,cardRepeater.model[index]):changeCardItemImage(currentSelectIndex,cardIndex,cardRepeater.model[index],currentChildIndex)
                                   self.visible = false
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
    function changeCardItemImage(selectIndex,itemIndex,imgUrl,childIndex){
        var list_total = []
        var list_local = []
        switch(selectIndex){
        case 0:
            list_total = needToDoSettings.value("watchList",0)
            list_local = list_total.filter(item=>item.classes===childIndex)
            list_local[itemIndex].cardImage =imgUrl?imgUrl:"qrc:/image/touxiang.jpg"
            list_total = list_total.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list_total.push(list_local[i])
            }
            needToDoSettings.setValue("watchList",list_total)
            break
        case 1:
            list_total = needToDoSettings.value("tripList",0)
            list_local = list_total.filter(item=>item.classes===childIndex)
            list_local[itemIndex].cardImage =imgUrl?imgUrl:"qrc:/image/touxiang.jpg"
            list_total = list_total.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list_total.push(list_local[i])
            }
            needToDoSettings.setValue("tripList",list_total)
            break
        case 2:
            list_total = needToDoSettings.value("eatList",0)
            list_local = list_total.filter(item=>item.classes===childIndex)
            list_local[itemIndex].cardImage =imgUrl?imgUrl:"qrc:/image/touxiang.jpg"
            list_total = list_total.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list_total.push(list_local[i])
            }
            needToDoSettings.setValue("eatList",list_total)
            break
        case 3:
            list_total = needToDoSettings.value("playList",0)
            list_local = list_total.filter(item=>item.classes===childIndex)
            list_local[itemIndex].cardImage =imgUrl?imgUrl:"qrc:/image/touxiang.jpg"
            list_total = list_total.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list_total.push(list_local[i])
            }
            needToDoSettings.setValue("playList",list_total)
            break

        }
        moviePage.chooseList(currentSelectIndex,currentChildIndex)
    }
    function changeCardDefaultImage(selectIndex,imgUrl){
        var list = cardImageSettings.value("defaultImage",0)
        switch(selectIndex){
        case 0:
            list[0] =imgUrl
            break
        case 1:
            list[1] =imgUrl
            break
        case 2:
            list[2] =imgUrl
            break
        case 3:
            list[3] =imgUrl
            break

        }
        cardImageSettings.setValue("defaultImage",list)
        moviePage.defaultImage = list
        //还需要改变界面的那个显示，目前只是文件里面改了
        changeDefault = false
    }
    function deleteCardImage(index){
        var list =cardImageSettings.value("imageUrlList",0)
        list.splice(index,1)
        cardImageSettings.setValue("imageUrlList",list)
        imageListViewModel = list
    }

}
