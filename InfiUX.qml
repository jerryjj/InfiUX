import Qt 4.7

import "Core" 1.0 as Core
import "Common" 1.0 as Common

import "Core/applicationOpener.js" 1.0 as AppOpener
import "Core/notifications.js" 1.0 as Notifications

Item {
    id: ui
    width: 1024; height: 600

    //Just dummy way to test OSD
    focus: true
    Keys.onEscapePressed: {
        mainOSD.opacity = !mainOSD.opacity;
    }

    SystemPalette { id: palette }

    MouseArea {
        anchors.fill: parent
        onClicked: ui.focus = false;
    }

    Component.onCompleted: {
        //console.log(mainWidget.getConfigValue("main/loglevel").toString());
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

        Core.DesktopPage {
            id: pageOne

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

        Core.DesktopPage {
            id: pageTwo

            Rectangle {
                color: "#ffffff"
                width: 100; height: 100
                anchors.centerIn: parent

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        notifications.addInfo({text: "Hello, World!"});
                        AppOpener.open("DummyOne", {color: "#ffffff", title: "Dummy app 1", text: "Dummy app 1"});
                    }
                }
            }
        }

        Core.DesktopPage {
            id: pageThree

            Rectangle {
                color: "#444444"
                width: 100; height: 100
                x: 245; y: 80

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        notifications.addError({text: "Hello, World! We have ERROR!"});
                        AppOpener.open("DummyOne", {color: "#444444", title: "Dummy app 3", text: "Dummy app 3"});
                    }
                }
            }
        }
    }

    Item {
        id: applicationHolder
        anchors { top: header.bottom; bottom: desktop.bottom; left: desktop.left; right: desktop.right }
    }

    Item {
        id: notifications
        width: ui.width; height: 30
        anchors { top: header.bottom }

        function addInfo(props)
        {
            props = props || {};
            props.type = "info";

            Notifications.newItem(props);
        }

        function addError(props)
        {
            props = props || {};
            props.type = "error";

            Notifications.newItem(props);
        }

        function showNext() { Notifications.showNext(); }

        Component.onCompleted: {
            Notifications.registerHolder(notifications);
        }
    }

    Core.OSD {
        id: mainOSD
        anchors.fill: ui
        opacity: 0

        items: [
            Common.Button {
                text: "Cancel"
                onClicked: {
                    console.log("cancel");
                    mainOSD.opacity = 0;
                }
            },

            Common.Button {
                text: "Sleep"
                onClicked: {
                    console.log("sleep");
                }
            },

            Common.Button {
                text: "Shutdown"
                onClicked: {
                    console.log("shutdown");
                    mainWidget.exitApplication();
                }
            }
        ]
    }

}
