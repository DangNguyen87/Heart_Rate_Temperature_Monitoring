#include "temperatureDataModel.h"

TemperatureDataModel::TemperatureDataModel(QObject *parent)
    : QObject{parent}
{
    m_preTimeStamp = 0;

    // Create a timer
    m_timer = new QTimer(this);
    // Setup signal and slot
    connect(m_timer, SIGNAL(timeout()),
          this, SLOT(temperatureUpdate()));
    m_timer->start(1000);
}

void TemperatureDataModel::addTemperatureData(TemperatureData *temp)
{
    QMutexLocker locker(&m_tempDataMutex);
    m_tempData.enqueue(temp);
}

void TemperatureDataModel::temperatureUpdate()
{
    TemperatureData *temp;
    QMutexLocker locker(&m_tempDataMutex);

    // No data in queue, return
    if (m_tempData.isEmpty())
    {
        return;
    }
    while (!m_tempData.isEmpty())
    {
        /* Get data from queue */
        temp = m_tempData.dequeue();

        if ((temp->m_timeStamp == m_preTimeStamp) && (m_preTimeStamp != 0))
        {
            /* Sensor data thread read data too fast drop later data with the same time stamp */
            qDebug("Dupplicated time stamp %lld, drop data\n", temp->m_timeStamp);
        }
        else
        {
            if (temp->m_timeStamp - m_preTimeStamp > 3)
            {
                /* Sensor data thread delay to read data every 1 second */
                qDebug("Delay to read data %lld\n", temp->m_timeStamp);
            }
            emit temperatureDataChanged(temp->m_tSkin, temp->m_tRect);
        }
        m_preTimeStamp = temp->m_timeStamp;
    }
}
