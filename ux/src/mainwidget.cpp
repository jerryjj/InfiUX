#include <QUrl>
#include <QTimer>
#include <QApplication>
#include <QDeclarativeEngine>
#include <QDeclarativeItem>

#ifdef OPENGL_ENABLED
#include <QGLWidget>
#include <QGLFormat>
#endif

#include <QGraphicsObject>

#if defined(Q_WS_MAEMO_5)
#include <QtDBus>
#endif

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
    setHorizontalScrollBarPolicy(Qt::ScrollBarAlwaysOff);
    setVerticalScrollBarPolicy(Qt::ScrollBarAlwaysOff);

    // Setup context
    m_context = rootContext();
    m_context->setContextProperty("mainWidget", this);

    QDeclarativeComponent browser_comp(this->engine(), QUrl("qrc:/browser/main.qml"));
    QDeclarativeComponent *browser = qobject_cast<QDeclarativeComponent *>(&browser_comp);
    //QDeclarativeItem *item = qobject_cast<QDeclarativeItem *>(component.create());
    m_context->setContextProperty("browser", browser);

    // Set view optimizations not already done for QDeclarativeView
    setAttribute(Qt::WA_OpaquePaintEvent);
    setAttribute(Qt::WA_NoSystemBackground);

#ifdef OPENGL_ENABLED
    // Make QDeclarativeView use OpenGL backend
    QGLWidget *glWidget = new QGLWidget(this);
    setViewport(glWidget);
    setViewportUpdateMode(QGraphicsView::FullViewportUpdate);
#endif

    this->m_virtualKeyboard = new Keyboard(this);

    // Open root QML file
    setSource(QUrl(baseUIFile));

    QObject *ro = dynamic_cast<QObject*>(this->rootObject());
    m_keyboardObject = ro->findChild<QObject *>("keyboard");

    connect(m_virtualKeyboard, SIGNAL(showKeyboardRequested()), m_keyboardObject, SIGNAL(show()));
    connect(m_virtualKeyboard, SIGNAL(hideKeyboardRequested()), m_keyboardObject, SIGNAL(hide()));
    connect(m_virtualKeyboard, SIGNAL(shiftToggleRequested()), m_keyboardObject, SIGNAL(toggleShift()));
    connect(m_virtualKeyboard, SIGNAL(capsToggleRequested()), m_keyboardObject, SIGNAL(toggleCaps()));
    connect(m_virtualKeyboard, SIGNAL(symbolsToggleRequested()), m_keyboardObject, SIGNAL(toggleSymbols()));

    connect(m_keyboardObject, SIGNAL(virtualKeyClicked(QString, int)), this, SLOT(virtualKeyPressed(QString, int)));

    qApp->setStyle(new MyProxyStyle());
    qApp->setInputContext(this->m_virtualKeyboard);

    //connect(qApp, SIGNAL(focusChanged(QWidget*,QWidget*)), this, SLOT(saveFocusWidget(QWidget*,QWidget*)));
}

MainWidget::~MainWidget()
{
}

Qt::Key MainWidget::getQtKeyFromString(QString s)
{

    unsigned char c = s.toUpper().toStdString()[0];
    uint code;

    if(s.length()==1 || s.contains(QChar('&'))){
        if (c >= '!' && c <= '`') {
            code = c - ' ' + Qt::Key_Space;
        }else if(c >= '{' && c <= '~'){
            code = c - '{' + Qt::Key_BraceLeft;
        }else{
            code = Qt::Key_unknown;
        }
    }else{
        code = Qt::Key_unknown;
    }

   return (Qt::Key) code;
}

void MainWidget::virtualKeyPressed(QString action, int code)
{
//    qDebug() << "mw virtualKeyPressed " << action << " code: " << code;

    QString c = action.trimmed();
    Qt::Key k = getQtKeyFromString(c);
    c.resize(1);

    if (code > -1) k = (Qt::Key) code;

//    qDebug() << "k " << k;
//    qDebug() << "c " << c;

    switch(k){
    case Qt::Key_Shift:
        qDebug() << "Key_Shift";
        this->m_virtualKeyboard->toggleShift();
        return;
    case Qt::Key_CapsLock:
        qDebug() << "Key_CapsLock";
        this->m_virtualKeyboard->toggleCaps();
        return;
    case Qt::Key_Alt:
        qDebug() << "Key_Alt";
        return;
    case Qt::Key_NumLock:
        qDebug() << "Key_NumLock";
        return;
    case Qt::Key_Print:
        qDebug() << "Key_Print";
        return;
    case Qt::Key_MenuKB:
        qDebug() << "Key_MenuKB";
        return;
    case Qt::Key_MenuPB:
        qDebug() << "Key_MenuPB";
        this->m_virtualKeyboard->hideKeyboard();
        return;
    case Qt::Key_Space:
        qDebug() << "Key_Space";

        QDeclarativeView::keyReleaseEvent(new QKeyEvent(QEvent::KeyPress, Qt::Key_Space, Qt::NoModifier, " "));
        m_keyboardObject->setProperty("text", QVariant(m_keyboardObject->property("text").toString() + " "));
        return;
    case Qt::Key_Return:
        qDebug() << "Key_Return";
        this->m_virtualKeyboard->hideKeyboard();

        QDeclarativeView::keyReleaseEvent(new QKeyEvent(QEvent::KeyPress, Qt::Key_Return, Qt::NoModifier, c));
        m_keyboardObject->setProperty("text", QVariant(""));
        return;
    case Qt::Key_unknown:
        qDebug() << "Key_unknown";
        if (action == "toggle_symbols") {
            this->m_virtualKeyboard->toggleSymbols();
        }
        return;
    default:
        QDeclarativeView::keyReleaseEvent(new QKeyEvent(QEvent::KeyPress, k, Qt::NoModifier, c));

        QString str = m_keyboardObject->property("text").toString();

        if (k != Qt::Key_Backspace) {
            str += c;
        } else {
            str.chop(1);
        }

        m_keyboardObject->setProperty("text", QVariant(str));
        break;
    }
}

void MainWidget::keyReleaseEvent(QKeyEvent* e)
{
    qDebug() << "keyReleaseEvent " << e;
    //if (!GCreator->oGetShogo()->handleSpecialKeys(e)) {
        QDeclarativeView::keyReleaseEvent(e);
    //}
}

/*void MainWidget::saveFocusWidget(QWidget * oldFocus, QWidget *newFocus)
{
    Q_UNUSED(oldFocus);
    if (newFocus != 0 && !this->isAncestorOf(newFocus)) {
        m_focused_widget = newFocus;
    }
    qDebug() << m_focused_widget;
}*/

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
