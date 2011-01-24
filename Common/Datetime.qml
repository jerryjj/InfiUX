import Qt 4.7

import "dateformat.js" 1.0 as DateFormatHelper

Item {
    id: wrapper

    property string format: "<b>mmm dd</b> HH:MM:ss"

    property int day
    property int month
    property int year

    property int weekday

    property int hours
    property int minutes
    property int seconds

    property string formatted: ""

    function timeUpdate() {
        var date = new Date;

        day = date.getDate();
        month = date.getMonth();
        year = date.getFullYear();

        weekday = date.getDay();

        hours = date.getHours();
        minutes = date.getMinutes();
        seconds = date.getSeconds();

        formatted = DateFormatHelper.dateFormat(date, format);
    }

    Timer {
        interval: 100; running: true; repeat: true;
        onTriggered: wrapper.timeUpdate()
    }


}
