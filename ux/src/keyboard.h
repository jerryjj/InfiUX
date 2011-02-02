#ifndef KEYBOARD_H
#define KEYBOARD_H

#include <QObject>
#include <QWidget>

#include <QInputContext>
#include <QProxyStyle>

#include <QDebug>

class Keyboard : public QInputContext
{
    Q_OBJECT

public:
    Keyboard(QWidget *parent = 0);
    ~Keyboard();

    /*Q_PROPERTY(QString language READ getLanguage WRITE setLanguage NOTIFY languageChanged);
    QString getLanguage() const { return m_activeLanguage; }
    void setLanguage(QString val) { m_activeLanguage = val; }*/

    QString identifierName();
    QString language();

    bool isComposing() const;

    bool filterEvent(const QEvent* event);

    void reset();

public slots:
    void showKeyboard(void);
    void hideKeyboard(void);
    void toggleShift(void);
    void toggleCaps(void);
    void toggleSymbols(void);

    //void enableKeyboard(void);
    //void disableKeyboard(void);

signals:
//    void languageChanged();
    void showKeyboardRequested();
    void hideKeyboardRequested();
    void shiftToggleRequested();
    void capsToggleRequested();
    void symbolsToggleRequested();

private:
    bool m_keyboardEnable;

    QString m_activeLanguage;
};

//This style allow Qt to send a RequestSoftwareInputPanel event
//When clicking on a field without focus
class MyProxyStyle : public QProxyStyle
{
  public:
    int styleHint(StyleHint hint, const QStyleOption *option = 0,
                  const QWidget *widget = 0, QStyleHintReturn *returnData = 0) const
    {
        if (hint == QStyle::SH_RequestSoftwareInputPanel)
            return QStyle::RSIP_OnMouseClick;
        return QProxyStyle::styleHint(hint, option, widget, returnData);
    }
};

#endif // KEYBOARD_H
