import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Qt.labs.platform 1.0
Popup {
    property int currentIndex: -1
    property alias imageListViewModel: cardRepeater.model
    id:myself
    width: 1100
    height: 600
//    height: 90*8
    background: Rectangle{
        color: "#EE7942"
        radius: 20
    }
    Flickable{
        anchors.leftMargin: 30
        clip: true
        width: parent.width -30
        height: parent.height
        interactive: true
        contentWidth: imageListView.width
        contentHeight: imageListView.height+60
    ColumnLayout{
        anchors.fill: parent
        RoundText{
            Layout.alignment: Qt.AlignCenter
            text_content:"点击选择新的背景(长按删除)"
            bac_color:"#EE7942"
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
                        text: "添加头像"
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
                                   changeImage(currentIndex)
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
            var list = rootSettimg.value("rootImageList",0)
            for(var index in files){
                var path = files[index]
                list.unshift(path)
            }
            rootSettimg.setValue("rootImageList",list)
            imageListViewModel = list

        }
    }
    function changeImage(itemIndex){
        var imageUrl = ""
        imageUrl = rootSettimg.value("rootImageList",0)[itemIndex]
        rootSettimg.setValue("rootImage",imageUrl)
        personalCenterPage.rootImage = imageUrl
        layoutPageView.rootImageTitle = imageUrl
    }

    function deleteCardImage(index){
        var list =rootSettimg.value("rootImageList",0)
        list.splice(index,1)
        rootSettimg.setValue("rootImageList",list)
        imageListViewModel = list
    }

}
