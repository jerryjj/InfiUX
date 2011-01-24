import Qt 4.7

Item {
    //anchors { verticalCenter: parent }

    property alias label: _label.text

    Text {
        id: _label
        color: "#ffffff"
        text: ""
    }

}
