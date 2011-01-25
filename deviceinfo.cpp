#include "deviceinfo.h"

DeviceInfo::DeviceInfo(QObject *parent) :
    QObject(parent)
{
    resolveScreenResolution();
}

DeviceInfo::~DeviceInfo()
{
}

int DeviceInfo::screenX()
{
    return m_screenResolutionX;
}

int DeviceInfo::screenY()
{
    return m_screenResolutionY;
}

void DeviceInfo::resolveScreenResolution()
{
    m_screenResolutionX = 1024;
    m_screenResolutionY = 600;
    emit screenResolutionChanged();
}
