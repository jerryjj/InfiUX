import Qt 4.7

import "../Common/" 1.0 as Common

Rectangle {
    id: wrapper

    color: "#e75012"
    property string borderImagePath: "../img/header.sci"
    default property alias breadcrumb: p_breadcrumb

    BorderImage { source: borderImagePath; width: parent.width; height: parent.height }

    Text {
        id: title
        width: 50
        anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }
        color: "#ffffff"

        text: "InfiUX"
        font { pixelSize: 14; bold: true }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("Title clicked");
            }
        }
    }

    Breadcrumb {
        id: p_breadcrumb
        height: title.height
        anchors { left: title.right; leftMargin: 10; verticalCenter: title.verticalCenter }
    }

    Common.BarGauge {
        id: batteryGauge
        width: 50; height: 15
        anchors { right: clock.left; rightMargin: 20; verticalCenter: wrapper.verticalCenter }
        isHorizontal: true
        showLabel: true
        val: 45

        //Dummy tester
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (batteryGauge.val < batteryGauge.max) batteryGauge.val = batteryGauge.val + 15;
                else batteryGauge.val = 0;
            }
        }
    }

    Common.Datetime {
        id: clock

        width: clockContent.width; height: title.height
        anchors { right: wrapper.right; rightMargin: 10; verticalCenter: wrapper.verticalCenter }

        Text {
            id: clockContent
            color: "#ffffff"
            text: clock.formatted
        }
    }
}
