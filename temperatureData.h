#ifndef TEMPERATUREDATA_H
#define TEMPERATUREDATA_H

#include <QtGlobal>

//Steinhart–Hart coefficients
#define SHC_A               1.009249522e-03
#define SHC_B               2.378405444e-04
#define SHC_C               2.019202697e-07

class TemperatureData
{
public:
    explicit TemperatureData(qint64 timeStamp, float tSkin, float tRect);

    static float b3950CalcTemp(float vTemp, float vBias, float rBias)
    {
        float T, rTemp;

        // Temperature sensor connect to Vbias, rBias connect to ground
        // rTemp = rBias * (vBias / vTemp - 1)
        rTemp = rBias * ((float)vBias / vTemp - 1.0);
        T = (1.0 / (SHC_A + SHC_B * log(rTemp) + SHC_C * log(rTemp) * log(rTemp) * log(rTemp)));

        return T - 273.15; //Celsius degrees
    }

    qint64 m_timeStamp;
    float m_tSkin;
    float m_tRect;
};

#endif // TEMPERATUREDATA_H
