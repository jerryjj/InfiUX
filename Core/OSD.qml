import Qt 4.7

Item {
    id: wrapper
    anchors.fill: parent
    z: 60500

    property alias items: itemsRow.children

    MouseArea {
        anchors.fill: parent
        onClicked: ui.focus = false;
    }

    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.8
    }

    Row {
        id: itemsRow
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10
    }
}
