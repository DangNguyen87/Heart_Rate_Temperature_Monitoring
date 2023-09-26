#ifndef ECGDATA_H
#define ECGDATA_H

#include <QtGlobal>

class EcgData
{
public:
    EcgData(qint64 timeStamp, float ecgValue);
public:
    qint64 m_timeStamp;
    float m_ecgValue;
};

#endif // ECGDATA_H
