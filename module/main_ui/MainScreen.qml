import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {

    Column {
        anchors.fill: parent
        spacing: 1

        //System status bar
        Rectangle
        {
            id: system_status_bar
            width: parent.width
            height: 60
            color: "#001C30"

            Timer {
                interval: 1000;
                running: true;
                repeat: true
                onTriggered: datetime.text = Qt.formatDateTime(new Date(), "hh:mm A") + "\n"
                                              + Qt.formatDateTime(new Date(), "dd/MM/yyyy")
            }

            RowLayout
            {
                anchors.fill: parent
                spacing: 10
                //Setting
                Button
                {
                    id: setting_menu_btn
                    Layout.fillHeight: true
                    Layout.minimumWidth: 60
                    Layout.preferredWidth: 90
                    font.family: "Arial"
                    font.pointSize: 14
                    text: "Setting"

                    onClicked:
                    {
                        console.log("Display setting menu")
                    }
                }
                //Info
                Label
                {
                    id: patient_info
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 14
                    font.family: "Arial"
                    color: "#F5F5F5"
                    text: "N/A"


                }
                //Network
                Image
                {
                    id: nw_status
                    sourceSize.width: 30
                    state: "Disconnected"

                    states: [
                        State{
                            name: "Connected"
                            PropertyChanges {
                                target: nw_status;
                                source: "qrc:/images/WiFi_Connected.png" }},
                        State{
                            name: "Disconnected"
                            PropertyChanges {
                                target: nw_status;
                                source: "qrc:/images/WiFi_Disconnected.png" }
                        }]
                }
                //Speaker
                Image
                {
                    id: sound_status
                    sourceSize.width: 30
                    state: "Mute"

                    states: [
                        State{
                            name: "Unmute"
                            PropertyChanges {
                                target: sound_status;
                                source: "qrc:/images/Mute_Sound.png" }},
                        State{
                            name: "Mute"
                            PropertyChanges {
                                target: sound_status;
                                source: "qrc:/images/Mute_Sound.png" }
                        }]
                }
                //Battery
                Image
                {
                    id: battery_status
                    sourceSize.width: 45
                    source: "qrc:/images/Bat_Shape.png"
                    Text
                    {
                        id: battery_percentage
                        anchors.centerIn: parent
                        font.family: "Arial"
                        font.pointSize: 10
                        color: "#F7FFE5"
                        text: "--/--"
                    }
                }
                //Datetime
                Label
                {
                    id: datetime
                    Layout.fillHeight: true
                    Layout.minimumWidth: 90
                    Layout.preferredWidth: 95
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Arial"
                    font.pointSize: 12
                    color: "#F7FFE5"
                    text: Qt.formatDateTime(new Date(), "hh:mm A") + "\n"
                          + Qt.formatDateTime(new Date(), "dd/MM/yyyy")
                }
            }
        }
        HeartRateArea
        {
            width: parent.width
            height: (parent.height - system_status_bar.height)/2
        }
        RespRateArea
        {
            width: parent.width
            height: (parent.height - system_status_bar.height)/2
        }
    }
}
