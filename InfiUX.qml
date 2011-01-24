import Qt 4.7

import "Core" 1.0 as Core

import "Core/applicationOpener.js" 1.0 as AppOpener

Item {
    id: ui
    width: 1024; height: 600

    MouseArea {
        anchors.fill: parent
        onClicked: ui.focus = false;
    }


    Core.Header {
        id: header
        width: parent.width; height: 35
    }

    Core.Desktop {
        id: desktop
        width: ui.width; height: 565
        clip: true
        anchors { top: header.bottom }

        background: "backgrounds/default.png"

        Item {
            width: ui.width; height: 565

            Rectangle {
                color: "#3c3c3c"
                width: 100; height: 100
                x: 120; y: 300

                MouseArea {
                    anchors.fill: parent
                    onClicked: AppOpener.open("DummyOne", {color: "#3c3c3c", title: "Dummy app 2", text: "Dummy app 2"});
                }
            }
        }

        Item {
            width: ui.width; height: 565

            Rectangle {
                color: "#ffffff"
                width: 100; height: 100
                anchors.centerIn: parent

                MouseArea {
                    anchors.fill: parent
                    onClicked: AppOpener.open("DummyOne", {color: "#ffffff", title: "Dummy app 1", text: "Dummy app 1"});
                }
            }
        }

        Item {
            width: ui.width; height: 565

            Rectangle {
                color: "#444444"
                width: 100; height: 100
                x: 245; y: 80

                MouseArea {
                    anchors.fill: parent
                    onClicked: AppOpener.open("DummyOne", {color: "#444444", title: "Dummy app 3", text: "Dummy app 3"});
                }
            }
        }
    }

    Item {
        id: applicationHolder

        anchors { top: header.bottom; bottom: desktop.bottom; left: desktop.left; right: desktop.right }


    }
}
