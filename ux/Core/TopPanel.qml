import Qt 4.7

import "../Common" 1.0 as Common

Item {
    id: wrapper

    property bool _panel_moving: false
    property bool _panel_open: false
    property bool _header_drag_started: false

    signal panelOpen
    signal panelClose

    Header {
        id: header
        width: ui.width; height: 35
        y: wrapper.height - 35
    }

    Item {
        id: content

        anchors.fill: parent

        Rectangle {
            id: listing
            anchors { top: parent.top; bottom: parent.bottom }
            width: parent.width * 0.6
            color: "#444444"

            Text {
                text: "Application, etc listing here"
                anchors.centerIn: parent
            }
        }

        Rectangle {
            id: processes
            anchors { left: listing.right; right: parent.right; top: parent.top; bottom: parent.bottom }
            color: "#333333"

            Text {
                text: "Minimized & background processes here"
                anchors.centerIn: parent
            }
        }
    }

    MouseArea {
        id: panelOpenerMA
        anchors.fill: header

        /*onDoubleClicked: {
            wrapper._panel_moving = true;
            if (wrapper._panel_open) wrapper._panel_open = false;
            else wrapper._panel_open = true;
        }*/

        onReleased: {
            wrapper._panel_moving = true;
            if (wrapper._header_drag_started) {
                if (wrapper._panel_open) {
                    wrapper._panel_open = false;
                    panelClose();
                }
                else {
                    wrapper._panel_open = true;
                    panelOpen();
                }
                wrapper._header_drag_started = false;
            }
        }
        onPositionChanged: {
            wrapper._header_drag_started = true;
        }
    }

    states: [
        State {
            name: "openPanel"; when: wrapper._panel_open
            PropertyChanges { target: wrapper; y: 0 }
            PropertyChanges { target: wrapper; _panel_moving: false }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation { properties: "y"; duration: 500; easing.type: Easing.InOutSine }
        }
    ]
}
