import Qt 4.7
import "../Common" 1.0 as Common
import "../Core/applicationOpener.js" 1.0 as AppOpener

Common.WidgetBase {
    id: widget
    width: 100; height: 100

    property string module
    function getProperties() {}

    signal opened

    onEditModeChanged: {
        if (editMode) {
            console.log("appl in edit mode");
        } else {
            console.log("appl not in edit mode");
        }
    }

    /*onEditMode: {
        console.log("AppLauncher edit mode");
    }*/

    MouseArea {
        anchors.fill: parent
        onClicked: {
            AppOpener.open(widget.module, widget.getProperties());
            opened();
        }
    }


}
