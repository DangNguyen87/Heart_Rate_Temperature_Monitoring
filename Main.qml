import QtQuick
import QtQuick.Window
import QtCharts

Window {
    id: root
    minimumWidth: 960
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
        main_screen_loader.source = "qrc:/Continuous_Patient_Monitoring/module/main_ui/MainScreen.qml"
    }
}
