var pages = [
    {
        "id": "pageOne", "iconName": "browser",
        "content": {
            "type": "reserved",
            "src": "/browser/main.qml"
        }
    },
    {
        "id": "pageTwo",
        "widgets": [
            {"src": "qrc:/widgets/Clock.qml", "x": 10, "y": 10, "city": "Helsinki"},
            {"src": "qrc:/widgets/Clock.qml", "x": 10, "y": 270, "city": "Brussels", "shift": 1}
        ]
    },
    {
        "id": "pageThree"
        /*"widgets": [
            {"src": "qrc:/widgets/Clock.qml", "x": 10, "y": 10, "city": "Helsinki"}
        ]*/
    }
];

function loadContent(pageIdx, page) {
    if (pages[pageIdx]["content"]) {
        var content = pages[pageIdx].content;

        if (content.type == "reserved") {
            desktop.deactivateListScroll(pageIdx);
        }

        if (content.src) {
            var itemComponent = Qt.createComponent(content.src);
            if (itemComponent.status == Component.Ready) {
                var item = itemComponent.createObject(page);
                for (var k in content) {
                    if (k == "src" || k == "type") continue;
                    item[k] = content[k];
                }
            } else if (itemComponent.status == Component.Error) {
                console.log("error creating content component");
                console.log(itemComponent.errorString());
            }
        }
    }

    loadWidgets(pageIdx, page);
}

function loadWidgets(pageIdx, page) {
    if (! pages[pageIdx]["widgets"]) return;

    var widgets = pages[pageIdx].widgets;

    for (var i in widgets) {
        loadWidget(widgets[i], page);
    }
}

function loadWidget(data, targetPage) {
    var itemComponent = Qt.createComponent(data.src);
    if (itemComponent.status == Component.Ready) {
        var item = itemComponent.createObject(targetPage);
        for (var k in data) {
            if (k == "src") continue;
            item[k] = data[k];
        }
    } else if (itemComponent.status == Component.Error) {
        console.log("error creating component");
        console.log(itemComponent.errorString());
    }
}
