#ifndef SENSORDATATHREAD_H
#define SENSORDATATHREAD_H

#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <linux/i2c-dev.h>
#include <QThread>
#include "heartRateDataModel.h"
#include "temperatureDataModel.h"

class SensorDataThread : public QThread
{
    enum ADS_CHANNEL {
        ADS_CHANNEL_A0,
        ADS_CHANNEL_A1,
        ADS_CHANNEL_A2,
        ADS_CHANNEL_A3
    };

private:
    float readVoltageValue(enum ADS_CHANNEL channel);
public:
    SensorDataThread(HeartRateDataModel* hrModel, TemperatureDataModel *tempModel);
    ~SensorDataThread();
protected:
    void run();

private:
    HeartRateDataModel* m_hrModel;
    TemperatureDataModel* m_tempModel;
    qint64 m_startTime;
    int m_i2cFile;
};

#endif // SENSORDATATHREAD_H
