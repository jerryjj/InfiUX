#ifndef SHOGO_H
#define SHOGO_H

#include <QObject>
#include <QKeyEvent>
#include <QTimer>
#include <QtNetwork/QNetworkReply>
#include <QStringList>

#include <QDebug>

#define SHOGO_IP "127.0.0.1"
#define SHOGO_PORT "8000"
#define ACTION_URL "page/shared/action.sg"
#define INIT_VOLUME 70

enum Device{
    Battery,
    Accelerometer,
    Wifi
};

class Shogo : public QObject
{
    Q_OBJECT
public:
    explicit Shogo(QObject *parent = 0);

    Q_PROPERTY(int volume READ volume WRITE setVolume NOTIFY volumeChanged);
    int volume() const { return m_volume; }
    void setVolume(int val);

    Q_PROPERTY(int ledRed READ ledRed WRITE setLedRed NOTIFY ledRedChanged);
    int ledRed() const { return m_ledRed; }
    void setLedRed(int val);

    Q_PROPERTY(int ledGreen READ ledGreen WRITE setLedGreen NOTIFY ledGreenChanged);
    int ledGreen() const { return m_ledGreen; }
    void setLedGreen(int val);

    Q_PROPERTY(int ledBlue READ ledBlue WRITE setLedBlue NOTIFY ledBlueChanged);
    int ledBlue() const { return m_ledBlue; }
    void setLedBlue(int val);

    bool handleSpecialKeys(QKeyEvent*);

signals:
    void volumeChanged();
    void ledRedChanged();
    void ledGreenChanged();
    void ledBlueChanged();
    void signalKeyPress(QKeyEvent* event);
    void buttonPower();
    void buttonHome();
    void buttonVolumeUp();
    void buttonVolumeDown();
    void buttonFunction();

public slots:
    void shutdown();
    void reboot();
    void sleep();

private:
    void frameAppDo(QStringList args);
    void frameAppGet(Device device);

    int m_volume;
    int m_ledRed;
    int m_ledGreen;
    int m_ledBlue;

    QTimer* timer_acc;
    QNetworkAccessManager *networkManager;
    QNetworkReply* replyAcc;

};

#endif // SHOGO_H
