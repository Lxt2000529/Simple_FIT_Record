import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0

ColumnLayout{
    id:layoutRecordPage
    property var titleList: ["健身","例假"]
    property int selectIndex: 0
    property var fitTitleList: ["胸部","背部","腿部","肩部","手臂"]
    property var frientTitleList: ["日期"]
    property var selectList: [fitTitleList,frientTitleList]
    property int childIndex: 0
    property int chooseSelectList: 0
    property alias showCardList: cardListView.model
    property var defaultImage: [recordSettings.value("defaultImage_fit",0),recordSettings.value("defaultImage_friend",0)]
    property alias lineDatas: chart.lineData
    property alias linenames: chart.names
    property alias defaultImageRound: defaultRoundImage

    //select栏
    RowLayout{
        Layout.preferredHeight: 125
        Rectangle{
            Layout.preferredWidth: 130
            Layout.preferredHeight: 130
            Layout.topMargin: 10
            Layout.bottomMargin: 10
            Layout.leftMargin: 20
            color:"#FFE1FF"
            radius: 20
            RoundText {
                anchors.centerIn: parent
                id:movie_title
                width: 80
                height: 80
                text_content:titleList[selectIndex]

            }
        }


        Rectangle{
            Layout.preferredWidth: movieRateSlider.width+movie_success_text.width+100+80
            Layout.preferredHeight: 130
            Layout.topMargin: 10
            Layout.bottomMargin: 10
            Layout.leftMargin: 20
            color:"#FFE1FF"
            radius: 20
            RowLayout{
                anchors.centerIn: parent
                RoundText {
                    id:movie_success_text
                    width: 100
                    text_content:"记录"
                }

                MySlider{
                    id:movieRateSlider
                    Layout.leftMargin:20
                    Layout.alignment: Qt.AlignVCenter
                    preferW: 500
                    preferH: 30
                    slider_radius:20

                }
                NumberAnimation {
                    id:sliderChange
                    target: movieRateSlider
                    property: "value"
                    duration: 2000
                    from:0
                    to:100
                }
                RoundText {
                    id:record_time
                    width: 100
                    text_content:parseInt(isZero?0:movieRateSlider.value)
                }
            }
        }

        Rectangle{
            Layout.fillWidth: true
            Layout.preferredHeight: 130
            color:"#FFE1FF"
            Layout.rightMargin: 10
            radius: 20
            ColumnLayout{
                anchors.fill: parent
                anchors.margins: 5
                RowLayout{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Rectangle{
                        id:highight_fit
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "#00000000"
                        radius: 20

                        Rectangle{
                            id:fit_select_rect
                            anchors.fill: parent
                            anchors.margins: 5
                            color: "#cc99ff"
                            radius: 20
                            Text {
                                text: "健身"
                                anchors.centerIn: parent
                                font.family: window.wfontFamily
                                font.pointSize:window.wpointSize
                                color: "white"
                                font.bold: true
                            }
                            MouseArea{
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: "PointingHandCursor"
                                onEntered: {
                                    fit_select_rect.color = "#cc33ff"
                                }
                                onExited: {
                                    fit_select_rect.color = "#cc99ff"
                                }
                                onClicked: {
                                    resumeHighLight(selectIndex)
                                    selectIndex = 0
                                    highight_fit.color = "white"
                                    childIndex = 0
                                    chooseList(selectIndex,childIndex)
                                    defaultRoundImage.img_source = selectIndex===0?defaultImage[0][childIndex]:defaultImage[1]
                                    childClassRepeater.itemAt(childIndex).color ="white"
                                }
                            }

                        }
                    }
                    Rectangle{
                        id:highight_friend
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "#00000000"
                        radius: 20

                        Rectangle{
                            id:frend_select_rect
                            anchors.fill: parent
                            anchors.margins: 5
                            color: "#cc99ff"
                            radius: 20
                            Text {
                                text: "例假"
                                anchors.centerIn: parent
                                font.family: window.wfontFamily
                                font.pointSize:window.wpointSize
                                color: "white"
                                font.bold: true
                            }
                            MouseArea{
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: "PointingHandCursor"
                                onEntered: {
                                    frend_select_rect.color = "#cc33ff"
                                }
                                onExited: {
                                    frend_select_rect.color = "#cc99ff"
                                }
                                onClicked: {

                                    resumeHighLight(selectIndex)
                                    selectIndex = 1
                                    highight_friend.color = "white"
                                    childIndex = 0
                                    chooseList(selectIndex,childIndex)
                                    defaultRoundImage.img_source = selectIndex===0?defaultImage[0][childIndex]:defaultImage[1]
                                    childClassRepeater.itemAt(childIndex).color ="white"

                                }
                            }
                        }
                    }

                }
            }
        }
    }
    //children栏
    RowLayout{
        height: 100
        Rectangle{
            Layout.leftMargin: 10
            Layout.fillWidth: true
            height: parent.height
            color: "#80FF99FF"
            radius: 20
            RowLayout{
                anchors.fill: parent
                RoundImage{
                    id:defaultRoundImage
                    Layout.leftMargin: 20
                    Layout.rightMargin: 5
                    img_source: selectIndex===0?defaultImage[0][childIndex]:defaultImage[1]
                    border_radius:20
                    width: 230
                    height: 80
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: "PointingHandCursor"
                        onClicked: {
                            imagePop.visible = true
                            imagePop.changeDefault = true
                            imagePop.currentSelectIndex = selectIndex
                            imagePop.currentChildIndex = childIndex

                        }
                    }
                }
                RoundText{
                    id:changeDefaultCard
                    text_content:"添加记录"
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: "PointingHandCursor"
                        onEntered: {
                            changeDefaultCard.color = "#cc33ff"
                        }
                        onExited: {
                            changeDefaultCard.color = "#cc99ff"
                        }
                        onClicked: {
                            recordPop.currentSelectIndex = selectIndex
                            recordPop.currentChildIndex = childIndex
                            var question = selectIndex===0?recordSettings.value("fitQuestion",0):recordSettings.value("friendQuestion",0)
                            question = question[childIndex]

                            var questionList = getQuestionList(question)

                            recordPop.questionNum = questionList.length

                            recordPop.questionList = questionList
                            recordPop.visible = true
                        }
                    }

                }
                Item {
                    Layout.fillWidth:true
                }
            }

        }
        Rectangle{
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.fillWidth: true
            height: parent.height
            color: "#80ff99ff"
            radius: 20
            RowLayout{
                anchors.fill: parent
                anchors.margins: 10
                Repeater{
                    id:childClassRepeater
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    model:selectList[selectIndex]
                    delegate:
                    Rectangle{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        radius: 20
                        color: "#00000000"
                        Rectangle{
                            id:classesSelect
                            anchors.fill: parent
                            anchors.margins: 5

                            Text {
                                anchors.centerIn: parent
                                text: modelData
                                color: "white"
                                font.bold: true
                                font.family: window.wfontFamily
                                font.pointSize:window.wpointSize
                            }
                            color: "#cc99ff"
                            radius: 20

                            MouseArea{
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: "PointingHandCursor"
                                onEntered: {
                                    classesSelect.color = "#cc33ff"
                                }
                                onExited: {
                                    classesSelect.color = "#cc99ff"
                                }
                                onClicked: {

                                    chooseList(selectIndex,index)
                                    childClassRepeater.itemAt(childIndex).color ="#00000000"
                                    childIndex = index
                                    defaultRoundImage.img_source = selectIndex===0?defaultImage[0][childIndex]:defaultImage[1]
                                    childClassRepeater.itemAt(index).color ="white"
//                                    var quesList = requestQuestionList(selectIndex,childIndex)
//                                    curCardTitle = getPopQuestion(selectIndex,childIndex,quesList)

                                }
                            }
                        }
                    }
                }
            }
        }
    }


    RowLayout{
        Layout.topMargin: 20
        Item {
            width: 20

        }
        ListView{
            id:cardListView
            clip: true
            Layout.preferredWidth: 500
            Layout.fillHeight: true
            spacing: 10
            delegate: RecordItem{
                currentSelectIndex: selectIndex
                currentChildIndex: childIndex
                text1_value: modelData.first_value
                text2_value: modelData.second_value
                text3_value: modelData.third_value
                text4_value: modelData.fourth_value
                card_bac_image:modelData.cardImage
                text1_key: selectIndex=== 0 ?recordSettings.value("fitQuestion",0)[childIndex].first_question:recordSettings.value("friendQuestion",0)[0].first_question
                text2_key: selectIndex=== 0 ?recordSettings.value("fitQuestion",0)[childIndex].second_question:recordSettings.value("friendQuestion",0)[0].second_question
                text3_key: selectIndex=== 0 ?recordSettings.value("fitQuestion",0)[childIndex].third_question:recordSettings.value("friendQuestion",0)[0].third_question
                text4_key: selectIndex=== 0 ?recordSettings.value("fitQuestion",0)[childIndex].fourth_question:recordSettings.value("friendQuestion",0)[0].fourth_question

            }
        }

        Rectangle{
            Layout.preferredWidth: 700
            Layout.preferredHeight:550
            color: "white"
            radius: 25
            MyLineChartView{
                id:chart
                Layout.preferredWidth: 600
                Layout.preferredHeight:500
            }

        }

    }
    Item {
        Layout.fillHeight: true
    }
    MyPopImageGridRecord{
        height: 600
        id:imagePop
        x:10
        y:(window.windowH - height)/2 + height/5
        visible: false
        imageListViewModel: cardImageSettings.value("imageUrlList",0)
    }
    MyPopUpRecord{
        id:recordPop
        x:10
        y:(window.windowH - height)/2
        visible: false

    }
    MyPopUpRecord{
        height: 500
        id:changePopRecord
        visible: false
        x:10
        y:(window.windowH - height)/2
    }

    Component.onCompleted: {
        selectIndex = 0
        highight_fit.color = "white"
        childClassRepeater.itemAt(childIndex).color = "white"
//        console.log(defaultImage[selectIndex])
        chooseList(0,0)
    }
