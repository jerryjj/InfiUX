# To disable OpenGL features, comment the following:
DEFINES += OPENGL_ENABLED

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

contains(DEFINES, OPENGL_ENABLED)|contains(QT_CONFIG, opengles2)|contains(QT_CONFIG, opengl):QT += opengl

unix:!symbian {
    maemo5 {
        target.path = /opt/usr/bin
    } else {
        target.path = /usr/local/bin
    }
    INSTALLS += target
}

HEADERS += \
    src/mainwidget.h \
    src/configuration.h \
    src/deviceinfo.h

SOURCES += src/main.cpp \
    src/mainwidget.cpp \
    src/configuration.cpp \
    src/deviceinfo.cpp

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
    Common/dateformat.js \
    Common/WidgetBase.qml \
    ApplicationLauncher.qml \
    Core/MainMenu.qml \
    Core/TopPanel.qml \
    widgets/ApplicationLauncher.qml

RESOURCES += \
    InfiUX.qrc
