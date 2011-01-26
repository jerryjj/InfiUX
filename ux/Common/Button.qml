import Qt 4.7

Rectangle {
    property string icon: ''
    property alias text: label.text
    property bool toggleable: false
    property bool toggled: false
    signal clicked

    id: button
    width: 90; height: 90
    //border.color: palette.mid
    radius: 15

    gradient: Gradient {
        GradientStop { id: gradientStop1; position: 0.0; color: Qt.lighter(palette.button) }
        GradientStop { id: gradientStop2; position: 1.0; color: palette.button }
    }

    Image {
        id: buttonIcon
        anchors.centerIn: parent
        source: icon
        opacity: icon != '' ? 1 : 0
    }

    Text {
        id: label
        anchors.centerIn: parent
        color: palette.buttonText
        opacity: icon != '' ? 0 : 1
    }

    MouseArea {
        id: clickRegion
        anchors.fill: parent
        onClicked: {
            button.clicked();
            if (!button.toggleable) return;
            button.toggled ? button.toggled = false : button.toggled = true
        }
    }

    states: [
        State {
            name: "Pressed"; when: clickRegion.pressed == true
            PropertyChanges { target: gradientStop1; color: palette.dark }
            PropertyChanges { target: gradientStop2; color: palette.button }
        },
        State {
            name: "Toggled"; when: button.toggled == true
            PropertyChanges { target: gradientStop1; color: palette.dark }
            PropertyChanges { target: gradientStop2; color: palette.button }
        }
    ]
}
