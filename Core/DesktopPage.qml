import Qt 4.7

Item {
    id: wrapper

    width: ui.width; height: 565

    default property alias content: widgetStack.children    
    property bool editMode: false
    property int desktopIndex: 0

    signal openEditMode
    signal closeEditMode

    onEditModeChanged: {
        if (editMode) {
            desktop.activateEditMode();
            openEditMode();
        } else {
            desktop.deactivateEditMode();
            closeEditMode();
        }
    }

    MouseArea {
        anchors.fill: parent
        onPressAndHold: {
            if (wrapper.editMode) wrapper.editMode = false;
            else wrapper.editMode = true;
        }
    }

    Item {
        id: widgetStack
        anchors.fill: parent
    }
}
