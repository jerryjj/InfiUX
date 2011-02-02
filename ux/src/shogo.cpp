#include "shogo.h"

#include <QUrl>

Shogo::Shogo(QObject *parent) :
    QObject(parent)
{
    this->m_volume = INIT_VOLUME;

    networkManager = new QNetworkAccessManager();
}

void Shogo::setVolume(int val)
{
    if (val > 100) m_volume = 100;
    else if(val < 0) m_volume = 0;

    frameAppDo(QStringList() << "set_volume" << "value" << QString("%1").arg(m_volume));
}

void Shogo::setLedRed(int val)
{
    m_ledRed = val;

    if (m_ledRed > 0) {
        system("echo 1 > /sys/class/leds/LTST:red/brightness");
    } else {
        system("echo 0 > /sys/class/leds/LTST:red/brightness");
    }
}
void Shogo::setLedGreen(int val)
{
    m_ledGreen = val;

    if (m_ledGreen > 0) {
        system("echo 1 > /sys/class/leds/LTST:green/brightness");
    } else {
        system("echo 0 > /sys/class/leds/LTST:green/brightness");
    }
}
void Shogo::setLedBlue(int val)
{
    m_ledBlue = val;

    if (m_ledBlue > 49) m_ledBlue = 49;
    if (m_ledBlue < 0) m_ledBlue = 0;

    char blueString[50];
    sprintf(blueString, "echo %d > /sys/class/leds/LTST:blue/brightness", m_ledBlue);
    system(blueString);
}

void Shogo::shutdown()
{
    frameAppDo(QStringList() << "shutdown_shogo");
}

void Shogo::reboot()
{
   frameAppDo(QStringList() << "reboot_shogo");
}

void Shogo::sleep()
{
    frameAppDo(QStringList() << "power_management" << "action" << "sleep");
}

bool Shogo::handleSpecialKeys(QKeyEvent* event)
{
    bool result;

    result = false;

    switch(event->key()) {
    case Qt::Key_Escape:
        result = true;
        emit buttonPower();
        break;
    case Qt::Key_End:
        result = true;
        emit buttonPower();
        break;
    case Qt::Key_Right:
        result = true;
        emit buttonVolumeUp();
        break;
    case Qt::Key_Left:
        result = true;
        emit buttonVolumeDown();
        break;
    case Qt::Key_Home:
        result = true;
        emit buttonHome();
        break;
    case Qt::Key_Up:
        result = true;
        emit buttonFunction();
        break;
    default:
        break;
    }

    return(result);
}

void Shogo::frameAppDo(QStringList args)
{
    QString url;

    url.append(QString("http://%1:%2/%3?sg_todo=").arg(SHOGO_IP).arg(SHOGO_PORT).arg(ACTION_URL));

    if (args.count() > 0) {
        url.append(args.at(0));
    }

    if (args.count() > 1) {
        url.append("&");
        url.append(args.at(1));
    }

    if (args.count() > 2) {
        url.append("=");
        url.append(args.at(2));
    }

    qDebug() << "connect to frameApp url: " << url;

    networkManager->get(QNetworkRequest(QUrl(url)));
}

void Shogo::frameAppGet(Device device)
{
    QString url;
    url.append(QString("http://%1:%2/").arg(SHOGO_IP).arg(SHOGO_PORT));

    switch(device){
    case Accelerometer:
        break;
    default:
        break;
    }
}
