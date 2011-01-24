import Qt 4.7

Rectangle {
    id: app
    color: "#ffffff"
    anchors.fill: parent

    property bool shown: false
    property alias text: appText.text


    Rectangle {
        color: "#cccccc"
        width: 20; height: 20
        anchors { top: parent.top; right: parent.right }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                app.destroy();
            }
        }

        Text {
            anchors.centerIn: parent
            text: "X"
        }
    }

    Text {
        id: appText
        anchors.centerIn: parent
        text: "Dummy application"
    }
}
