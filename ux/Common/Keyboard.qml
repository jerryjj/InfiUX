import Qt 4.7

Item {
    id: wrapper
    height: 0
    opacity: 0
    z: 10

    property bool is_open: false
    property int row_height: 75
    property int row_spacing: 10
    property int button_spacing: 5

    property bool shiftToggle: false
    property bool capsToggle: false
    property bool symbolsToggle: false

    property alias text: textContent.text

    signal show;
    signal hide;
    signal toggleShift;
    signal toggleCaps;
    signal toggleSymbols;
    signal changeLayout(string layout); //layout can be "normal", "shifted", "symbols", "shifted_symbols"
    signal virtualKeyClicked(string action, int code);

    onShow: {
        textContent.text = "";
        keyboard.is_open = true;
    }
    onHide: {
        keyboard.is_open = false;
    }
    onToggleShift: {
        shiftToggle = !shiftToggle;
    }
    onToggleCaps: {
        capsToggle = !capsToggle;
    }
    onToggleSymbols: {
        symbolsToggle = !symbolsToggle;
    }
    onVirtualKeyClicked: {
        if (code != Qt.Key_Shift) {
            if (shiftToggle) {
                shiftToggle = false;
            }
        }
    }

    function useShifted() {
        if (shiftToggle || capsToggle) return true;
        return false;
    }

    /*XmlListModel {
        id: layoutModel
        source: "qrc:/data/keyboard/fi_FI.xml"
        query: "/layout/normal/row"
    }

    Item {
        id: buttonModel

        property int row: 1
        property alias status: xmlModel.status
        property variant model: xmlModel

        onRowChanged: {
            xmlModel.query = "/layout/normal/row["+row+"]/button";
        }

        XmlListModel {
            id: xmlModel
            source: "qrc:/data/keyboard/fi_FI.xml"
            query: ""

            onStatusChanged: {
                console.log("buttonModel status changed: "+status);
            }

            XmlRole { name: "value"; query: "string()"; isKey: true }
            XmlRole { name: "type"; query: "button/@type/string()" }
            XmlRole { name: "action"; query: "button/@action/string()" }
            XmlRole { name: "code"; query: "button/@code/number()" }
        }
    }

    function getButtonModel(index) {
        console.log("getButtonModel "+index);
        buttonModel.row = index+1;
        return buttonModel.model;
    }*/

    Rectangle {
        id: background
        color: "#000000"
        opacity: 0.7
        anchors.fill: keyboard
    }

    Rectangle {
        id: textContentHolder
        color: "#fff"
        height: 30
        anchors { left: parent.left; right: parent.right; top: parent.top }
        anchors.margins: 10

        Text {
            id: textContent
            anchors.fill: parent

            text: ""
            color: "#000"
            font { pixelSize: 20 }
        }
    }

    Column {
        id: buttonRows
        anchors { left: parent.left; right: parent.right; top: textContentHolder.bottom; topMargin: 5 }
        spacing: row_spacing

        /*Repeater {
            id: rowRepeater
            model: layoutModel
            anchors { horizontalCenter: parent.horizontalCenter }

            delegate: Component {
                Row {
                    height: row_height
                    spacing: button_spacing

                    Repeater {
                        id: buttonRepeater
                        model: getButtonModel(index)

                        delegate: Component {
                            KeyboardButton {
                                value: value
                                code: code
                                type: type
                                action: action
                            }
                        }
                    }
                }
            }
        }*/


        Row {
            id: row1
            height: row_height
            spacing: button_spacing
            anchors { horizontalCenter: parent.horizontalCenter }

            KeyboardButton {
                id: btn_q
                value: "q"
                shifted_value: "Q"
                symbols_value: "1"
                shifted_symbols_value: "!"
            }
            KeyboardButton {
                id: btn_w
                value: "w"
                shifted_value: "W"
                symbols_value: "2"
                shifted_symbols_value: '"'
                shifted_symbols_code: Qt.Key_QuoteDbl
            }
            KeyboardButton {
                id: btn_e
                value: "e"
                shifted_value: "E"
                symbols_value: "3"
                shifted_symbols_value: '#'
                shifted_symbols_code: Qt.Key_ssharp
            }
            KeyboardButton {
                id: btn_r
                value: "r"
                shifted_value: "R"
                symbols_value: "4"
                shifted_symbols_value: '€'
            }
            KeyboardButton {
                id: btn_t
                value: "t"
                shifted_value: "T"
                symbols_value: "5"
                shifted_symbols_value: "%"
            }
            KeyboardButton {
                id: btn_y
                value: "y"
                shifted_value: "Y"
                symbols_value: "6"
                shifted_symbols_value: "&"
            }
            KeyboardButton {
                id: btn_u
                value: "u"
                shifted_value: "U"
                symbols_value: "7"
                shifted_symbols_value: "/"
            }
            KeyboardButton {
                id: btn_i
                value: "i"
                shifted_value: "I"
                symbols_value: "8"
                shifted_symbols_value: "("
            }
            KeyboardButton {
                id: btn_o
                value: "o"
                shifted_value: "O"
                symbols_value: "9"
                shifted_symbols_value: ")"
            }
            KeyboardButton {
                id: btn_p
                value: "p"
                shifted_value: "P"
                symbols_value: "0"
                shifted_symbols_value: "="
            }
            KeyboardButton {
                id: btn_oring
                value: "\u00E5"
                code: Qt.Key_Aring
                shifted_value: "\u00E5".toUpperCase()
                symbols_value: "+"
                shifted_symbols_value: "?"
            }
            KeyboardButton {
                id: btn_backspace
                value: "<-"
                code: Qt.Key_Backspace
                type: "backspace"
                symbols_value: "<-"
                symbols_code: Qt.Key_Backspace
                shifted_symbols_value: "<-"
                shifted_symbols_code: Qt.Key_Backspace
            }
        }

        Row {
            id: row2
            height: row_height
            anchors { horizontalCenter: parent.horizontalCenter }
            spacing: button_spacing

            KeyboardButton {
                id: btn_a
                value: "a"
                shifted_value: "A"
            }
            KeyboardButton {
                id: btn_s
                value: "s"
                shifted_value: "S"
            }
            KeyboardButton {
                id: btn_d
                value: "d"
                shifted_value: "D"
            }
            KeyboardButton {
                id: btn_f
                value: "f"
                shifted_value: "F"
            }
            KeyboardButton {
                id: btn_g
                value: "g"
                shifted_value: "G"
            }
            KeyboardButton {
                id: btn_h
                value: "h"
                shifted_value: "H"
            }
            KeyboardButton {
                id: btn_j
                value: "j"
                shifted_value: "J"
            }
            KeyboardButton {
                id: btn_k
                value: "k"
                shifted_value: "K"
            }
            KeyboardButton {
                id: btn_l
                value: "l"
                shifted_value: "L"
            }
            KeyboardButton {
                id: btn_ouml
                value: "\u00F6"
                shifted_value: "\u00F6".toUpperCase()
            }
            KeyboardButton {
                id: btn_auml
                value: "\u00E4"
                shifted_value: "\u00E4".toUpperCase()
            }
            KeyboardButton {
                id: btn_return
                value: "return"
                code: Qt.Key_Return
                type: "return"
            }
        }

        Row {
            id: row3
            height: row_height
            anchors { horizontalCenter: parent.horizontalCenter }
            spacing: button_spacing

            KeyboardButton {
                id: btn_lshift
                value: "Shift"
                code: Qt.Key_Shift
                type: "shift"
                symbols_value: "Shift"
                symbols_code: Qt.Key_Shift
                shifted_symbols_value: "Shift"
                shifted_symbols_code: Qt.Key_Shift
            }
            KeyboardButton {
                id: btn_z
                value: "z"
                shifted_value: "Z"
            }
            KeyboardButton {
                id: btn_x
                value: "x"
                shifted_value: "X"
            }
            KeyboardButton {
                id: btn_c
                value: "c"
                shifted_value: "C"
            }
            KeyboardButton {
                id: btn_v
                value: "v"
                shifted_value: "V"
            }
            KeyboardButton {
                id: btn_b
                value: "b"
                shifted_value: "B"
            }
            KeyboardButton {
                id: btn_n
                value: "n"
                shifted_value: "N"
            }
            KeyboardButton {
                id: btn_m
                value: "m"
                shifted_value: "M"
            }
            KeyboardButton {
                id: btn_comma
                value: ","
                shifted_value: ";"
            }
            KeyboardButton {
                id: btn_dot
                value: "."
                shifted_value: ":"
            }
            KeyboardButton {
                id: btn_caps
                type: "shift"
                value: "CapsLock"
                code: Qt.Key_CapsLock
                symbols_value: "CapsLock"
                symbols_code: Qt.Key_CapsLock
                shifted_symbols_value: "CapsLock"
                shifted_symbols_code: Qt.Key_CapsLock
            }
        }

        Row {
            id: row4
            height: row_height
            anchors { horizontalCenter: parent.horizontalCenter }
            spacing: button_spacing

            KeyboardButton {
                id: btn_symbols
                value: "Symbols"
                action: "toggle_symbols"
                type: "other"
                symbols_value: "ABC"
                shifted_symbols_value: "ABC"
            }
            KeyboardButton {
                id: btn_space
                value: " "
                action: "space"
                code: Qt.Key_Space
                type: "space"
            }
            KeyboardButton {
                id: btn_minimize
                value: "Minimize"
                action: "minimize"
                type: "other"
                onClicked: {
                    wrapper.is_open = false;
                }
            }
        }
    }

    states: [
        State {
            name: "open"; when: wrapper.is_open
            PropertyChanges { target: wrapper; opacity: 1; height: (row_height*4 + row_spacing*4 + 20 + (textContentHolder.height + 10)) }
        }

    ]

    transitions: [
        Transition {
            NumberAnimation { properties: "height"; duration: 800; easing.type: Easing.InOutQuad }
            NumberAnimation { properties: "opacity"; duration: 800; easing.type: Easing.InOutQuad }
        }
    ]
}
