import Qt 4.7

Item {
    id: wrapper

    property string value: ""
    property string action: ""
    property int code: -1

    property alias image: btn.icon

    property string type: "letter" //letter, backspace, shift, return, space, other

//    property variant normal: { "value": "", "action": "", "code": -1 }
//    property variant shifted: { "value": "", "action": "", "code": -1 }
//    property variant symbols: { "value": "", "action": "", "code": -1 }
//    property variant shifted_symbols: { "value": "", "action": "", "code": -1 }

    property string shifted_value: ""
    property string shifted_action: ""
    property int shifted_code: -1

    property string symbols_value: ""
    property string symbols_action: ""
    property int symbols_code: -1

    property string shifted_symbols_value: ""
    property string shifted_symbols_action: ""
    property int shifted_symbols_code: -1

    property bool kbShifted: false
    property bool kbSymbols: false

    signal clicked(string action, int code);

    width: 75; height: parent.height

    function toggleShiftAndSymbols() {
        btn.opacity = 1;
        if (kbSymbols) {
            if (kbShifted) {
                btn.text = shifted_symbols_value;
                if (!shifted_symbols_value) btn.opacity = 0;
            } else {
                btn.text = symbols_value;
                if (!symbols_value) btn.opacity = 0;
            }
        } else {
            btn.text = kbShifted ? (shifted_value ? shifted_value : value) : value;
        }
    }

    Connections {
        target: keyboard
        onCapsToggleChanged: {
            kbShifted = keyboard.useShifted();
        }
        onShiftToggleChanged: {
            kbShifted = keyboard.useShifted();
        }
        onSymbolsToggleChanged: {
            kbSymbols = keyboard.symbolsToggle;
        }
    }
    onKbShiftedChanged: {
        toggleShiftAndSymbols();
    }
    onKbSymbolsChanged: {
        toggleShiftAndSymbols();
    }


    Component.onCompleted: {
        if (type == "shit") {
            wrapper.width += 15;
        }
        if (type == "backspace") {
            wrapper.width += 30;
        }
        if (type == "return") {
            wrapper.width += 50;
        }
        if (type == "space") {
            wrapper.width = wrapper.width * 7;
        }
    }

    Button {
        id: btn
        anchors.fill: parent
        text: value
        opacity: 1

        onClicked: {
            if (keyboard.useShifted()) {
                if (kbSymbols) {
                    var act = shifted_symbols_action ? shifted_symbols_action : (symbols_action ? symbols_action : action);
                    var val = shifted_symbols_value ? shifted_symbols_value : (symbols_value ? symbols_value : value);
                    var c = shifted_symbols_code > -1 ? shifted_symbols_code : (symbols_code ? symbols_code : code);
                } else {
                    var act = shifted_action ? shifted_action : action;
                    var val = shifted_value ? shifted_value : value;
                    var c = shifted_code > -1 ? shifted_code : code;
                }
            } else {
                if (kbSymbols) {
                    var act = symbols_action ? symbols_action : action;
                    var val = symbols_value ? symbols_value : value;
                    var c = symbols_code ? symbols_code : code;
                } else {
                    var act = action;
                    var val = value;
                    var c = code;
                }
            }

            //console.log("clicked value: "+val+", action: "+(act != "" ? act : val)+", code: "+c);

            wrapper.clicked((act != "" ? act : val), c);
            keyboard.virtualKeyClicked((act != "" ? act : val), c);
        }
    }
}
