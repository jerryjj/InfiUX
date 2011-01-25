#include <QApplication>
#include <QSplashScreen>
#include <QCoreApplication>
#include <QTextStream>
#include <QDir>
#include <QDebug>

#include <QtDeclarative>

#include "configuration.h"
#include "mainwidget.h"

#include "deviceinfo.h"

QTextStream logfile;

void FileLoggingHandler(QtMsgType type, const char *msg) {
    switch (type) {
        case QtFatalMsg:
            logfile << msg << "\n";
            abort();
        default:
            logfile << msg << "\n";
            logfile.flush();
    }
}

void initializeConfig() {

}

int main(int argc, char *argv[])
{
    qmlRegisterType<DeviceInfo>("InfiUX.DeviceInfo", 1, 0, "DeviceInfo");

    QDir configFileDir;
    bool configFileDirSet = false;

    for ( int i = 0; i < argc; i++ ) {
        QString s = argv[i] ;
        if ( s.startsWith( "--configpath" ) ) {
            configFileDir = QDir(s.replace("--configpath=", ""));
            configFileDirSet = true;
        }
    }

    QApplication app(argc, argv);
    //app.setStartDragDistance(30);

    QCoreApplication::setOrganizationName("Infigo Finland Oy");
    QCoreApplication::setOrganizationDomain("infigo.fi");
    QCoreApplication::setApplicationName("InfiUX");

    if (! configFileDirSet) {
        configFileDir = QDir(app.applicationDirPath());
    }

    QString fileName = configFileDir.filePath("infiux.ini");
    Config().loadConfigFromFile(fileName);

    initializeConfig();

    // Splash screen
    #if defined(Q_WS_MAEMO_5)
    QPixmap pixmap(contentPath + "img/splash.png");
    QSplashScreen splash(pixmap);
    splash.show();
    #endif

    if (Config().contains("main/logfile") && Config().value("main/logfile").toString() != "") {
        QFile *lf = new QFile(Config().value("main/logfile").toString());
        if (lf->open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text)) {
            logfile.setDevice(lf);
            qInstallMsgHandler(FileLoggingHandler);
        } else {
            qWarning() << "Error opening log file '" << Config().value("main/logfile").toString() << "'. All log output redirected to console.";
        }
    }

    MainWidget mainWidget;
    mainWidget.show();

    #if defined(Q_WS_MAEMO_5)
    splash.finish(&mainWidget);
    #endif

    app.connect(&app, SIGNAL(lastWindowClosed()), &app, SLOT(quit()));

    return app.exec();
}
