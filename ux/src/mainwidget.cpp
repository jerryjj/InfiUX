#include <QGLWidget>
#include <QGLFormat>
#include <QUrl>
#include <QTimer>
#include <QApplication>
#include <QDeclarativeEngine>
#include <QDeclarativeItem>

//#include <QtDBus>

#include "mainwidget.h"
#include "configuration.h"

QString baseUIFile(contentPath + "InfiUX.qml");

MainWidget::MainWidget(QWidget *parent) :
    QDeclarativeView(parent)
{
    // Switch to fullscreen in device
    #if !defined(Q_OS_MAC)
    setWindowState(Qt::WindowFullScreen);
    #endif

    setResizeMode(QDeclarativeView::SizeRootObjectToView);

    // Setup context
    m_context = rootContext();
    m_context->setContextProperty("mainWidget", this);

    // Set view optimizations not already done for QDeclarativeView
    setAttribute(Qt::WA_OpaquePaintEvent);
    setAttribute(Qt::WA_NoSystemBackground);

#ifdef DBUS_ENABLED
    // Make QDeclarativeView use OpenGL backend
    QGLWidget *glWidget = new QGLWidget(this);
    setViewport(glWidget);
    setViewportUpdateMode(QGraphicsView::FullViewportUpdate);
#endif

    // Open root QML file
    setSource(QUrl(baseUIFile));
}

MainWidget::~MainWidget()
{
}

QVariant MainWidget::getConfigValue(const QString & key) const
{
   return Config().value(key);
}

void MainWidget::minimizeWindow()
{
#if defined(Q_WS_MAEMO_5)
    // This is needed for Maemo5 to recognize minimization
    QDBusConnection connection = QDBusConnection::sessionBus();
    QDBusMessage message = QDBusMessage::createSignal("/","com.nokia.hildon_desktop","exit_app_view");
    connection.send(message);
#else
    setWindowState(Qt::WindowMinimized);
#endif
}

void MainWidget::exitApplication()
{
    QApplication::quit();
}
