import Qt 4.7

import "../Common" 1.0 as Common

Item {
    id: wrapper
    z: 1

    property alias background: background.source
    property alias currentIndex: list.currentIndex

    property int scroll_disabled_on: -1;

    property bool editModeActive: false

    default property alias content: visualModel.children

    signal editModeActivated
    signal editModeDeactivated

    onEditModeActivated: {
        editModeActive = true;
        list.interactive = false;
        editToolbar.state = "open";
        console.log("onEditModeActivated");
    }
    onEditModeDeactivated: {
        editModeActive = false;
        list.interactive = true;
        editToolbar.state = "";
        console.log("onEditModeDeactivated");
    }

    function deactivateListScroll(for_page_idx) {
        scroll_disabled_on = for_page_idx;
        console.log("deactivateListScroll "+for_page_idx);
    }

    function activateEditMode() {
        editModeActivated();
    }

    function deactivateEditMode() {
        editModeDeactivated();
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
        z: 2

        function moveLeft() {
            if (currentIndex == 0) return;
            currentIndex -= 1;
        }
        function moveRight() {
            if (currentIndex+1 > count-1) return;
            currentIndex += 1;
        }

        currentIndex: wrapper.currentIndex
        onCurrentIndexChanged: {
            list.interactive = true;
            wrapper.currentIndex = currentIndex
            if (!list.moving) {
                if (scroll_disabled_on == currentIndex) {
                    list.interactive = false;
                }
            }
        }
        onFlickEnded: {
            list.interactive = true;
            if (scroll_disabled_on == currentIndex) {
                list.interactive = false;
            }
        }

        orientation: Qt.Horizontal
        boundsBehavior: Flickable.DragOverBounds
        model: VisualItemModel { id: visualModel }

        highlightMoveDuration: 400
        highlightRangeMode: ListView.StrictlyEnforceRange
        snapMode: ListView.SnapOneItem

        Component.onCompleted: positionViewAtIndex(Math.round(count/2)-1, ListView.Beginning)
    }

    Item {
        id: editToolbar
        height: 63
        anchors { left: parent.left; bottom: parent.bottom; right: parent.right }
        z: 3

        Image {
            id: editButton
            width: 41; height: 41
            anchors { left: parent.left; leftMargin: 10; bottom: parent.bottom; bottomMargin: 10 }
            source: "../img/desktop-edit-icon.png"
            smooth: true
            z: 4

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (editModeActive) {
                        deactivateEditMode();
                    } else {
                        activateEditMode();
                    }
                }
            }
        }

        Item {
            id: content
            //y: ui.height
            width: parent.width; height: 63
            opacity: 0

            Image {
                anchors.fill: parent
                source: "../img/desktop-edit-bar.png"
            }

            Row {
                anchors { left: parent.left; leftMargin: editButton.width + 10; right: parent.right; top: parent.top; bottom: parent.bottom }

                Item {
                    width: 120; height: content.height

                    Text {
                        color: "#fff"
                        anchors.centerIn: parent
                        text: "Add widget"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("Add wgt");
                        }
                    }
                }

                Item {
                    width: 120; height: content.height

                    Text {
                        color: "#fff"
                        anchors.centerIn: parent
                        text: "Add desktop"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("Add dsk");
                        }
                    }
                }

                Item {
                    width: 120; height: content.height

                    Text {
                        color: "#fff"
                        anchors.centerIn: parent
                        text: "Remove desktop"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("del dsk");
                        }
                    }
                }

            }
        }

        states: [
            State {
                name: "open"
                PropertyChanges { target: editButton; source: "../img/desktop-edit-icon-active.png" }
                //PropertyChanges { target: content; y: ui.height - editToolbar.height; opacity: 1 }
                PropertyChanges { target: content; opacity: 1 }
            }
        ]
        transitions: [
            Transition {
                NumberAnimation { properties: "opacity,y"; duration: 500; easing.type: Easing.InOutSine }
            }
        ]
    }

    ListView {
        id: pager
        z: 3
        width: Math.min(count * 50, parent.width)
        height: 50
        anchors { bottom: parent.bottom; right: parent.right }

        interactive: width == parent.width
        orientation: Qt.Horizontal

        currentIndex: wrapper.currentIndex
        onCurrentIndexChanged: wrapper.currentIndex = currentIndex

        model: visualModel.children

        highlight: Component {
            Item {
                width: 45; height: 41
                z: 4

                Image {
                    source: pager.currentItem.getIconPath(true)
                    smooth: true
                }                
            }
        }

        delegate: Item {
            width: 45; height: 41
            id: delegateRoot

            property string origIconPrefix: iconPrefix
            property string origIconName: iconName

            function getIconPath(active) {
                var path = origIconPrefix + origIconName;
                if (active) path += "-active";
                return path + ".png"
            }

            Image {
                id: image
                source: getIconPath()
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
