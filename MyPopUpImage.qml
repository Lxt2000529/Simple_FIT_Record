import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
Popup {
    property int currentSelectIndex: -1
    property int currentChildIndex : -1
    property int cardIndex: -1
    property alias imageListViewModel: imageListView.model
    id:self
    width: 460
    height: 500
    background: Rectangle{
        color: "#cc99ff"
        radius: 20
    }
    ColumnLayout{
        anchors.fill: parent
        RoundText{
            Layout.alignment: Qt.AlignCenter
            text_content:"点击选择新的背景"
        }
        ListView{

            clip: true
//            Layout.leftMargin: 50
            spacing: 40
            Layout.topMargin: 10
            Layout.preferredWidth:440
            Layout.preferredHeight:420
            id:imageListView
            delegate: RoundImage{
                id:deleItem
                anchors.horizontalCenter: parent.horizontalCenter
                width: 320
                height: 180
                img_source : modelData
                scale: 1.0
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: "PointingHandCursor"
                    onEntered: {
                        imageListView.currentIndex = index
                        imgSelectBig.start()

                    }
                    onExited: {
                        imgSelectSmall.start()
                    }
                    onClicked: {
//                        console.log(imageListView.model[index])
//                        console.log("currentSelectIndex",currentSelectIndex,"cardIndex",cardIndex)
                        changeCardItemImage(currentSelectIndex,cardIndex,imageListView.model[index],currentChildIndex)
                    }
                }
            }
        }
    }
    NumberAnimation {
        id:imgSelectBig
        target: imageListView.currentItem
        property: "scale"
        from:1.0
        to:1.1
        duration: 400
    }
    NumberAnimation {
        id:imgSelectSmall
        target: imageListView.currentItem
        property: "scale"
        from:1.1
        to:1.0
        duration: 400
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
            needToDoSettings.setValue("watchList",list)

            break
        case 1:
            list_total = needToDoSettings.value("tripList",0)
            list_local = list_total.filter(item=>item.classes===childIndex)
            list_local[itemIndex].cardImage =imgUrl?imgUrl:"qrc:/image/touxiang.jpg"
            list_total = list_total.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list_total.push(list_local[i])
            }
            needToDoSettings.setValue("tripList",list)
            break
        case 2:
            list_total = needToDoSettings.value("eatList",0)
            list_local = list_total.filter(item=>item.classes===childIndex)
            list_local[itemIndex].cardImage =imgUrl?imgUrl:"qrc:/image/touxiang.jpg"
            list_total = list_total.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list_total.push(list_local[i])
            }
            needToDoSettings.setValue("eatList",list)
            break
        case 3:
            list_total = needToDoSettings.value("playList",0)
            list_local = list_total.filter(item=>item.classes===childIndex)
            list_local[itemIndex].cardImage =imgUrl?imgUrl:"qrc:/image/touxiang.jpg"
            list_total = list_total.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list_total.push(list_local[i])
            }
            needToDoSettings.setValue("playList",list)
            break

        }
        moviePage.chooseList(currentSelectIndex,currentChildIndex)
    }
}


