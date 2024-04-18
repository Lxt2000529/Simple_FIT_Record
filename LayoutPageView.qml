import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
import QtQml 2.0
RowLayout{
    property var listViewModel:[{title:"个人中心"},{title:"待做"},{title:"记录"}]
    property var qmlList: [{qml:"PersonalCenterPage",show:true},{qml:"MoviePage",show:true},{qml:"LayoutRecordPage",show:true},{qml:"LayoutDetailPage",show:false}]
    property int preIndex: 0
    property int defaultPage: 0
    property string themeColor: "cc99ff"
    property string themeColorEnter: "FFBBFF"
    property alias rootImageTitle: rootIcon.img_source
    Rectangle{
        Layout.fillHeight: true
        Layout.preferredWidth: windowW*0.2
        color: "#"+themeColor
        ColumnLayout{
            anchors.fill: parent
            RoundImage{
                id:rootIcon
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 20
                Layout.bottomMargin: 40
                width: 200
                height: 200
               img_source: rootSettimg.value("rootImage",0)
//                Layout.fillWidth: true
//                Layout.preferredHeight: parent.height*0.2
                border_radius:240
            }
            ListView{
                id:pageHomeListView
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: listViewModel
                delegate: pageHomeListViewDelegate
                highlight: Rectangle{
                    color: "#ff99ff"
                }

            }
        }
    }
    Repeater{
        id:repeater
        model:qmlList.length
        Loader{
            visible: false
            Layout.fillWidth: true
            Layout.fillHeight: true

        }
    }
    Component{
        id:pageHomeListViewDelegate

        Rectangle{
            id:item
            width: windowW*0.2
            height:pageHomeListView.height*0.15
            color: "#00"+themeColor
            Text {
                anchors.centerIn: parent
                id: name
                text: modelData.title
                font.family: window.wfontFamily
                font.pointSize: window.wpointSize
                color: "white"
                font.bold: true
            }
            Component.onCompleted: {
//                console.log(item.height,item.width)
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: "PointingHandCursor"
                onEntered: {
                    item.color = "#"+themeColorEnter
                }
                onExited: {
                    item.color = "#00"+themeColor
                }
                onClicked: {
                    item.ListView.view.currentIndex = index
                    repeater.itemAt(preIndex).visible = false
                    preIndex = index
                    var loader = repeater.itemAt(index)
                    loader.visible = true
                    loader.source = qmlList[index].qml+".qml"
                    if(index === 0){
                        loader.children[0].getPersonRecord()
                        loader.children[0].getLineData()
                        loader.children[0].starSlider()
                    }
                    if(index === 1){
                        loader.children[0].starSlider()
                    }
                    if(index === 2){
                        loader.children[0].starSlider()
                    }
                }
            }
        }
    }
    function showDetailPage(selectIndex,childIndex,currentChildIndex){
        repeater.itemAt(preIndex).visible = false
        preIndex = 3
        var loader = repeater.itemAt(3)
        loader.visible = true
        loader.source = qmlList[3].qml+".qml"

        loader.children[0].contentList = getDetailContent(selectIndex,childIndex,currentChildIndex)
        var questionList = requestQuestionList(selectIndex,currentChildIndex)
        loader.children[0].questionList = getPopQuestion(selectIndex,currentChildIndex,questionList)
        loader.children[0].selectIndex = selectIndex
        loader.children[0].childIndex = currentChildIndex
        loader.children[0].itemIndex = childIndex
        loader.children[0].getGradImage(selectIndex,childIndex)
    }
    Component.onCompleted: {
        var loader = repeater.itemAt(defaultPage)
        loader.visible = true
        loader.source = qmlList[defaultPage].qml+".qml"
        preIndex = defaultPage
        rootIcon.img_source = rootSettimg.value("rootImage",0)

    }
    function getDetailContent(selectIndex,index,currentChildIndex){
        var list = []
        switch(selectIndex){
        case 0:
            list = needToDoSettings.value("watchList",0).filter(item=>item.classes===currentChildIndex)[index]
            break
        case 1:
            list = needToDoSettings.value("tripList",0).filter(item=>item.classes===currentChildIndex)[index]
            break
        case 2:
            list = needToDoSettings.value("eatList",0).filter(item=>item.classes===currentChildIndex)[index]
            break
        case 3:
            list = needToDoSettings.value("playList",0).filter(item=>item.classes===currentChildIndex)[index]
            break
        }
        return list

    }
    function requestQuestionList(my_selectIndex,childIndex){
        var popQuestionList = []
        switch(my_selectIndex){
        case 0:
            if(childIndex===0){
                popQuestionList = needToDoSettings.value("movieQuestion",0)[0]
            }else{
                popQuestionList = needToDoSettings.value("movieMulQuestion",0)[0]
            }

            break
        case 1:
             popQuestionList = needToDoSettings.value("tripQuestion",0)[0]
            break
        case 2:
             popQuestionList = needToDoSettings.value("eatQuestion",0)[0]
            break
        case 3:
            if(childIndex===0){
                popQuestionList = needToDoSettings.value("playEleQuestion",0)[0]
            }
            if(childIndex===1){
                 popQuestionList = needToDoSettings.value("playRelaxQuestion",0)[0]
            }
            break
        }
        return popQuestionList
    }
    function getPopQuestion(ChooseSelectIndex,ChildIndex,questionList){
        var popQueList = []
        switch(ChooseSelectIndex){
        case 0:
            switch(ChildIndex){
            case 0:
                popQueList = [questionList.name,questionList.star,questionList.remarks]
                break;
            case 1:
            case 2:
            case 3:
                popQueList = [questionList.name,questionList.allStep,questionList.step,questionList.star,questionList.remarks]
                break;
            }
            break;
        case 1:
        case 2:
        case 3:
            popQueList = [questionList.name,questionList.star,questionList.remarks]
            break;
        }
        return popQueList
    }

}
