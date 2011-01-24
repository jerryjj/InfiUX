import Qt 4.7

Rectangle {
    id: wrapper

    color: "#e75012"
    property string borderImagePath: "../img/header.sci"
    default property alias breadcrumb: _breadcrumb

    BorderImage { source: borderImagePath; width: parent.width; height: parent.height }

    Text {
        id: title
        width: 50
        anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }
        color: "#ffffff"

        text: "InfiUX"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("Title clicked");
            }
        }
    }

    Breadcrumb {
        id: _breadcrumb
        height: title.height
        anchors { left: title.right; leftMargin: 10; verticalCenter: title.verticalCenter }
    }
}
