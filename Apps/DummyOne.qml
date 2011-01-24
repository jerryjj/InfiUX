import Qt 4.7

Rectangle {
    id: app
    color: "#ffffff"
    anchors.fill: parent
    opacity: 0
    scale: 0

    property string title: "Dummy Application"
    property bool open: false
    property alias text: appText.text

    onOpenChanged: {
        if (open) header.breadcrumb.addItem(app.title);
        else header.breadcrumb.removeLastItem();
    }

    Rectangle {
        color: "#cccccc"
        width: 30; height: 30
        anchors { top: parent.top; right: parent.right }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                open = false;
                app.destroy(500);
            }
        }

        Text {
            anchors.centerIn: parent
            text: "X"
            font { pixelSize: 20; bold: true }
        }
    }

    Text {
        id: appText
        anchors.centerIn: parent
        text: "Dummy application"
    }

    states: [
        State {
            name: "opened"; when: app.open
            PropertyChanges { target: app; opacity: 1 }
            PropertyChanges { target: app; scale: 1 }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation { properties: "opacity,scale"; duration: 500; easing.type: Easing.InOutQuad }
        }
    ]
}
