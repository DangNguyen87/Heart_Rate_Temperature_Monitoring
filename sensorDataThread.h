#ifndef SENSORDATATHREAD_H
#define SENSORDATATHREAD_H

#include <QThread>
#include "heartRateDataModel.h"
#include "temperatureDataModel.h"

class SensorDataThread : public QThread
{
public:
    SensorDataThread(HeartRateDataModel* hrModel, TemperatureDataModel *tempModel);

protected:
    void run();

private:
    HeartRateDataModel* m_hrModel;
    TemperatureDataModel* m_tempModel;
    qint64 m_startTime;
};

#endif // SENSORDATATHREAD_H
