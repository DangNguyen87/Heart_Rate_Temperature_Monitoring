#include <QApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include "heartRateDataModel.h"
#include "sensorDataThread.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    HeartRateDataModel heartRateModel;
    TemperatureDataModel tempModel;
    SensorDataThread sensorThread(&heartRateModel, &tempModel);

    sensorThread.start();
    engine.rootContext()->setContextProperty("heartRateModel", &heartRateModel);
    engine.rootContext()->setContextProperty("temperatureModel", &tempModel);

    const QUrl url(u"qrc:/Continuous_Patient_Monitoring/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
