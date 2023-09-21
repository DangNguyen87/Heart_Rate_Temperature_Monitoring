#include <QDateTime>
#include <QtCore/QRandomGenerator>
#include "sensorDataThread.h"
#include "ecgData.h"

SensorDataThread::SensorDataThread(HeartRateDataModel* hrModel)
{
    m_hrModel = hrModel;
    m_startTime = QDateTime::currentMSecsSinceEpoch();
}

void SensorDataThread::run()
{
    while (1)
    {
        qint64 startMeasure = QDateTime::currentMSecsSinceEpoch();
        EcgData* ecg = new EcgData((startMeasure - m_startTime) / 1000, QRandomGenerator::global()->bounded(100));
        m_hrModel->addEcgData(ecg);

        qDebug("Sensor data thread running: %lld, %f\n", ecg->m_timeStamp, ecg->m_ecgValue);
        /* Calculate mearsure time */
        qint64 measurePeriod = QDateTime::currentMSecsSinceEpoch() - startMeasure;
        /* Sleep if reading data time less than 1 second */
        if ((1000 - measurePeriod) > 0)
        {
            QThread::msleep(1000 - measurePeriod);
        }
    }
}
