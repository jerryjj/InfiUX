var _notificationsHolder = null;
var _activeIndex = -1;
var _activeItem = null;
var _queue = [];

function registerHolder(holder)
{
    _notificationsHolder = holder;
}

function newItem(props)
{
    var itemComponent = Qt.createComponent("Core/NotificationItem.qml");
    if (itemComponent.status == Component.Ready) {
        var item = itemComponent.createObject(_notificationsHolder);
        item.active = false;

        if (props) {
            for (var k in props) { item[k] = props[k]; }
        }

        _queue.push(item);

        if (! _activeItem) {
            showNext();
        }
    } else if (itemComponent.status == Component.Error) {
        console.log("error creating NotificationItem component");
        console.log(itemComponent.errorString());
    }
}

function showItem(item)
{
    _activeItem = item;
    _activeItem.active = true;
}

function removeActive()
{
    _activeItem.active = false;

    _activeItem = null;
}

function hasNext()
{
    return _queue.length > 0;
}

function showNext()
{
    if (_activeItem) {
        removeActive();
    }

    if (hasNext()) {
        showItem(_queue.pop());
    }
}
