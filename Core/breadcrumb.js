var _items = new Array()

function getItems()
{
    return _items;
}

function addItem(label, props)
{
    var itemComponent = Qt.createComponent("BreadcrumbItem.qml");
    if (itemComponent.status == Component.Ready) {
        var item = itemComponent.createObject(itemsHolder);
        item.label = label;

        if (props) {
            for (var k in props) { item[k] = props[k]; }
        }

        _items.push(item);
    } else if (itemComponent.status == Component.Error) {
        console.log("error creating component");
        console.log(itemComponent.errorString());
    }

    //itemsHolder.children = _items;
}

function removeLastItem()
{
    _items[_items.length-1].destroy();
    delete _items[_items.length-1];
}
