#include <QDateTime>
#include <QtCore/QRandomGenerator>
#include "sensorDataThread.h"
#include "ecgData.h"

SensorDataThread::SensorDataThread(HeartRateDataModel* hrModel, TemperatureDataModel *tempModel)
{
    m_hrModel = hrModel;
    m_tempModel = tempModel;
    m_startTime = QDateTime::currentMSecsSinceEpoch();
}

void SensorDataThread::run()
{
    while (1)
    {
        qint64 startMeasure = QDateTime::currentMSecsSinceEpoch();

        /* Read ECG data */
        EcgData* ecg = new EcgData((startMeasure - m_startTime) / 1000,
                                   QRandomGenerator::global()->bounded(100));
        m_hrModel->addEcgData(ecg);

        /* Read temperature data */
        TemperatureData* temp = new TemperatureData((startMeasure - m_startTime) / 1000,
                                                    35 + (float)QRandomGenerator::global()->bounded(0, 30)/10,
                                                    35 + (float)QRandomGenerator::global()->bounded(0, 30)/10);
        m_tempModel->addTemperatureData(temp);

        qDebug("[Sensor thread] ECG data: %lld, %f\n", ecg->m_timeStamp, ecg->m_ecgValue);
        qDebug("[Sensor thread] Temperature data: %lld, %f, %f\n", temp->m_timeStamp, temp->m_tSkin, temp->m_tRect);

        /* Calculate mearsure time, sleep if reading data time less than 1 second */
        qint64 measurePeriod = QDateTime::currentMSecsSinceEpoch() - startMeasure;
        if ((1000 - measurePeriod) > 0)
        {
            QThread::msleep(1000 - measurePeriod);
        }
    }
}
