#ifndef DEVICECONTROL_H
#define DEVICECONTROL_H

#include <QObject>
#include <QKeyEvent>

class DeviceControl : public QObject
{
    Q_OBJECT

public:
    DeviceControl(QObject *parent = 0);
    ~DeviceControl();

    Q_PROPERTY(int volume READ volume WRITE setVolume NOTIFY volumeChanged);
    int volume() const;
    void setVolume(int val);

    Q_PROPERTY(int ledRed READ ledRed WRITE setLedRed NOTIFY ledRedChanged);
    int ledRed() const;
    void setLedRed(int val);

    Q_PROPERTY(int ledGreen READ ledGreen WRITE setLedGreen NOTIFY ledGreenChanged);
    int ledGreen() const;
    void setLedGreen(int val);

    Q_PROPERTY(int ledBlue READ ledBlue WRITE setLedBlue NOTIFY ledBlueChanged);
    int ledBlue() const;
    void setLedBlue(int val);

    //bool handleHardwareKeys(QKeyEvent*);

signals:
    void volumeChanged();
    void ledRedChanged();
    void ledGreenChanged();
    void ledBlueChanged();
//    void shutdownRequested();
//    void rebootRequested();
//    void sleepRequested();

public slots:
//    void shutdown();
//    void reboot();
//    void sleep();

private:
    //int m_vol;
};

#endif // DEVICECONTROL_H
