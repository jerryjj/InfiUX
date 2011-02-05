import Qt 4.7

Item {
    id: wrapper

    width: ui.width; height: 565

    default property alias content: widgetStack.children    
    property bool editMode: false
    property int desktopIndex: 0

    property string iconPrefix: "../img/desktop-icon-"
    property string iconName: "default"

    /*signal openEditMode
    signal closeEditMode

    onEditModeChanged: {
        if (editMode) {
            openEditMode();
        } else {
            closeEditMode();
        }
    }*/

    Connections {
        target: desktop
        onEditModeActivated: {
            wrapper.editMode = true;
        }
        onEditModeDeactivated: {
            wrapper.editMode = false;
        }
    }

    MouseArea {
        anchors.fill: parent
        onPressAndHold: {
            wrapper.editMode = !wrapper.editMode;
            if (wrapper.editMode) {
                desktop.editModeActivated();
            } else {
                desktop.editModeDeactivated();
            }
        }
    }

    Item {
        id: widgetStack
        anchors.fill: parent
    }
}
