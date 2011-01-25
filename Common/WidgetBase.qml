import Qt 4.7

Item {
    id: widget

    default property alias content: layout.children

    property int pageIndex: parent.parent.desktopIndex

    property bool editMode: false
    property bool isDragged: false

    property bool p_changingDesktop: false

    scale: 1

    Connections {
        target: parent.parent
        onOpenEditMode: {
            editMode = true;
        }
        onCloseEditMode: {
            editMode = false;
        }
    }

    Item {
        id: layout
        anchors.fill: parent
    }

    Item {
        id: editTools
        opacity: 0
        anchors.fill: parent

        MouseArea {
            id: editMouseArea
            anchors.fill: parent

            drag.target: widget
            drag.axis: Drag.XandYAxis
            drag.minimumY: 0; drag.minimumX: 0
            drag.maximumY: widget.parent.height - widget.height
            drag.maximumX: widget.parent.width - widget.width

            onPressed: {
                widget.isDragged = true;
            }

            onReleased: {
                console.log("D'n'D released. save coordinates!");
                widget.isDragged = false;
            }
            onPositionChanged: {
                if (p_changingDesktop) return;
                //TODO: When switching desktop clone widget to other desktop
                if (widget.x <= 0) {
                    var idx = desktop.getLeftIndex();
                    if (idx != widget.pageIndex) {
                        widget.p_changingDesktop = true;
                        desktop.moveLeft();
                    }
                }
                if (widget.x + widget.width >= ui.width) {
                    var idx = desktop.getRightIndex();
                    if (idx != widget.pageIndex) {
                        widget.p_changingDesktop = true;
                        desktop.moveRight();
                    }
                }
            }
        }

        Rectangle {
            color: "#cccccc"
            width: 30; height: 30
            anchors { bottom: parent.top; bottomMargin: -15; left: parent.right; leftMargin: -15 }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("destroy widget");
                }
            }

            Text {
                anchors.centerIn: parent
                text: "X"
                font { pixelSize: 20; bold: true }
            }
        }

    }

    states: [
        State {
            name: "editMode"; when: widget.editMode
            PropertyChanges { target: editTools; opacity: 1 }
        },
        //TODO: Find out why this state never gets activated
        State {
            name: "inDrag"; extend: "editMode"; when: editMouseArea.drag.active //widget.isDragged
            PropertyChanges { target: editTools; scale: 1.2 }
        }

    ]

    transitions: [
        Transition {
            NumberAnimation { properties: "opacity,scale"; duration: 500; easing.type: Easing.OutBack }
        }
    ]
}
