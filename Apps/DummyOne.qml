import Qt 4.7

Rectangle {
    id: app
    color: "#ffffff"
    anchors.fill: parent

    property string title: "Dummy Application"
    property bool shown: false
    property alias text: appText.text

    onShownChanged: {
        if (shown) header.breadcrumb.addItem(app.title);
        else header.breadcrumb.removeLastItem();
    }

    Rectangle {
        color: "#cccccc"
        width: 30; height: 30
        anchors { top: parent.top; right: parent.right }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                shown = false;
                app.destroy();
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
}
