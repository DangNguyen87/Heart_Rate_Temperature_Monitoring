#ifndef TEMPERATUREDATAMODEL_H
#define TEMPERATUREDATAMODEL_H

#include <QObject>
#include <QTimer>
#include <QMutex>
#include <QQueue>
#include "temperatureData.h"

#define TEMP_SHARED_CONSTANT(type, name, value) \
                static inline const type name = value; \
                Q_PROPERTY(type name MEMBER name CONSTANT)

class TemperatureDataModel : public QObject
{
    Q_OBJECT
public:
    TEMP_SHARED_CONSTANT(float, TSKIN_MIN_RANGE, 36.5);
    TEMP_SHARED_CONSTANT(float, TSKIN_MAX_RANGE, 38.5);
    TEMP_SHARED_CONSTANT(float, TRECT_MIN_RANGE, 35.5);
    TEMP_SHARED_CONSTANT(float, TRECT_MAX_RANGE, 39.0);

    explicit TemperatureDataModel(QObject *parent = nullptr);

    void addTemperatureData(TemperatureData *temp);
signals:
    void temperatureDataChanged(float tSkin, float tRect);

public slots:
    void temperatureUpdate();
private:
    QQueue<TemperatureData*> m_tempData;
    QMutex m_tempDataMutex;
    QTimer* m_timer;
    qint64 m_preTimeStamp;
};

#endif // TEMPERATUREDATAMODEL_H
