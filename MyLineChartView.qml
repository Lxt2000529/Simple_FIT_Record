import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtCharts 2.3

ChartView {
    id: chartView
    anchors.fill: parent
    property real pressMouseX: 0
    property real preMouseX: 0
    property real preMouseY: 0
    property real pressMouseY: 0
    property real distance: 0
    property var lineData: [[],[],[],[],[]]
    property var names: []
    legend.visible: true
    backgroundColor: "#00000000"
    LineSeries {
        id:myLine
        name: names.first_question?names.first_question:"-"
        visible: names.first_question==="-"?false:true
        color: "#EE7942"
        width: 5

        axisX: ValueAxis {
            id:axis_x
            labelFormat: "%.0f"
            min: 0
            max: 3

        }

        axisY: ValueAxis {
            id:axis_y
            labelFormat: "%.0f"
            min: 0
            max: 5
        }
        pointLabelsVisible: true
        pointLabelsFormat: "@yPoint"
    }
    LineSeries {
        id:myLine_2
        name: names.second_question?names.second_question:"-"
        visible: names.second_question==="-"?false:true
        color: "#66ffcc"
        width: 5

        axisX:axis_x

        axisY:axis_y
        pointLabelsVisible: true
        pointLabelsFormat: "@yPoint"
    }
    LineSeries {
        id:myLine_3
        name: names.third_question?names.third_question:"-"
        visible: names.third_question==="-"?false:true
        color: "#ff00cc"
        width: 5

        axisX:axis_x

        axisY:axis_y
        pointLabelsVisible: true
        pointLabelsFormat: "@yPoint"
    }
    LineSeries {
        id:myLine_4
        name: names.fourth_question?names.fourth_question:"-"
        visible: names.fourth_question==="-"?false:true
        color: "#ffff00"
        width: 5

        axisX:axis_x

        axisY:axis_y
        pointLabelsVisible: true
        pointLabelsFormat: "@yPoint"
    }
    LineSeries {
        id:myLine_5
        name: names.fifth_question?names.fifth_question:"-"
        visible: names.fifth_question?(names.fifth_question==="-"?false:true):false
        color: "#cc99ff"
        width: 5
        axisX:axis_x
        axisY:axis_y
        pointLabelsVisible: true
        pointLabelsFormat: "@yPoint"
    }



    MouseArea {
        anchors.fill: parent
        drag.target: chartView
        onReleased: {
            chartView.scrollLeft(vel);
            chartView.scrollUp(vel);
        }
        onPositionChanged: {
            if((preMouseX - mouseX)<0){
                chartView.scrollLeft((mouseX-preMouseX));
                preMouseX = mouseX
            }
            if((preMouseY - mouseY)<0){
                chartView.scrollUp((mouseY-preMouseY));
                preMouseY = mouseY
            }
            if((preMouseY - mouseY)>0){
                chartView.scrollDown((preMouseY-mouseY));
                preMouseY = mouseY
            }

            if((preMouseX - mouseX)>0){
                chartView.scrollRight((preMouseX-mouseX));
                preMouseX = mouseX

            }

        }
        onPressed: {
              pressMouseX = mouseX
              preMouseX = mouseX
              pressMouseY = mouseY
              preMouseY = mouseY
        }

        onWheel: {
            // deltaY表示垂直滚轮的滚动值，正数表示向上滚动，负数表示向下滚动
            var mouse_x = mouseX
            var mouse_Y = mouseY
            var scaleFactor = 1.1 // 缩放因子

            // 计算缩放的中心点位置
            var centerPoint = chartView.mapToPosition(Qt.point(mouse_x, mouse_Y))

            // 根据滚动方向调整缩放因子
            if (wheel.angleDelta.y < 0) {
                scaleFactor = 1 / scaleFactor // 向上滚动，放大
            }

            // 在中心点进行缩放
            chartView.zoom(scaleFactor, centerPoint.x, centerPoint.y)

            // 阻止事件传递给父级
            wheel.accepted = true
        }

        property real vel: 0.5
    }
    onLineDataChanged: {
//        console.log("......")
        var max_x = 0
        var max_y = 0
        var temp = -1
        for(var z = 0;z<lineData.length;z++){
            if(lineData[z].length>max_x){
                max_x = lineData[z].length
            }
             temp = Math.max.apply(null, lineData[z]);
            if(temp>max_y){
                max_y = temp
            }

        }

        if(max_x<10){
            axis_x.min = 0
            axis_x.max = max_x
        }else{
            axis_x.min = max_x - 10
            axis_x.max = max_x
        }
        axis_y.min = 0
        axis_y.max =max_y+5

        myLine.clear()
        myLine_2.clear()
        myLine_3.clear()
        myLine_4.clear()
        myLine_5.clear()

        for(var j = 0;j<lineData.length;j++){

            if(lineData[j].length>0){

                lineData[j].reverse()
                for (var i = 0; i < lineData[j].length; ++i) {
                    if(j===0){
                        myLine.append(i,lineData[j][i])
                    }
                    if(j===1){
                        myLine_2.append(i,lineData[j][i])
                    }
                    if(j===2){
                        myLine_3.append(i,lineData[j][i])
                    }
                    if(j===3){
                        myLine_4.append(i,lineData[j][i])
                    }
                    if(j===4){
                        myLine_5.append(i,lineData[j][i])
                    }

                }

            }else{
                if(j===0){
                    myLine.clear()
                }
                if(j===1){
                    myLine_2.clear()
                }
                if(j===2){
                    myLine_3.clear()
                }
                if(j===3){
                    myLine_4.clear()
                }
                if(j===4){
                    myLine_5.clear()
                }
            }
        }


    }
}

