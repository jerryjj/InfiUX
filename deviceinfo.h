#ifndef DEVICEINFO_H
#define DEVICEINFO_H

#include <QObject>

class DeviceInfo : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int screenX READ screenX NOTIFY screenResolutionChanged)
    Q_PROPERTY(int screenY READ screenY NOTIFY screenResolutionChanged)

public:
    DeviceInfo(QObject *parent = 0);
    ~DeviceInfo();

public:
    int screenX();
    int screenY();

private:
    void resolveScreenResolution();

    int m_screenResolutionX;
    int m_screenResolutionY;

signals:
    void screenResolutionChanged();

public slots:

};

#endif // DEVICEINFO_H
