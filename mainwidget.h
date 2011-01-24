#ifndef MAINWIDGET_H
#define MAINWIDGET_H

#include <QWidget>
#include <QDeclarativeView>
#include <QDeclarativeContext>

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

    QVariant getConfigValue(const QString & key) const;

private:
    QDeclarativeContext *m_context;

};

#endif // MAINWIDGET_H
