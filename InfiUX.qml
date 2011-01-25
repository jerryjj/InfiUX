import Qt 4.7

import "Core" 1.0 as Core
import "Common" 1.0 as Common

import "Core/notifications.js" 1.0 as Notifications
import "widgets" 1.0

import InfiUX.DeviceInfo 1.0

Item {
    id: ui

    DeviceInfo {
        id: deviceInfo
    }

    width: deviceInfo.screenX; height: deviceInfo.screenY

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

    Core.TopPanel {
        id: topPanel
        width: ui.width; height: ui.height
        y: -(ui.height - 35)
    }

    Core.Desktop {
        id: desktop
        width: ui.width; height: ui.height - 35
        clip: true
        anchors { top: topPanel.bottom }

        background: "backgrounds/default.png"

        Core.DesktopPage {
            id: pageOne
            desktopIndex: 0
            ApplicationLauncher {
                id: appLTwo
                module: "DummyOne"

                //TODO: This is ugly. This will change when these are implemented in C++
                function getProperties() {
                    return {color: "#3c3c3c", title: "Dummy app 2", text: "Dummy app 2"};
                }

                x: 120; y: 300

                Rectangle {
                    function prepareEditMode() {
                        console.log("prepareEditMode");
                    }

                    color: "#3c3c3c"
                    anchors.fill: parent
                }
            }
        }

        Core.DesktopPage {
            id: pageTwo
            desktopIndex: 1

            ApplicationLauncher {
                id: appLOne
                module: "DummyOne"
                function getProperties() {
                    return {color: "#ffffff", title: "Dummy app 1", text: "Dummy app 1"};
                }

                x: 300; y: 200

                onOpened: {
                    notifications.addInfo({text: "Hello, World!"});
                }

                Rectangle {
                    function prepareEditMode() {
                        console.log("prepareEditMode");
                    }

                    color: "#ffffff"
                    anchors.fill: parent
                }
            }
        }

        Core.DesktopPage {
            id: pageThree
            desktopIndex: 2

            ApplicationLauncher {
                id: appLThree
                module: "DummyOne"
                function getProperties() {
                    return {color: "#444444", title: "Dummy app 3", text: "Dummy app 3"};
                }

                x: 245; y: 80

                onOpened: {
                    notifications.addError({text: "Hello, World! We have ERROR!"});
                }

                Rectangle {
                    color: "#444444"
                    anchors.fill: parent
                }
            }
        }
    }

    Item {
        id: applicationHolder
        anchors { top: topPanel.bottom; bottom: desktop.bottom; left: desktop.left; right: desktop.right }
    }

    Item {
        id: notifications
        width: ui.width; height: 30
        anchors { top: ui.top }

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
