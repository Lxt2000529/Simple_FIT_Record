import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
Rectangle{

    property var showProcessData: []
    property var themeImage: []
    property alias line_fit: fitLikeLineChart.lineData
    property alias line_friend: friendChart.lineData
    property alias id: id.text
    property alias sex: sex.text
    property alias rootImage: rootImage.img_source

    id:personalCenterPage
    Layout.fillHeight: true
    Layout.fillWidth: true
    color: "#20FFBBFF"
    //

    ColumnLayout{
        //个人信息+总进度+更换主题
        RowLayout{
            Layout.topMargin: 20
            Layout.bottomMargin: 20
            Item {

                width: 10
            }

            Rectangle{

                Layout.preferredWidth: 250
                Layout.preferredHeight: 150
                radius: 20
                color: "#FFE1FF"
                RowLayout{
                    ColumnLayout{
                        width: 100
                        height: 100
                        Layout.leftMargin: 10
                        Layout.topMargin: 10
                        RoundImage{
                            id:rootImage
                            width: 100
                            height: 100
                            img_source: rootSettimg.value("rootImage",0)
                        }
                        RoundButton{
                            id:selfRoundButton
                            textContent: "更换头像"
                            Layout.alignment: Qt.AlignHCenter
                            width: 80
                            height: 25
                            MouseArea{
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: "PointingHandCursor"
                                onEntered: {
                                     selfRoundButton.bac_color = "#cc33ff"

                                }
                                onExited: {

                                    selfRoundButton.bac_color = "#cc99ff"
                                }
                                onClicked: {
                                    //弹出照片选择界面，然后将照片选择的路径进行保存
                                    myPopImageGridRoot.imageListViewModel = rootSettimg.value("rootImageList",0)
                                    myPopImageGridRoot.visible = true
                                }
                            }
                        }
                    }
                    MyPopUp{
                        id:text_pop
                        visible: false
                    }

                    ColumnLayout{
                        RowLayout{
                            Rectangle{
                                Layout.preferredWidth: 30
                                Layout.topMargin: 20
                                Layout.preferredHeight: 30
                                Text {
                                    text: "id:"
                                    anchors.centerIn: parent
                                    font.family: window.wfontFamily
                                    font.pointSize:9
                                    font.bold: true
                                    color: "white"


                                }
                                color:"#cc99ff"
                                radius: 5
                            }
                            Rectangle{
                                Layout.preferredWidth: 90
                                Layout.topMargin: 20
                                Layout.preferredHeight: 30
                                Text {
                                    id: id
                                    text: rootSettimg.value("rootId",0)
                                    anchors.centerIn: parent
                                    font.family: window.wfontFamily
                                    font.pointSize:9
                                    color: "white"
                                    font.bold: true

                                }
                                color:"#EE7942"
                                radius: 5
                            }
                        }

                        RowLayout{
                            Rectangle{
                                Layout.preferredWidth: 30
                                Layout.topMargin: 5
                                Layout.preferredHeight: 30
                                Text {
                                    text: "sex:"
                                    anchors.centerIn: parent
                                    font.family: window.wfontFamily
                                    font.pointSize:9
                                    color: "white"
                                    font.bold: true

                                }
                                color:"#cc99ff"
                                radius: 5
                            }
                            Rectangle{
                                Layout.preferredWidth: 90
                                Layout.topMargin: 5
                                Layout.preferredHeight: 30
                                Text {
                                    id: sex
                                    text: rootSettimg.value("sex",0)
                                    anchors.centerIn: parent
                                    font.family: window.wfontFamily
                                    font.pointSize:9
                                    color: "white"
                                    font.bold: true

                                }
                                color:"#EE7942"
                                radius: 5
                            }
                        }

                        Item {
                            Layout.fillHeight: true
                        }
                    }

                }

            }

            Rectangle{

                Layout.leftMargin: 20
                Layout.preferredWidth: successRateText.width+successRateSlider.width+30+90+80
                Layout.preferredHeight: 150
                color: "#FFE1FF"
                radius: 20
                RowLayout{
                        anchors.centerIn: parent
                    Rectangle{
                        Layout.leftMargin: 20
                        Layout.preferredWidth: successRateText.width+15
                        Layout.preferredHeight: successRateText.height+15
                        radius: 10
                        color: "#cc99ff"
                        Text {
                            id:successRateText
                            anchors.centerIn: parent
                            text: "完成度"
                            font.family: window.wfontFamily
                            font.pointSize:window.wpointSize
                            color: "white"
                            font.bold: true
                        }
                    }

                    MySlider{
                        id:successRateSlider
                        Layout.leftMargin:20
                        Layout.alignment: Qt.AlignVCenter
                        preferW: 500
                        preferH: 30
                        slider_radius:20
                    }
                    NumberAnimation {
                        id:sliderChange
                        target: successRateSlider
                        property: "value"
                        duration: 2000
                        from:0
                        to:successRateSlider.value
                    }

                    Rectangle{
                        id:successPrecentRect
                        Layout.leftMargin: 20
                        Layout.preferredWidth: 90
                        Layout.preferredHeight: successPercentText.height+15
                        radius: 10
                        color: "#cc99ff"
                        Text {
                            id:successPercentText
                            anchors.centerIn: parent
                            text: parseInt(successRateSlider.value)+" %"
                            font.family: window.wfontFamily
                            font.pointSize:window.wpointSize
                            color: "white"
                            font.bold: true
                        }
                    }
                }
            }

            Rectangle{
                Layout.leftMargin: 20

                Layout.preferredHeight: 150
                Layout.preferredWidth: 150
                radius: 20
                color: "#FFE1FF"
                ColumnLayout{
                    anchors.centerIn: parent
                    RoundButton{
                        id:changeInfoBtn
                        width: 90
                        height: 80
                        textContent:"更改信息"
                         textSize: 10
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: "PointingHandCursor"
                            onEntered: {
                                 changeInfoBtn.bac_color = "#cc33ff"
                            }
                            onExited: {
                                changeInfoBtn.bac_color ="#cc99ff"
                            }
                            onClicked: {
                                //更改信息
                                rootpopUp.visible = true
                            }
                        }
                    }
                }
            }



        }
        RowLayout{
            Layout.topMargin: 20
            Layout.bottomMargin: 20
            Item {

                width: 10
            }
            Rectangle{
                Layout.preferredHeight: 230
                Layout.fillWidth: true
                color: "#FFE1FF"
                radius: 20
                RowLayout{
                    anchors.fill: parent
                    Rectangle{
                        Layout.margins: 20
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        radius: 20
                        color: "#cc99ff"
                        ColumnLayout{
                            anchors.fill: parent
                            ShowProcess{
                                title: "总待做："
                                value: showProcessData[0]
                            }
                            ShowProcess{
                                title: "已完成："
                                value: showProcessData[1]

                            }
                            ShowProcess{
                                title: "未完成："
                                value: showProcessData[2]

                            }

                        }

                    }
                    Rectangle{
                        Layout.margins: 20
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        radius: 20
                        color: "#cc99ff"
                        ColumnLayout{
                            anchors.fill: parent
                            ShowProcess{
                                title: "总记录："
                                value: showProcessData[3]
                            }
                            ShowProcess{
                                title: "健身："
                                value: showProcessData[4]
                            }
                            ShowProcess{
                                title: "例假："
                                value: showProcessData[5]

                            }

                        }

                    }
                }

            }
            Item {

                width: 10
            }
        }
        Rectangle{
            color: "white"
            Layout.preferredHeight:380
            Layout.margins: 10
            Layout.fillWidth: true
            radius: 20
            RowLayout{
                anchors.fill: parent
                anchors.margins: 20
                Frame{
                    Layout.fillHeight:true
                    Layout.fillWidth: true
                    MyLineChartView{
                        id:fitLikeLineChart
                        anchors.fill: parent
                        names:[{first_question:"杠铃卧推",second_question:"杠铃划船",third_question:"深蹲",fourth_question:"哑铃推肩",fifth_question:"21弯举"}][0]
                    }
                }
                Item {
                    width: 10
                }
                Frame{
                    Layout.fillHeight:true
                    Layout.fillWidth: true
                    MyLineChartView{
                        id:friendChart
                        anchors.fill: parent
                        names:[{first_question:"日期",second_question:"-",third_question:"-",fourth_question:"-",fifth_question:"-"}][0]
                    }
                }

            }

        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        MyPopUpRoot{
            id:rootpopUp
            visible: false
        }
        MyPopImageGridRoot{
            id:myPopImageGridRoot
            visible: false
        }
    }
    function getPersonRecord(){
        var list = []
        var searchListNeed = ["watchList","tripList","eatList","playList"]
        var searchListRecord = ["fitList","friendList"]
        var needTotalNumber = 0
        var needSuccessNumber = 0

        var recordTotal = 0
        var recordFit = 0
        var recordFriend = 0
        for(var i = 0;i<4;i++){
            list = needToDoSettings.value(searchListNeed[i],0)
            needTotalNumber+=list?list.length:0
            list = list?list.filter(item=>item.state === "success"):[]
            needSuccessNumber+=list.length
        }

        for(var i = 0;i<2;i++){
            list = recordSettings.value(searchListRecord[i],0)
            recordTotal+=list?list.length:0
            if(i === 0){
                recordFit+=list?list.length:0
            }else{
                recordFriend+=list?list.length:0
            }

        }
        list = []
//        needTotalNumber = needTotalNumber?needTotalNumber:0
//        needSuccessNumber = needSuccessNumber?needSuccessNumber:0
//        recordTotal = recordTotal?recordTotal:0
//        recordFit = recordFit?recordFit:0
//        recordFriend = recordFriend?recordFriend:0
        list = [needTotalNumber,needSuccessNumber,needTotalNumber-needSuccessNumber,recordTotal,recordFit,recordFriend]
        showProcessData = list
        if(needTotalNumber===0){
            successRateSlider.value = 100
        }else{
            successRateSlider.value = parseInt((needSuccessNumber/needTotalNumber)*100)
        }

    }
    function getLineData(){
        var lineData_fit = [[],[],[],[],[]]
        var lineData_friend = [[],[],[],[],[]]
        var fitList = []
        var friendList = []
        var temp = []
        fitList = recordSettings.value("fitList",0)
        for(var j = 0 ; j<5;j++){
            temp = fitList?fitList.filter(item=>item.classes === j):[]
            for(var i = 0;i<temp.length;i++){
                if((j===0||j===2||j===4)&&temp[i].first_value!=='-'){
                    lineData_fit[j].push(temp[i].first_value)
                }
                if((j===1||j===3)&&temp[i].first_value!=='-'){
                    lineData_fit[j].push(temp[i].second_value)
                }

            }

        }
        friendList = recordSettings.value("friendList",0)
        if(!friendList){
            friendList = []
        }
        for(var i = 0;i<friendList.length;i++){
            if(friendList[i].third_value!=="-"){
                lineData_friend[0].push(friendList[i].third_value)
            }
        }
        line_fit = lineData_fit
        line_friend = lineData_friend

    }
    function starSlider(){
        sliderChange.start()
    }
    Component.onCompleted: {
        getPersonRecord()
        getLineData()
    }
}
