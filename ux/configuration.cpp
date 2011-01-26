#include "configuration.h"
#include <QSettings>

Configuration::Configuration()
{
}

Configuration::~Configuration()
{
}

void Configuration::loadConfigFromFile(const QString & path)
{
    settings = new QSettings(path, QSettings::IniFormat);
}

void Configuration::setValue(const QString & key, const QVariant & value)
{
    settings->setValue(key, value);
}

QVariant Configuration::value(const QString & key, const QVariant & defaultValue) const
{
   return settings->value(key, defaultValue);
}

bool Configuration::contains(const QString & key)
{
    return settings->contains(key);
}

void Configuration::beginGroup(const QString & prefix)
{
    settings->beginGroup(prefix);
}

void Configuration::endGroup()
{
    settings->endGroup();
}

QString Configuration::fileName() const
{
    return settings->fileName();
}

Configuration& Config() {
    static Configuration conf;
    return conf;
};
