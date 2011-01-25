import Qt 4.7

Rectangle {
    id: wrapper
    color:"#00000000"
    border.color: "#ffffff"

    property int val:0
    property int max:100

    property string _valueStr: "0 %"

    property bool isHorizontal: false
    property bool showLabel: false

    property bool dynamicColors: true
    property string okColor: "green"
    property string warningColor: "orange"
    property string dangerColor: "red"
    property int okLimit: 70;
    property int dangerLimit: 25;

    function overwriteLabel(content) {
        _valueStr = content;
    }

    onValChanged: {
        if (val > max) val = max;
        _valueStr = val + " %";

        bar.updateValue(val);
    }

    Component.onCompleted: {
        bar.initialize();
        bar.updateValue(val);
    }

    Rectangle {
        id: bar
        color: okColor
        anchors { left: wrapper.left; leftMargin: wrapper.border.width }

        function initialize() {
            if (isHorizontal) {
                bar.height = parent.height - wrapper.border.width;
                bar.anchors.top = wrapper.top;
                bar.anchors.topMargin = wrapper.border.width;
            } else {
                bar.anchors.bottom = wrapper.bottom;
                bar.anchors.bottomMargin = wrapper.border.width;
                bar.width = wrapper.width - wrapper.border.width;
            }
        }

        function updateValue(val) {
            if (dynamicColors) {
                if (val >= okLimit) bar.color = okColor;
                else if (val <= dangerLimit) bar.color = dangerColor;
                else bar.color = warningColor;
            }

            if (isHorizontal) {
                bar.width = (parent.width*val/max) - (val > 0 ? wrapper.border.width : 0);
            } else {
                bar.height = (wrapper.height * val/max) - (val > 0 ? wrapper.border.width : 0);
            }
        }

        Behavior on height { NumberAnimation { duration: 500; easing.type: Easing.InOutQuad } }
        Behavior on width { NumberAnimation { duration: 500; easing.type: Easing.InOutQuad } }
        Behavior on color { ColorAnimation { duration: 500 } }

    }

    Text {
        text: _valueStr
        color: "#ffffff"
        font { pixelSize: 10 }
        anchors { centerIn: parent }
        opacity: showLabel ? 1 : 0
    }

}
