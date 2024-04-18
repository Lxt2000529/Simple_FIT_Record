import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Shapes 1.12

Canvas {
    property int arcWidth: 2
    property bool anticlockwise: false
    property real process: 0
    property real radius: 100
    id: canvas
    width: 2 * radius + arcWidth
    height: 2 * radius + arcWidth

    Text {
        anchors.centerIn: parent
        font.pointSize: 15
        text: Math.floor((parent.process / 360) * 100) + "%"
    }

    Timer {
        id: timer
        running: false
        repeat: true
        interval: 5
        onTriggered: {
            parent.process++;
            if (parent.process > 100) {
                return;
            }
        }
    }

    function onStop() {
        timer.running = false
    }

    function isRunning() {
        return timer.running
    }

    function onStart() {
        process = 0;
        timer.running = true;
    }


    onPaint: {
        var ctx = getContext("2d")
        ctx.clearRect(0, 0, width, height)

        // Draw outer circle
        ctx.beginPath()
        ctx.strokeStyle = "green"
        ctx.lineWidth = arcWidth
        ctx.arc(width / 2, height / 2, radius, 0, 2 * Math.PI, anticlockwise)
        ctx.stroke()

        // Draw progress arc
        // 画进度弧
               var r = process * Math.PI / 180
               ctx.beginPath()
               ctx.strokeStyle = "black"
               ctx.lineWidth = arcWidth
               ctx.arc(width / 2, height / 2, radius, -90 * Math.PI / 180, r - 90 * Math.PI / 180, anticlockwise)
               ctx.stroke()
    }
}
