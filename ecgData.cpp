#include "ecgData.h"

EcgData::EcgData(qint64 timeStamp, float ecgValue)
{
    m_timeStamp = timeStamp;
    m_ecgValue = ecgValue;
}
