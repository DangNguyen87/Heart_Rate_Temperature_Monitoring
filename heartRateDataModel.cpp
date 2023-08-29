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
}

void HeartRateDataModel::dataUpdate()
{
    m_timeCount++;
    /* Limit size of the list data,remove the first item in the list */
    if (m_data.size() >= HeartRateDataModel::HR_ROW_COUNT)
    {
        beginRemoveRows(QModelIndex(), 0, 0);
        m_data.pop_front();
        endRemoveRows();
    }
    QList<qreal> *dataList = new QList<qreal>(HeartRateDataModel::HR_COLUMN_COUNT);
    for (int k = 0; k < dataList->size(); k++) {
        if (k % 2 == 0)
            dataList->replace(k, m_timeCount);
        else
            dataList->replace(k, QRandomGenerator::global()->bounded(100));
    }
    /* Add new data to the list */
    beginInsertRows(QModelIndex(), m_data.count(), m_data.count());
    m_data.append(dataList);
    endInsertRows();
    emit addNewDataChanged(m_timeCount, dataList->takeAt(1));
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
