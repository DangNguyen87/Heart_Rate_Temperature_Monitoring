#ifndef SENSORDATATHREAD_H
#define SENSORDATATHREAD_H

#include <QThread>
#include "heartRateDataModel.h"

class SensorDataThread : public QThread
{
public:
    SensorDataThread(HeartRateDataModel* hrModel);

protected:
    void run();

private:
    HeartRateDataModel* m_hrModel;
    qint64 m_startTime;
};

#endif // SENSORDATATHREAD_H
