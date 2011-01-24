var itemComponent = null;
var selectedApp = null;
var appProps = null;

function open(component_name, props)
{
    appProps = props;
    loadComponent(component_name);
}

//Creation is split into two functions due to an asynchronous wait while
//possible external files are loaded.

function loadComponent(component_name)
{
    if (itemComponent != null) { // component has been previously loaded
        createItem();
        return;
    }

    var componentFile = "Apps/"+component_name+".qml";

    itemComponent = Qt.createComponent(componentFile);
    if (itemComponent.status == Component.Loading)  //Depending on the content, it can be ready or error immediately
        component.statusChanged.connect(createItem);
    else
        createItem();
}

function createItem()
{
    if (itemComponent.status == Component.Ready && selectedApp == null) {
        selectedApp = itemComponent.createObject(applicationHolder);
        selectedApp.shown = true;

        if (appProps) {
            for (var k in appProps) { selectedApp[k] = appProps[k]; }
        }

        selectedApp = null;
    } else if (itemComponent.status == Component.Error) {
        selectedApp = null;
        console.log("error creating component");
        console.log(itemComponent.errorString());
    }
}
