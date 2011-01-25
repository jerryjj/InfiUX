import Qt 4.7

Item {
    id: wrapper

    property alias background: background.source
    property alias currentIndex: list.currentIndex

    default property alias content: visualModel.children

    function activateEditMode() {
        list.interactive = false;
        console.log("activateEditMode");
    }

    function deactivateEditMode() {
        list.interactive = true;
        console.log("deactivateEditMode");
    }

    function getLeftIndex() {
        console.log("getLeftIndex "+(currentIndex - 1));
        return currentIndex - 1 >= 0 ? currentIndex - 1 : currentIndex;
    }
    function getRightIndex() {
        console.log("getRightIndex "+(currentIndex + 1));
        return currentIndex + 1 <= list.count-1 ? currentIndex + 1 : currentIndex;
    }

    function moveLeft() {
        console.log("Desktop moveLeft");
        list.moveLeft();
    }

    function moveRight() {
        console.log("Desktop moveRight");
        list.moveRight();
    }

    Image {
        id: background
        fillMode: Image.TileHorizontally

        //x: -list.contentX / 2
        width: Math.max(list.contentWidth, parent.width)
    }

    ListView {
        id: list
        anchors.fill: parent

        function moveLeft() {
            if (currentIndex == 0) return;
            currentIndex -= 1;
        }
        function moveRight() {
            if (currentIndex+1 > count-1) return;
            currentIndex += 1;
        }

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
