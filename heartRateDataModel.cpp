#include "heartRateDataModel.h"
#include <QtCore/QRandomGenerator>


HeartRateDataModel::HeartRateDataModel(QObject *parent)
    : QAbstractTableModel{parent}
{
    m_columnCount = 2;
    m_rowCount = 100;
    m_timeCount = 0;

    // create a timer
    m_timer = new QTimer(this);
    // setup signal and slot
    connect(m_timer, SIGNAL(timeout()),
          this, SLOT(dataUpdate()));
    m_timer->start(1000);
}

void HeartRateDataModel::dataUpdate()
{
    m_timeCount++;
    /* Limit size of the list data */
    if (m_data.size() >= m_rowCount)
    {
        beginRemoveRows(QModelIndex(), 0, 0);
        m_data.pop_front();
        endRemoveRows();
    }
    QList<qreal> *dataList = new QList<qreal>(m_columnCount);
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
    return m_data.count();
}

int HeartRateDataModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_columnCount;
}

//QVariant HeartRateDataModel::headerData(int section, Qt::Orientation orientation, int role) const
//{

//}

QVariant HeartRateDataModel::data(const QModelIndex &index, int role) const
{
    if (role == Qt::DisplayRole) {
        return m_data[index.row()]->at(index.column());
    }
    return QVariant();
}
