#ifndef MAINWIDGET_H
#define MAINWIDGET_H

#include <QWidget>
#include <QDeclarativeView>
#include <QDeclarativeContext>

#include "keyboard.h"

const QString contentPath = "qrc:/ui/";

class MainWidget : public QDeclarativeView
{
    Q_OBJECT
public:
    MainWidget(QWidget *parent = 0);
    ~MainWidget();

public slots:
    void minimizeWindow();
    void exitApplication();

    void virtualKeyPressed(QString action, int code);

    QVariant getConfigValue(const QString & key) const;

//private slots:
//    void saveFocusWidget(QWidget *oldFocus, QWidget *newFocus);

protected:
    virtual void keyReleaseEvent(QKeyEvent* e);

private:
    Qt::Key getQtKeyFromString(QString s);

    QDeclarativeContext *m_context;
    Keyboard *m_virtualKeyboard;
    QObject *m_keyboardObject;

    QWidget *m_focused_widget;
};

#endif // MAINWIDGET_H
