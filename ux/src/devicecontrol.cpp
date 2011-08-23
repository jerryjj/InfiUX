#include "devicecontrol.h"

DeviceControl::DeviceControl(QObject *parent) :
    QObject(parent)
{
}

DeviceControl::~DeviceControl()
{
}

int DeviceControl::volume() const
{
    return 0;
}

void DeviceControl::setVolume(int val)
{
    Q_UNUSED(val);
}

int DeviceControl::ledRed() const
{
    return 0;
}
void DeviceControl::setLedRed(int val)
{
    Q_UNUSED(val);
}

int DeviceControl::ledGreen() const
{
    return 0;
}
void DeviceControl::setLedGreen(int val)
{
    Q_UNUSED(val);
}

int DeviceControl::ledBlue() const
{
    return 0;
}
void DeviceControl::setLedBlue(int val)
{
    Q_UNUSED(val);
}
