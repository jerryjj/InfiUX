import Qt 4.7

Item {
    id: wrapper
    anchors.fill: parent

    property bool active: false
    property int idx: 0
    property string type: "info"
    property bool sticky: false

    property alias text: content.text

    onTypeChanged: {
        if (type == "error") sticky = true;
    }

    onActiveChanged: {
        if (!active) wrapper.destroy(500);
    }

    Timer {
        id: timer
        interval: 5000
        repeat: false; running: !sticky
        onTriggered: notifications.showNext();
    }


    MouseArea {
        anchors.fill: parent
        onClicked: {
            notifications.showNext();
        }
    }

    Rectangle {
        id: item
        color: "yellow"
        anchors.fill: parent
        y: -parent.height
        opacity: 0

        Text {
            id: content
            color: "#000000"
            anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
            text: ""
        }
    }

    states: [
        State {
            name: "visible"; when: wrapper.active
            PropertyChanges { target: item; opacity: 1 }
            PropertyChanges { target: item; y: 0 }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation { properties: "opacity,y"; duration: 500; easing.type: Easing.InOutQuad }
        }
    ]
}
