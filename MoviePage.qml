import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtQml 2.0
Rectangle{
    property var classesButtonsList: [{text:"电影"},{text:"动漫"},{text:"电视剧"},{text:"综艺"}]
    property var classesButtonsListTrip: [{text:"国内"},{text:"国外"}]
    property var classesButtonsListEat: [{text:"中餐"},{text:"西餐"},{text:"日料"},{text:"韩式"},{text:"其他"}]
    property var classesButtonsListPlay: [{text:"电子"},{text:"休闲"}]
    property var titleList: ["观看","旅行","吃喝","游玩"]
    property var leftBtnsList: [{text:"添加"},{text:"全部"},{text:"未完成"},{text:"已完成"},{text:"更换卡片"}]
    property var selectList: [classesButtonsList,classesButtonsListTrip,classesButtonsListEat,classesButtonsListPlay]
    property var curCardTitle: []
    property int selectIndex: 0
    property int childIndex: 0
    property alias showCardList: cardRepeater.model
    property var defaultImage: cardImageSettings.value("defaultImage",0)
    property bool isZero: false
    id:moviePage
    Layout.fillHeight: true
    Layout.fillWidth: true
    color: "#20FFBBFF"


    ColumnLayout{
        anchors.fill: parent
        //表头
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
                        text_content:"完成度"
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
                        to:movieRateSlider.value
                    }
                    RoundText {
                        id:movie_success_rate_text
                        width: 100
                        text_content:parseInt(isZero?0:movieRateSlider.value) + "%"
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
                            id:highight1
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: "#00000000"
                            radius: 20
                            Rectangle{
                                id:watch_select_rect
                                anchors.fill: parent
                                anchors.margins: 5
                                color: "#cc99ff"
                                radius: 20
                                Text {
                                    text: "观看"
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
                                        watch_select_rect.color = "#cc33ff"
                                    }
                                    onExited: {
                                        watch_select_rect.color = "#cc99ff"
                                    }
                                    onClicked: {
                                        resumeHighLight(selectIndex)

                                        highight1.color = "white"
                                        if(selectIndex ===0){
                                            return
                                        }
                                        selectIndex = 0
                                        childIndex = 0
                                        childClassRepeater.itemAt(childIndex).color = "white"
                                        chooseList(selectIndex,0)
                                        var quesList = requestQuestionList(selectIndex,childIndex)
                                        curCardTitle = getPopQuestion(selectIndex,childIndex,quesList)
                                        computeSliderValue(selectIndex)
                                    }
                                }

                            }


                        }
                        Rectangle{
                            id:highight2
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: "#00000000"
                            radius: 20

                            Rectangle{
                                id:trip_select_rect
                                anchors.fill: parent
                                anchors.margins: 5
                                color: "#cc99ff"
                                radius: 20
                                Text {
                                    text: "旅游"
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
                                        trip_select_rect.color = "#cc33ff"
                                    }
                                    onExited: {
                                        trip_select_rect.color = "#cc99ff"
                                    }
                                    onClicked: {
                                        resumeHighLight(selectIndex)

                                        highight2.color = "white"
                                        if(selectIndex ===1){
                                            return
                                        }
                                        selectIndex = 1
                                        childIndex = 0
                                        childClassRepeater.itemAt(childIndex).color = "white"
                                        chooseList(selectIndex,0)
                                        var quesList = requestQuestionList(selectIndex,childIndex)
                                        curCardTitle = getPopQuestion(selectIndex,childIndex,quesList)
                                        computeSliderValue(selectIndex)

                                    }
                                }

                            }
                        }
                    }
                    RowLayout{
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Rectangle{
                            id:highight3
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: "#00000000"
                            radius: 20

                            Rectangle{
                                id:eat_select_rect
                                anchors.fill: parent
                                anchors.margins: 5
                                color: "#cc99ff"
                                radius: 20
                                Text {
                                    text: "吃喝"
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
                                        eat_select_rect.color = "#cc33ff"
                                    }
                                    onExited: {
                                        eat_select_rect.color = "#cc99ff"
                                    }
                                    onClicked: {
                                        resumeHighLight(selectIndex)

                                        highight3.color = "white"
                                        if(selectIndex ===2){
                                            return
                                        }
                                        selectIndex = 2
                                        childIndex = 0
                                        childClassRepeater.itemAt(childIndex).color = "white"
                                        chooseList(selectIndex,0)
                                        var quesList = requestQuestionList(selectIndex,childIndex)
                                        curCardTitle = getPopQuestion(selectIndex,childIndex,quesList)
                                        computeSliderValue(selectIndex)
                                    }
                                }
                            }
                        }
                        Rectangle{
                            id:highight4
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: "#00000000"
                            radius: 20

                            Rectangle{
                                id:play_select_rect
                                anchors.fill: parent
                                anchors.margins: 5
                                color: "#cc99ff"
                                radius: 20
                                Text {
                                    text: "玩乐"
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
                                        play_select_rect.color = "#cc33ff"
                                    }
                                    onExited: {
                                        play_select_rect.color = "#cc99ff"
                                    }
                                    onClicked: {
                                        resumeHighLight(selectIndex)

                                        highight4.color = "white"
                                        if(selectIndex ===3){
                                            return
                                        }
                                        selectIndex = 3
                                        childIndex = 0
                                        childClassRepeater.itemAt(childIndex).color = "white"
                                        chooseList(selectIndex,0)
                                        var quesList = requestQuestionList(selectIndex,childIndex)
                                        curCardTitle = getPopQuestion(selectIndex,childIndex,quesList)
                                        computeSliderValue(selectIndex)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        //搜索框
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
                        Layout.leftMargin: 20
                        Layout.rightMargin: 5
                        img_source: defaultImage[selectIndex]
                        border_radius:20
                        width: 230
                        height: 80
                    }
                    RoundText{
                        id:changeDefaultCard
                        text_content:"默认卡片"
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
                                imagePop.visible = true
                                imagePop.changeDefault = true
                                imagePop.currentSelectIndex = selectIndex
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
                                    text: modelData.text
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
                                        childClassRepeater.itemAt(index).color ="white"
                                        var quesList = requestQuestionList(selectIndex,childIndex)
                                        curCardTitle = getPopQuestion(selectIndex,childIndex,quesList)

                                    }
                                }
                            }
                        }


                    }

                }

            }
        }


        //主显示

        RowLayout{
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle{
                id:movie_primary_view
                width: 1600*0.8-160
                Layout.fillHeight: true
                color: "#6099ccff"
                radius: 20
                Layout.topMargin: 10
                Layout.bottomMargin: 10

                Flickable{
                    anchors.leftMargin: 30
                    clip: true
                    width: parent.width -30
                    height: parent.height
//                    anchors.fill: parent
                    interactive: true
                    contentWidth: movie_listview.width
                    contentHeight: movie_listview.height+40
//                    Component.onCompleted: console.log("contentWidth",contentWidth,"contentHeight",contentHeight)
                    ColumnLayout{
                        Item {
                            width: 50
                        }
                        RowLayout
                        {
                            Layout.topMargin: 30
                            Item {
                                width: 80
                            }
                            Grid{
                                id:movie_listview
                                columnSpacing: 30
                                rowSpacing:30
                                spacing: 20

                                columns: 2
                                Repeater{
                                    id:cardRepeater
                                    Layout.topMargin: 30
                                    delegate: CardItem{

                                           currentSelectIndex: selectIndex
                                           currentChildIndex: childIndex
                                           text1_key: curCardTitle[0]
                                           text1_value: modelData.text1_value?modelData.text1_value:"-"
                                           text2_key: curCardTitle[1]
                                           text2_value: modelData.text2_value?modelData.text2_value:"-"
                                           text3_key: curCardTitle[2]
                                           text3_value: modelData.text3_value?modelData.text3_value:"-"
                                           text4_key: curCardTitle[3]?curCardTitle[3]:"-"
                                           text4_value: modelData.text4_value?modelData.text4_value:"-"
                                           text5_key: curCardTitle[4]?curCardTitle[4]:"-"
                                           text5_value: modelData.text5_value?modelData.text5_value:"-"
                                           isSuccess: modelData.state==="success"?true:false
                                           card_bac_image: modelData.cardImage?modelData.cardImage:defaultImage[selectIndex]


                                    }
                                }


                            }

                        }

                    }

                }
            }


            Item {
                Layout.fillWidth: true
            }
            Rectangle{
                Layout.topMargin: 10
                Layout.bottomMargin: 10
                Layout.rightMargin: 10
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "#ff99ff"
                radius: 20
                ColumnLayout{
                anchors.fill: parent
                anchors.topMargin: 15
                Repeater{
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    model:leftBtnsList
                    delegate:
                        Rectangle{
                            id:leftBtnRect
                            Layout.preferredHeight: 80
                            Layout.fillWidth: true
                            Text {
                                id:leftBtntext
                                anchors.centerIn: parent
                                text: modelData.text
                                color: "white"
                                font.bold: true
                                font.family: window.wfontFamily
                                font.pointSize:window.wpointSize
                            }
                            color: "#80ff99ff"
                            MouseArea{
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: "PointingHandCursor"
                                onEntered: {
                                    leftBtnRect.color = "white"
                                    leftBtntext.color = "#ff99ff"
                                }
                                onExited: {
                                    leftBtnRect.color = "#ff99ff"
                                    leftBtntext.color = "white"
                                }
                                onClicked: {
                                    //添加卡片
                                     if(index === 0 ){
                                         needToDpPop.currentSelectIndex = selectIndex
                                         needToDpPop.currentChildIndex = childIndex
                                         var quesList = requestQuestionList(selectIndex,childIndex)
                                         var question = getPopQuestion(selectIndex,childIndex,quesList)
                                         needToDpPop.questionList = question
                                         needToDpPop.visible = true
                                         needToDpPop.questionNum = question.length
//                                         PersonalCenterPage.getPersonRecord()

                                     }
                                     //显示全部卡片
                                     if(index===1){
                                         chooseList(selectIndex,childIndex)
                                     }
                                     //只显示未完成的卡片
                                     if(index === 2){
                                         chooseList_success_fail(selectIndex,childIndex,false)
                                     }
                                     if(index === 3){
                                         chooseList_success_fail(selectIndex,childIndex,true)
                                     }
                                }
                            }
                        }
                    }
                Item {
                    Layout.fillHeight: true
                }

            }

                }

        }
        Item {
            Layout.fillHeight: true
        }
    }
    MyPopUp{
        id:needToDpPop
    }
    MyPopImageGrid{
        height: 600
        x:10
        y:(window.windowH - height)/2 + height/5
        id:imagePop
        visible: false
        imageListViewModel : cardImageSettings.value("imageUrlList",0)
        changeDefault: false

    }
    Component.onCompleted: {
        chooseList(0,0)
        needToDpPop.questionList = ["1"]
        highight1.color = "white"
        childClassRepeater.itemAt(0).color = "white"
        var quesList = requestQuestionList(selectIndex,childIndex)
        curCardTitle = getPopQuestion(selectIndex,childIndex,quesList)
        computeSliderValue(selectIndex)
    }
    function chooseList(ChooseSelectIndex,ChildIndex){
        var resList = []
        var selectList = []
        switch(ChooseSelectIndex){
        case 0:
            selectList = needToDoSettings.value("watchList",0)
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
            }
            break;
        case 1:
            selectList = needToDoSettings.value("tripList",0)
            if(!selectList){
                resList = []
                break
            }
            switch(ChildIndex){
            case 0:
                resList = selectList.filter(item=>item.classes === 0)
                break;
            case 1:
                resList = selectList.filter(item=>item.classes === 1)
                break;
            }
            break;
        case 2:
            selectList = needToDoSettings.value("eatList",0)
            if(!selectList){
                resList = []
                break
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
        case 3:
            selectList = needToDoSettings.value("playList",0)
            if(!selectList){
                resList = []
                break
            }
            switch(ChildIndex){
            case 0:
                resList = selectList.filter(item=>item.classes === 0)
                break;
            case 1:
                resList = selectList.filter(item=>item.classes === 1)
                break;
            }
            break;
        }
        computeSliderValue(selectIndex)
        return showCardList = resList
    }
    function chooseList_success_fail(ChooseSelectIndex,ChildIndex,isSuccess){
        var resList = []
        var selectList = []
        switch(ChooseSelectIndex){
        case 0:
            selectList = needToDoSettings.value("watchList",0)
            if(!selectList){
                resList = []
                break;
            }
            switch(ChildIndex){
            case 0:
                resList = selectList.filter(item=>item.classes === 0)
                if(isSuccess){
                     resList = resList.filter(item=>item.state === "success" )
                }else{
                    resList = resList.filter(item=>item.state === "fail" )
                }
                break;
            case 1:
                resList = selectList.filter(item=>item.classes === 1 )
                if(isSuccess){
                     resList = resList.filter(item=>item.state === "success" )
                }else{
                    resList = resList.filter(item=>item.state === "fail" )
                }
                break;
            case 2:
                resList = selectList.filter(item=>item.classes === 2)
                if(isSuccess){
                     resList = resList.filter(item=>item.state === "success" )
                }else{
                    resList = resList.filter(item=>item.state === "fail" )
                }
                break;
            case 3:
                resList = selectList.filter(item=>item.classes === 3)
                if(isSuccess){
                     resList = resList.filter(item=>item.state === "success" )
                }else{
                    resList = resList.filter(item=>item.state === "fail" )
                }
                break;
            }
            break;
        case 1:
            selectList = needToDoSettings.value("tripList",0)
            if(!selectList){
                resList = []
                break
            }
            switch(ChildIndex){
            case 0:
                resList = selectList.filter(item=>item.classes === 0)
                if(isSuccess){
                     resList = resList.filter(item=>item.state === "success" )
                }else{
                    resList = resList.filter(item=>item.state === "fail" )
                }
                break;
            case 1:
                resList = selectList.filter(item=>item.classes === 1)
                if(isSuccess){
                     resList = resList.filter(item=>item.state === "success" )
                }else{
                    resList = resList.filter(item=>item.state === "fail" )
                }
                break;
            }
            break;
        case 2:
            selectList = needToDoSettings.value("eatList",0)
            if(!selectList){
                resList = []
                break
            }
            switch(ChildIndex){
            case 0:
                resList = selectList.filter(item=>item.classes === 0)
                if(isSuccess){
                     resList = resList.filter(item=>item.state === "success" )
                }else{
                    resList = resList.filter(item=>item.state === "fail" )
                }
                break;
            case 1:
                resList = selectList.filter(item=>item.classes === 1)
                if(isSuccess){
                     resList = resList.filter(item=>item.state === "success" )
                }else{
                    resList = resList.filter(item=>item.state === "fail" )
                }
                break;
            case 2:
                resList = selectList.filter(item=>item.classes === 2)
                if(isSuccess){
                     resList = resList.filter(item=>item.state === "success" )
                }else{
                    resList = resList.filter(item=>item.state === "fail" )
                }
                break;
            case 3:
                resList = selectList.filter(item=>item.classes === 3)
                if(isSuccess){
                     resList = resList.filter(item=>item.state === "success" )
                }else{
                    resList = resList.filter(item=>item.state === "fail" )
                }
                break;
            case 4:
                resList = selectList.filter(item=>item.classes === 4)
                if(isSuccess){
                     resList = resList.filter(item=>item.state === "success" )
                }else{
                    resList = resList.filter(item=>item.state === "fail" )
                }
                break;
            }
            break;
        case 3:
            selectList = needToDoSettings.value("playList",0)
            if(!selectList){
                resList = []
                break
            }
            switch(ChildIndex){
            case 0:
                resList = selectList.filter(item=>item.classes === 0)
                if(isSuccess){
                     resList = resList.filter(item=>item.state === "success" )
                }else{
                    resList = resList.filter(item=>item.state === "fail" )
                }
                break;
            case 1:
                resList = selectList.filter(item=>item.classes === 1)
                if(isSuccess){
                     resList = resList.filter(item=>item.state === "success" )
                }else{
                    resList = resList.filter(item=>item.state === "fail" )
                }
                break;
            }
            break;
        }
        return showCardList = resList
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

    function resumeHighLight(pre){
        switch(pre){
        case 0:
            highight1.color ="#00000000"
            break
        case 1:
            highight2.color ="#00000000"
            break
        case 2:
            highight3.color ="#00000000"
            break
        case 3:
            highight4.color ="#00000000"
            break

        }
    }
    function computeSliderValue(selectIndex){
        var totalNum = 0
        var successNum = 0
        var list = []
        var slider_value = 0
        switch(selectIndex){

        case 0:
            list = needToDoSettings.value("watchList",0)
            totalNum = list?list.length:0
            successNum = totalNum?list.filter(item=>item.state === "success" ).length:0
            break
        case 1:
            list = needToDoSettings.value("tripList",0)
            totalNum = list?list.length:0
            successNum = totalNum?list.filter(item=>item.state === "success" ).length:0
            break
        case 2:
            list = needToDoSettings.value("eatList",0)
            totalNum = list?list.length:0
            successNum = totalNum?list.filter(item=>item.state === "success" ).length:0
            break
        case 3:
            list = needToDoSettings.value("playList",0)
            totalNum = list?list.length:0
            successNum = totalNum?list.filter(item=>item.state === "success" ).length:0
            break

        }

        if(successNum===0 && totalNum!==0){
            isZero = true
        }else{
            isZero = false
        }
        slider_value = totalNum?(parseInt((successNum/totalNum)*100)):100
        movieRateSlider.value = slider_value
//        console.log(movieRateSlider.value)

    }
    function starSlider(){
        sliderChange.start()
    }
}

