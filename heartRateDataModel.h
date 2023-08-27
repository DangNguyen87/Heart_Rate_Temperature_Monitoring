#ifndef HEARTRATEDATAMODEL_H
#define HEARTRATEDATAMODEL_H

#include <QAbstractTableModel>
#include <QObject>
#include <QTimer>

class HeartRateDataModel : public QAbstractTableModel
{
    Q_OBJECT

public slots:
    void dataUpdate();

public:
    explicit HeartRateDataModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    int columnCount(const QModelIndex &parent = QModelIndex()) const;
//    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

signals:
    void addNewDataChanged(int iTimeSec);

private:
    QList<QList<qreal> *> m_data;
    int m_columnCount;
    int m_rowCount;
    int m_timeCount;
    QTimer* m_timer;
};

#endif // HEARTRATEDATAMODEL_H
