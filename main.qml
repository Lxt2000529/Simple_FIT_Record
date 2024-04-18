import QtQuick 2.14
import QtQuick.Window 2.14
import QtQml 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
import QtGraphicalEffects 1.0
ApplicationWindow {
    id:window
    property int windowW: 1600
    property int windowH: 900
    property string wfontFamily: "微软雅黑"
    property int wpointSize: 16       
    visible: true
    width: windowW
    height: windowH
    title: "我们的记录"
//    modality:Qt.WindowModal
    minimumWidth:1600
    maximumWidth:1600
    minimumHeight:900
    maximumHeight:900
    Settings{
        id:rootSettimg
        fileName:"conf/rootSettings.ini"
        property var rootImage:"qrc:/image/pic_1.png"
        property var rootImageList:["qrc:/image/pic_1.png","qrc:/image/pic_2.png","qrc:/image/pic_3.png","qrc:/image/pic_4.png"]
        property var rootId:"郑思楠"
        property var sex: "女"
    }
    Settings{
        id:needToDoSettings
        fileName:"conf/watchSettings.ini"
        property var watchList:[]
        property var tripList:[]
        property var eatList:[]
        property var playList:[]
        property var movieQuestion: [{name:"作品名: ",star:"等级: ",remarks:"备注: "}]
        property var movieMulQuestion: [{name:"作品名: ",star:"等级: ",allStep:"总集数: ",step:"观看至: ",remarks:"备注: "}]
        property var tripQuestion: [{name:"地方: ",star:"等级: ",remarks:"备注: "}]
        property var eatQuestion: [{name:"餐厅/食物: ",star:"等级: ",remarks:"备注: "}]
        property var playEleQuestion: [{name:"游戏名: ",star:"等级: ",remarks:"备注: "}]
        property var playRelaxQuestion: [{name:"项目: ",star:"等级: ",remarks:"备注: "}]

    }
    Settings{
        id:recordSettings
        fileName:"conf/recordSettings.ini"
        property var fitList:[]
        property var friendList:[]
        property var fitQuestion: [{classes:0,first_question:"杠铃卧推: ",second_question:"上斜: ",third_question:"-",fourth_question:"-",remarks:"备注: "}
            ,{classes:1,first_question:"引体向上: ",second_question:"杠铃划船: ",third_question:"高位下拉: ",fourth_question:"坐姿划船:" ,remarks:"备注: "},
            {classes:2,first_question:"深蹲",second_question:"腿屈伸: ",third_question:"腿后侧: ",fourth_question:"-" ,remarks:"备注: "},
            {classes:3,first_question:"哑铃飞鸟: ",second_question:"哑铃推举: ",third_question:"器械推举: ",fourth_question:"蝴蝶后束" ,remarks:"备注: "}
            ,{classes:4,first_question:"21杠铃弯举: ",second_question:"-",third_question:"-",fourth_question:"-" ,remarks:"备注: "}]

        property var friendQuestion: [{first_question:"年: ",second_question:"月: ",third_question:"日: ",fourth_question:"-",remarks:"备注: "}]
        property var defaultImage_fit: ["qrc:/image/bac_5.png","qrc:/image/bac_6.png","qrc:/image/bac_7.png","qrc:/image/bac_8.png","qrc:/image/bac_9.png"]
        property var defaultImage_friend: "qrc:/image/bac_6.png"
    }
    Settings{
        id:cardImageSettings
        fileName:"conf/cardImageSettings.ini"
        property var imageUrlList:["qrc:/image/la_bac_1.png","qrc:/image/la_bac_2.png","qrc:/image/la_bac_3.png","qrc:/image/la_bac_4.png","qrc:/image/bac_1.png","qrc:/image/bac_2.png","qrc:/image/bac_3.png","qrc:/image/bac_4.png","qrc:/image/bac_5.png","qrc:/image/bac_6.png","qrc:/image/bac_7.png","qrc:/image/bac_8.png","qrc:/image/bac_9.png"]
        property var defaultImage: ["qrc:/image/bac_5.png","qrc:/image/bac_6.png","qrc:/image/bac_7.png","qrc:/image/bac_8.png"]
    }

//    Back{
//        anchors.fill: parent
//        visible: themeSettings.value("isDefault",0)?false:true
//    }

    background: Rectangle{
        color: "#20FFBBFF"
//        gradient: Gradient {
//            GradientStop { position: 0.0; color: "blue" }
//            GradientStop { position: 1.0; color: "purple" }
//            orientation:Gradient.Horizontal
//        }
    }
    RowLayout{
        anchors.fill: parent
        LayoutPageView{
            id:layoutPageView
        }


    }
//    {classes:"0",text1_key:"电影名: ",text1_value:"阿甘正传",text2_value:"5",state:"fail"},
//                {classes:"0",text1_value:"阿甘正传",text2_value:"5",state:"success"},
//                {classes:"1",text1_value:"鬼灭之人",text2_value:"5",state:"success"},
//                {classes:"2",text1_value:"绝命毒师",text2_value:"5",state:"success"},
//                {classes:"3",text1_value:"奔跑吧",text2_value:"5",state:"success"},

//    Component.onCompleted: {
//        if (Qt.platform.os === "windows") {
//            // 在Windows平台上设置ICO图标
//            var iconComponent = Qt.createComponent("qrc:/image/Logo.png");
//            if (iconComponent.status === Component.Ready) {
//                windowIcon = iconComponent.createObject();
//            }
//        }
//    }


//    Settings{
//        id:themeSettings
//        fileName:"conf/themeSettings.ini"
//        property bool isColor: true
//        property int colorIndex: 0
//        property int themeIndex: 0
//        property var changeTheme: ["qrc:/image/bac_5.png","qrc:/image/bac_6.png","qrc:/image/bac_7.png","qrc:/image/bac_8.png"]
//        property var changeColor: [[{leftBar:"#cc99ff",leftBarEnter:"FFBBFF",pageTitleRect:"#FFE1FF",midRect:"#80FF99FF",primaryContentRect:"#6099ccff",roundText:"#cc99ff",roundTextEnter:"#cc33ff",roundTextSelect:"white",rightBar:"#ff99ff",rightBarEnter:"white",idColor:"#EE7942",popup:"#cc99ff"}],
//                                   [{leftBar:"#cc99ff",leftBarEnter:"FFBBFF",pageTitleRect:"#00ff99",midRect:"#80FF99FF",primaryContentRect:"#6099ccff",roundText:"#33ff99",roundTextEnter:"#99ff66",roundTextSelect:"white",rightBar:"#ff99ff",rightBarEnter:"white",idColor:"#EE7942",popup:"#cc99ff"}]]
//    }
//    function changeTheme(){
//        if( themeSettings.value("isColor",0)){
//            colorList = themeSettings.value("changeColor",0)[themeSettings.value("colorIndex",0)][0]
//            console.log(colorList.leftBar)
//        }else{
//            themeImage = themeSettings.value("changeTheme",0)[themeSettings.value("themeIndex",0)]
//            console.log(themeImage[0])
//        }
//    }
//    Component.onCompleted: {

//        changeTheme()
//        console.log(window.colorList.roundText)

//    }


}
