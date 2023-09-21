#ifndef HEARTRATEDATAMODEL_H
#define HEARTRATEDATAMODEL_H

#include <QAbstractTableModel>
#include <QObject>
#include <QTimer>
#include <QMutex>
#include <QQueue>
#include "ecgData.h"

#define HR_SHARED_CONSTANT(type, name, value) \
                static inline const type name = value; \
                Q_PROPERTY(type name MEMBER name CONSTANT)

class HeartRateDataModel : public QAbstractTableModel
{
    Q_OBJECT

public:
    HR_SHARED_CONSTANT(int, HR_ROW_COUNT, 100);
    HR_SHARED_CONSTANT(int, HR_COLUMN_COUNT, 2);
    HR_SHARED_CONSTANT(float, HR_MAX_VALUE, 100.0);

    enum HR_COLUMN
    {
        COLUMN_TIME_STAMP = 0,
        COLUMN_HEART_RATE
    };
    explicit HeartRateDataModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    int columnCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

    void addEcgData(EcgData *ecg);
public slots:
    void dataUpdate();

signals:
    void addNewDataChanged(float xValue, float yValue);

private:
    QList<QList<qreal> *> m_data;
    QQueue<EcgData*> m_ecgData;
    QMutex m_ecgDataMutex;
    QTimer* m_timer;
    int m_timeCount;
    qint64 m_preTimeStamp;
};

#endif // HEARTRATEDATAMODEL_H
