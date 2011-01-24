import Qt 4.7

Item {
    id: wrapper

    property alias background: background.source
    property alias currentIndex: list.currentIndex

    default property alias content: visualModel.children

    Image {
        id: background
        fillMode: Image.TileHorizontally

        //x: -list.contentX / 2
        width: Math.max(list.contentWidth, parent.width)
    }

    ListView {
        id: list
        anchors.fill: parent

        currentIndex: wrapper.currentIndex
        onCurrentIndexChanged: wrapper.currentIndex = currentIndex

        orientation: Qt.Horizontal
        boundsBehavior: Flickable.DragOverBounds
        model: VisualItemModel { id: visualModel }

        highlightMoveDuration: 400
        highlightRangeMode: ListView.StrictlyEnforceRange
        snapMode: ListView.SnapOneItem

        Component.onCompleted: positionViewAtIndex(Math.round(count/2)-1, ListView.Beginning)
    }

    ListView {
        id: pager

        height: 50
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: Math.min(count * 50, parent.width - 20)
        interactive: width == parent.width - 20
        orientation: Qt.Horizontal

        currentIndex: wrapper.currentIndex
        onCurrentIndexChanged: wrapper.currentIndex = currentIndex

        model: visualModel.children

        highlight: Component {
            Item {
                width: 37; height: 37

                Image {
                    source: "../img/pager-ring-indicator.png"
                    anchors.fill: parent
                    smooth: true
                }
            }
        }

        delegate: Item {
            width: 37; height: 37
            id: delegateRoot

            Image {
                id: image
                source: "../img/pager-ring.png"
                smooth: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: { wrapper.currentIndex = index }
            }

            transitions: Transition {
                NumberAnimation { properties: "x"; duration: 200 }
            }

        }


    }
}
