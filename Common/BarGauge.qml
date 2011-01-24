import Qt 4.7

Rectangle {
    color:"#00000000"
    border.color: "black"

    property int val:0
    property int max:100

    property string _valueStr: "0 %"

    property bool isHorizontal: false
    property bool showLabel: false

    onValChanged: {
        if (val > max) val = max;
        _valueStr = val + " %";
    }

    Rectangle {
        color:"green"
        anchors.bottom: parent.bottom
        height:parent.height*val/max
        width: parent.width
        opacity: isHorizontal ? 0 : 1
        Behavior on width { NumberAnimation { duration: 500; easing.type: Easing.InOutQuad } }
    }

    Rectangle {
        color:"green"
        anchors.left: parent.left
        height: parent.height
        width: parent.width*val/max
        opacity: isHorizontal ? 1 : 0
        Behavior on width { NumberAnimation { duration: 500; easing.type: Easing.InOutQuad } }
    }

    Text {
        text: _valueStr
        color: "#ffffff"
        font { pixelSize: 10 }
        anchors { centerIn: parent }
        opacity: showLabel ? 1 : 0
    }

}
