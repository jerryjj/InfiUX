#ifndef CONFIGURATION_H
#define CONFIGURATION_H

#include <QVariant>

class QSettings;
class QString;

class Configuration
{

public:
    Configuration();
    ~Configuration();

    void loadConfigFromFile(const QString & path);
    void setValue(const QString & key, const QVariant & value);
    QVariant value(const QString & key, const QVariant & defaultValue = QVariant()) const;
    bool contains(const QString & key);
    void beginGroup(const QString & prefix);
    void endGroup();

    QString fileName() const;

private:
    QSettings *settings;

private:
    Configuration(const Configuration&);

    friend Configuration& Config();
};

Configuration& Config();

#endif // CONFIGURATION_H
