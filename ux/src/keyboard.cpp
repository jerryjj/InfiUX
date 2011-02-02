#include "keyboard.h"

Keyboard::Keyboard(QWidget* parent)
{
    Q_UNUSED(parent);

    m_activeLanguage = "fi_FI";
    m_keyboardEnable = true;
}

Keyboard::~Keyboard(){}

QString Keyboard::identifierName(){return (QLatin1String("Keyboard"));}
QString Keyboard::language(){return (QLatin1String("fi_FI"));}

bool Keyboard::isComposing() const {return false;}

bool Keyboard::filterEvent(const QEvent* event)
{
    if (event->type() == QEvent::RequestSoftwareInputPanel) {
        this->showKeyboard();
        return true;
    } else if (event->type() == QEvent::CloseSoftwareInputPanel) {
        this->hideKeyboard();
        return true;
    }
    return false;
}

// this is a terrible hack because of a bug in Qt where QEvent::CloseSoftwareInputPanel is never delivered
void Keyboard::reset(){ emit hideKeyboard(); }

void Keyboard::showKeyboard() { if (m_keyboardEnable) emit showKeyboardRequested(); }
void Keyboard::hideKeyboard() { emit hideKeyboardRequested(); }
void Keyboard::toggleShift() { emit shiftToggleRequested(); }
void Keyboard::toggleCaps() { emit capsToggleRequested(); }
void Keyboard::toggleSymbols() { emit symbolsToggleRequested(); }
