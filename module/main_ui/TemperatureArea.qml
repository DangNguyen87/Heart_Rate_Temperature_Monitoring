import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Item {
    id: temp_ui_root
    required property color tempUiTextColor;

    Rectangle {
        anchors.fill: parent
        GridLayout {
            anchors.fill: parent
            anchors.bottomMargin : 10
            rows: 3
            columns: 4

            Label {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.rowSpan: 3
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignTop
                font.family: "Arial"
                color: temp_ui_root.tempUiTextColor
                textFormat: Text.RichText
                text: "<div style='font-size: 14pt;'>TEMP</div>
                       <div style='font-size: 10pt;'>&#8451;</div>"
            }
            Label {
                Layout.fillHeight: true
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignBottom
                font.family: "Arial"
                font.pointSize: 10
                color: temp_ui_root.tempUiTextColor
                text: "38.5\n36.0"
            }
            Label {
                Layout.fillHeight: true
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Arial"
                font.pointSize: 30
                color: temp_ui_root.tempUiTextColor
                text: "36.0"
            }
            Label {
                Layout.fillHeight: true
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                font.family: "Arial"
                font.pointSize: 10
                color: temp_ui_root.tempUiTextColor
                text: "Tskin"
            }
            Label {
                Layout.fillHeight: true
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignBottom
                font.family: "Arial"
                font.pointSize: 10
                color: temp_ui_root.tempUiTextColor
                text: "39.0\n36.0"
            }
            Label {
                Layout.fillHeight: true
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Arial"
                font.pointSize: 30
                color: temp_ui_root.tempUiTextColor
                text: "37.0"
            }
            Label {
                Layout.fillHeight: true
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                font.family: "Arial"
                font.pointSize: 10
                color: temp_ui_root.tempUiTextColor
                text: "Trect"
            }
            Label {
                Layout.fillHeight: true
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignTop
                font.family: "Arial"
                font.pointSize: 10
                color: temp_ui_root.tempUiTextColor
                text: "TD"
            }
            Label {
                Layout.fillHeight: true
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Arial"
                font.pointSize: 30
                color: temp_ui_root.tempUiTextColor
                text: "(2.0)"
            }
        }
        // Bottom border
        Rectangle {
            height: 1
            width: parent.width
            anchors.bottom: parent.bottom
            color: temp_ui_root.tempUiTextColor
        }
    }
}
