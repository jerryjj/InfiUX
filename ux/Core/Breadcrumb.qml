import Qt 4.7

import "breadcrumb.js" as Logic

Item {
    id: wrapper
    //anchors { verticalCenter: parent }

    function addItem(label, props) {
        Logic.addItem(label, props);
    }

    function removeLastItem() {
        Logic.removeLastItem();
    }

    Item {
        id: itemsHolder
    }
}
