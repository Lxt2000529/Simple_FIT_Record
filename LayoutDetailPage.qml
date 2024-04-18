import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import Qt.labs.platform 1.0
Rectangle{
    property var contentList: []
    property var questionList: []
    property int childIndex: -1
    property int selectIndex: -1
    property int itemIndex: -1
    property alias gridModel: detailImageRepeater.model
    id:layoutDetailPage
    Layout.fillHeight: true
    Layout.fillWidth: true
    color: "#20FFBBFF"
    Flickable{
        clip: true
        anchors.fill: parent
        interactive: true
        width: 1100
        height: 900
        contentWidth: clay.width
        contentHeight: clay.height+20
        ColumnLayout{
            id:clay
            RowLayout{
                Layout.topMargin: 20
                Layout.bottomMargin: 20
                Item {

                    width: 10
                }

                Rectangle{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: 1200
                    Layout.preferredHeight: 300
                    radius: 20
                    color: "#cc99ff"
                    //还需要拿到对应的问题的名字，目前只拿到了内容
                    ColumnLayout{
                        Item {
                            height: 20
                        }
                        ShowProcess{
                            id:first_pro
                            title: questionList[0]?questionList[0]:"-"
                            value: contentList.text1_value?contentList.text1_value:"-"
                            visible:first_pro.title==="-"?false:true
                        }
                        ShowProcess{
                            id:second_pro
                            title: questionList[1]?questionList[1]:"-"
                            value: contentList.text2_value?contentList.text2_value:"-"
                            visible:second_pro.title==="-"?false:true
                        }
                        ShowProcess{
                            id:third_pro
                            title: questionList[2]?questionList[2]:"-"
                            value: contentList.text3_value?contentList.text3_value:"-"
                            visible:third_pro.title==="-"?false:true
                        }
                        ShowProcess{
                            id:fourth_pro
                            title: questionList[3]?questionList[3]:"-"
                            value: contentList.text4_value?contentList.text4_value:"-"
                            visible:fourth_pro.title==="-"?false:true
                        }
                        ShowProcess{
                            id:fifth_pro
                            title: questionList[4]?questionList[4]:"-"
                            value: contentList.text5_value?contentList.text5_value:"-"
                            visible:fifth_pro.title==="-"?false:true
                        }


                    }

                }
                Item {

                    width: 10
                }
            }
            RowLayout{
                Item {
                    width: 20
                }
                Grid{
                    id:detailGrid
                    columnSpacing: 30
                    rowSpacing:30
                    spacing: 20
                    columns: 3
                    Rectangle{
                        width: 380
                        height: 200
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
                            text: "添加照片"
                            font.bold: true
                            color: "white"
                            font.pointSize: 24
                        }
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: "PointingHandCursor"
                            onClicked: {
                                detailImageDialog.open()
                            }
                        }
                    }
                    Repeater{
                        id:detailImageRepeater
                        Layout.topMargin: 30
                        delegate: RoundImage{
                            id:deleItem
                            width: 380
                            height: 200
                            img_source : modelData
                            border_radius: 20
                               MouseArea{
                                   anchors.fill: parent
                                   hoverEnabled: true
                                   cursorShape: "PointingHandCursor"
                                   onClicked: {

                                   }
                                   onPressAndHold: {
                                        deleteGradImage(selectIndex,itemIndex,index)
                                   }
                               }

                        }
                    }


                }

                Item {
                    width: 20
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
        FileDialog{
            id:detailImageDialog
            fileMode: FileDialog.OpenFiles
            nameFilters: ["ImageFile(*.png *.jpg)"]
            folder: "E:\\"
            acceptLabel: "确定"
            rejectLabel: "取消"
            onAccepted: {
                var list = []
                var list_local = []
                switch(selectIndex){
                case 0:
                    list = needToDoSettings.value("watchList",0)
                    list_local = list.filter(item=>item.classes===childIndex)

                    for(var index in files){
                        var path = files[index]
                        list_local[itemIndex].detailImage.unshift(path)
                    }
                    list = list.filter(item=>item.classes!==childIndex)

                    for(var i = 0;i<list_local.length;i++){
                        list.push(list_local[i])
                    }
                    needToDoSettings.setValue("watchList",list)
                    break
                case 1:
                    list = needToDoSettings.value("tripList",0)
                    list_local = list.filter(item=>item.classes===childIndex)

                    for(var index in files){
                        var path = files[index]
                        list_local[itemIndex].detailImage.unshift(path)
                    }
                    list = list.filter(item=>item.classes!==childIndex)

                    for(var i = 0;i<list_local.length;i++){
                        list.push(list_local[i])
                    }
                     needToDoSettings.setValue("tripList",list)
                    break
                case 2:
                    list = needToDoSettings.value("eatList",0)
                    list_local = list.filter(item=>item.classes===childIndex)

                    for(var index in files){
                        var path = files[index]
                        list_local[itemIndex].detailImage.unshift(path)
                    }
                    list = list.filter(item=>item.classes!==childIndex)

                    for(var i = 0;i<list_local.length;i++){
                        list.push(list_local[i])
                    }
                    needToDoSettings.setValue("eatList",list)
                    break
                case 3:
                    list = needToDoSettings.value("playList",0)
                    list_local = list.filter(item=>item.classes===childIndex)

                    for(var index in files){
                        var path = files[index]
                        list_local[itemIndex].detailImage.unshift(path)
                    }
                    list = list.filter(item=>item.classes!==childIndex)

                    for(var i = 0;i<list_local.length;i++){
                        list.push(list_local[i])
                    }
                    needToDoSettings.setValue("playList",list)
                    break
                }
                gridModel = list_local[itemIndex].detailImage
//                console.log(list_local[itemIndex].detailImage)
            }
        }

    }
    function getGradImage(selectIndex,itemIndex){

        var list = []
        switch(selectIndex){
        case 0:
            list = needToDoSettings.value("watchList",0).filter(item=>item.classes===childIndex)[itemIndex].detailImage
            break
        case 1:
            list = needToDoSettings.value("tripList",0).filter(item=>item.classes===childIndex)[itemIndex].detailImage
            break
        case 2:
            list = needToDoSettings.value("eatList",0).filter(item=>item.classes===childIndex)[itemIndex].detailImage
            break
        case 3:
            list = needToDoSettings.value("playList",0).filter(item=>item.classes===childIndex)[itemIndex].detailImage
            break
        }
        gridModel = list

    }

    function deleteGradImage(selectIndex,itemIndex,itemImage){

        var list = []
        var list_local = []

        switch(selectIndex){
        case 0:
            list = needToDoSettings.value("watchList",0)
            list_local = list.filter(item=>item.classes===childIndex)
            list_local[itemIndex].detailImage.splice(itemImage,1)
            list = list.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list.push(list_local[i])
            }
             needToDoSettings.setValue("watchList",list)
            break
        case 1:
            list = needToDoSettings.value("tripList",0)
            list_local = list.filter(item=>item.classes===childIndex)
            list_local[itemIndex].detailImage.splice(itemImage,1)
            list = list.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list.push(list_local[i])
            }
            needToDoSettings.setValue("tripList",list)
            break
        case 2:
            list = needToDoSettings.value("eatList",0)
            list_local = list.filter(item=>item.classes===childIndex)
            list_local[itemIndex].detailImage.splice(itemImage,1)
            list = list.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list.push(list_local[i])
            }
            needToDoSettings.setValue("eatList",list)
            break
        case 3:
            list = needToDoSettings.value("playList",0)
            list_local = list.filter(item=>item.classes===childIndex)
            list_local[itemIndex].detailImage.splice(itemImage,1)
            list = list.filter(item=>item.classes!==childIndex)
            for(var i = 0;i<list_local.length;i++){
                list.push(list_local[i])
            }
            needToDoSettings.setValue("playList",list)
            break
        }

            getGradImage(selectIndex,itemIndex)


    }

}
