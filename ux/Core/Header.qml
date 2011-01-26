import Qt 4.7

import "../Common/" 1.0 as Common

Rectangle {
    id: wrapper
    z: 60000

    color: "#e75012"
    property string borderImagePath: "../img/header.sci"
    default property alias breadcrumb: p_breadcrumb

    BorderImage { source: borderImagePath; width: parent.width; height: parent.height }

    Connections {
        target: parent
        onPanelOpen: {
            arrow.state = "up";
        }
        onPanelClose: {
            arrow.state = "down";
        }
    }

    Text {
        id: title
        width: 50
        anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }

        text: "InfiUX"
        color: "#ffffff"
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

    Item {
        id: arrow
        state: "down"
        width: 48; height: 34
        anchors.centerIn: parent

        Image {
            id: img
            anchors.fill: parent
            source: "../img/header-arrow-down.png"
        }

        states: [
            State {
                name: "down"
                PropertyChanges { target: img; rotation: 0 }
            },
            State {
                name: "up"
                PropertyChanges { target: img; rotation: -180 }
            }
        ]
        transitions: [
            Transition {
                NumberAnimation { properties: "rotation"; duration: 500; easing.type: Easing.InOutSine }
            }
        ]

    }

    Image {
        width: 22; height: 22
        anchors { right: batteryGauge.left; rightMargin: 5; verticalCenter: wrapper.verticalCenter }
        source: "../img/icons/battery.png"
    }

    Common.BarGauge {
        id: batteryGauge
        width: 50; height: 15
        anchors { right: clock.left; rightMargin: 20; verticalCenter: wrapper.verticalCenter }
        isHorizontal: true
        showLabel: true
        val: 45

        property bool charging: false
        onChargingChanged: {
            if (batteryGauge.charging) batteryGauge.overwriteLabel('Charge');
        }

        //Dummy tester
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (batteryGauge.val < batteryGauge.max) batteryGauge.val = batteryGauge.val + 15;
                else {
                    if (!batteryGauge.charging) batteryGauge.charging = true;
                    else batteryGauge.val = 0;
                }

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
