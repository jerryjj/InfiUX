TARGET = InfiUX
TEMPLATE = app

QT       += core declarative

#CONFIG += mobility
#MOBILITY += sensors
#LIBS +=-lQtComponents

# This is needed for Maemo5 to recognize minimization of the application window
maemo5 {
    QT += dbus
}

contains(QT_CONFIG, opengles2)|contains(QT_CONFIG, opengl):QT += opengl

unix:!symbian {
    maemo5 {
        target.path = /opt/usr/bin
    } else {
        target.path = /usr/local/bin
    }
    INSTALLS += target
}

HEADERS += \
    mainwidget.h \
    configuration.h

SOURCES += main.cpp \
    mainwidget.cpp \
    configuration.cpp

OTHER_FILES += \
    Apps/DummyOne.qml \
    Common/Button.qml \
    Common/BarGauge.qml \
    Core/OSD.qml \
    Core/notifications.js \
    Core/NotificationItem.qml \
    Core/Header.qml \
    Core/DesktopPage.qml \
    Core/Desktop.qml \
    Core/BreadcrumbItem.qml \
    Core/Breadcrumb.qml \
    Core/breadcrumb.js \
    Core/applicationOpener.js \
    InfiUX.qml \
    Common/Datetime.qml \
    Common/dateformat.js

RESOURCES += \
    InfiUX.qrc
