#include "heartRateDataModel.h"
#include <QtCore/QRandomGenerator>

HeartRateDataModel::HeartRateDataModel(QObject *parent)
    : QAbstractTableModel{parent}
{
    m_timeCount = 0;

    // Create a timer
    m_timer = new QTimer(this);
    // Setup signal and slot
    connect(m_timer, SIGNAL(timeout()),
          this, SLOT(dataUpdate()));
    m_timer->start(1000);
    m_preTimeStamp = 0;
}

void HeartRateDataModel::dataUpdate()
{
    EcgData *ecg;
    QMutexLocker locker(&m_ecgDataMutex);

    // No data in queue, return
    if (m_ecgData.isEmpty())
    {
        return;
    }

    while (!m_ecgData.isEmpty())
    {
        /* Limit size of the list data,remove the first item in the list */
        if (m_data.size() >= HeartRateDataModel::HR_ROW_COUNT)
        {
            beginRemoveRows(QModelIndex(), 0, 0);
            m_data.pop_front();
            endRemoveRows();
        }
        /* Get data from queue and put into model data */
        ecg = m_ecgData.dequeue();
        /* Todo: */
        /* Review sync mechanism between threads */

        if ((ecg->m_timeStamp == m_preTimeStamp) && (m_preTimeStamp != 0))
        {
            /* Sensor data thread read data too fast drop later data with the same time stamp */
            qDebug("Dupplicated time stamp %lld, drop data\n", ecg->m_timeStamp);
        }
        else
        {
            if (ecg->m_timeStamp - m_preTimeStamp > 3)
            {
                /* Sensor data thread delay to read data every 1 second */
                qDebug("Delay to read data %lld\n", ecg->m_timeStamp);
            }

            QList<qreal> *dataList = new QList<qreal>(HeartRateDataModel::HR_COLUMN_COUNT);
            dataList->replace(0, ecg->m_timeStamp);
            dataList->replace(1, ecg->m_ecgValue);

            /* Add new data to the list */
            beginInsertRows(QModelIndex(), m_data.count(), m_data.count());
            m_data.append(dataList);
            endInsertRows();
            emit addNewDataChanged(ecg->m_timeStamp, ecg->m_ecgValue);
        }
        m_preTimeStamp = ecg->m_timeStamp;
    }
}

int HeartRateDataModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_data.size();
}

int HeartRateDataModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return HeartRateDataModel::HR_COLUMN_COUNT;
}

QVariant HeartRateDataModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role == Qt::DisplayRole && orientation == Qt::Horizontal)
    {
        if (section == HeartRateDataModel::COLUMN_TIME_STAMP)
        {
            return QString("Time");
        }
        else if (section == HeartRateDataModel::COLUMN_HEART_RATE)
        {
            return QString("Heart Rate");
        }
    }
    return QVariant();
}

QVariant HeartRateDataModel::data(const QModelIndex &index, int role) const
{
    if (role == Qt::DisplayRole) {
        return m_data[index.row()]->at(index.column());
    }
    return QVariant();
}

void HeartRateDataModel::addEcgData(EcgData *ecg)
{
    QMutexLocker locker(&m_ecgDataMutex);
    m_ecgData.enqueue(ecg);
}
