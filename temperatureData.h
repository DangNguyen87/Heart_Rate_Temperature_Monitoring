#ifndef TEMPERATUREDATA_H
#define TEMPERATUREDATA_H

#include <QtGlobal>

class TemperatureData
{
public:
    explicit TemperatureData(qint64 timeStamp, float tSkin, float tRect);

    qint64 m_timeStamp;
    float m_tSkin;
    float m_tRect;
};

#endif // TEMPERATUREDATA_H
