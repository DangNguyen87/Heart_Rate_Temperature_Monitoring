import QtQuick 2.15
import QtCharts

Window {
    id: root
    minimumWidth: 640
    minimumHeight: 480
    visible: true
    title: qsTr("Continuous Patient Monitoring")

    Loader
    {
        id: main_screen_loader
        clip: true
        anchors.fill: parent
    }

    Component.onCompleted:
    {
        main_screen_loader.source = "qrc:/module/main_ui/MainScreen.qml"
    }
}
