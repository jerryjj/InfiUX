import Qt 4.7

import "Core" 1.0 as Core
import "Common" 1.0 as Common

import "Core/notifications.js" 1.0 as Notifications
import "widgets" 1.0

import InfiUX.DeviceInfo 1.0
//import InfiUX.Keyboard 1.0

Item {
    id: ui

    DeviceInfo {
        id: deviceInfo
    }

    property alias keyboard: virtualKeyboard

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
        //keyboard.is_open = true;

        browser.createObject(testBrowser);
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

            Item {
                id: testBrowser
                anchors.fill: parent
                Component.onCompleted: {
                    desktop.deactivateListScroll(0);
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
                text: "Reboot"
                onClicked: {
                    console.log("reboot");
                    mainWidget.exitApplication();
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

    Common.Keyboard {
        id: virtualKeyboard
        objectName: "keyboard"
        anchors { left: ui.left; right: ui.right; bottom: ui.bottom }
    }

}
