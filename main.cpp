#include <QApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include "heartRateDataModel.h"
#include "sensorDataThread.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    HeartRateDataModel heartRateModel;
    TemperatureDataModel tempModel;
    SensorDataThread sensorThread(&heartRateModel, &tempModel);

    sensorThread.start();
    engine.rootContext()->setContextProperty("heartRateModel", &heartRateModel);
    engine.rootContext()->setContextProperty("temperatureModel", &tempModel);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
