import Qt 4.7

Rectangle {
    id: wrapper

    color: "#e75012"
    property string borderImagePath: "../img/header.sci"

    BorderImage { source: borderImagePath; width: parent.width; height: parent.height }
}
