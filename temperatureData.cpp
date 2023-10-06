#include "temperatureData.h"

TemperatureData::TemperatureData(qint64 timeStamp, float tSkin, float tRect)
{
    m_timeStamp = timeStamp;
    m_tSkin = tSkin;
    m_tRect = tRect;
}

