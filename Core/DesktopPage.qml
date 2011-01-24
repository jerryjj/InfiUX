import Qt 4.7

Item {
    width: ui.width; height: 565

    default property alias content: widgetStack.children

    Item {
        id: widgetStack
        anchors.fill: parent
    }
}