//    onDefaultImageChanged: {
//        defaultRoundImage.img_source = selectIndex===0?defaultImage[0][childIndex]:defaultImage[1]
//    }
    function resumeHighLight(pre){
        switch(pre){
        case 0:
            highight_fit.color ="#00000000"
            break
        case 1:
            highight_friend.color ="#00000000"
            break
        }
    }
    function chooseList(ChooseSelectIndex,ChildIndex){
        var resList = []
        var selectList = []
        var lineData = [[],[],[],[],[]]

        switch(ChooseSelectIndex){
        case 0:
            selectList = recordSettings.value("fitList",0)
            if(!selectList){
                resList = []
                break;
            }
            switch(ChildIndex){
            case 0:
                resList = selectList.filter(item=>item.classes === 0)
                break;
            case 1:
                resList = selectList.filter(item=>item.classes === 1)
                break;
            case 2:
                resList = selectList.filter(item=>item.classes === 2)
                break;
            case 3:
                resList = selectList.filter(item=>item.classes === 3)
                break;
            case 4:
                resList = selectList.filter(item=>item.classes === 4)
                break;
            }
            break;
        case 1:
            selectList = recordSettings.value("friendList",0)
            if(!selectList){
                resList = []
                break
            }
            resList = selectList
            break;
        }
        if(resList.length>0){
            for(var i = 0;i<resList.length;i++){
                if(selectIndex===0){
                    //针对每个项目push进去对应的值
                    if(resList[i].first_value!=="-"){
                        lineData[0].push(resList[i].first_value)
                    }
                    if(resList[i].second_value!=="-"){
                        lineData[1].push(resList[i].second_value)
                    }
                    if(resList[i].third_value!=="-"){
                        lineData[2].push(resList[i].third_value)
                    }
                    if(resList[i].fourth_value!=="-"){
                        lineData[3].push(resList[i].fourth_value)
                    }

                }else{
                   lineData[childIndex].push(resList[i].third_value)
                }
            }
        }else{
            lineData = []
        }

//        computeSliderValue(selectIndex)
        var names = ChooseSelectIndex===0?recordSettings.value("fitQuestion",0)[ChildIndex]:recordSettings.value("friendQuestion",0)[ChildIndex]
          showCardList = resList
          lineDatas = lineData
          linenames = names
          record_time.text_content = resList.length

    }
    function getQuestionList(question){
//        console.log(question.first_question==="-"?"":question.first_question,question.second_question==="-"?"":question.second_question,question.third_question==="-"?"":question.third_question,question.fourth_question==="-"?"":question.fourth_question)
        var list = [question.first_question==="-"?"":question.first_question,question.second_question==="-"?"":question.second_question,question.third_question==="-"?"":question.third_question,question.fourth_question==="-"?"":question.fourth_question]
        return list
    }
    function starSlider(){
        sliderChange.start()
    }
}
