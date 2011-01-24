#include <QApplication>
#include <QSplashScreen>

#include "mainwidget.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    //app.setStartDragDistance(30);

    // Splash screen
    #if defined(Q_WS_MAEMO_5)
    QPixmap pixmap(contentPath + "img/splash.jpg");
    QSplashScreen splash(pixmap);
    splash.show();
    #endif

    MainWidget mainWidget;
    mainWidget.show();

    #if defined(Q_WS_MAEMO_5)
    splash.finish(&mainWidget);
    #endif

    return app.exec();
}
