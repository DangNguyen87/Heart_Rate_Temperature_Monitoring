import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Item {
    id: temp_ui_root
    required property color tempUiTextColor;

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
            text: temperatureModel.TSKIN_MAX_RANGE + "\n" + temperatureModel.TSKIN_MIN_RANGE
        }
        Label {
            id: tskin_value
            Layout.fillHeight: true
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Arial"
            font.pointSize: 30
            color: temp_ui_root.tempUiTextColor
            text: ""
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
            text: temperatureModel.TRECT_MAX_RANGE + "\n" + temperatureModel.TRECT_MIN_RANGE
        }
        Label {
            id: trect_value
            Layout.fillHeight: true
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Arial"
            font.pointSize: 30
            color: temp_ui_root.tempUiTextColor
            text: ""
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
            id: temp_diff
            Layout.fillHeight: true
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Arial"
            font.pointSize: 25
            color: temp_ui_root.tempUiTextColor
            text: ""
        }
    }
    // Bottom border
    Rectangle {
        height: 1
        width: parent.width
        anchors.bottom: parent.bottom
        opacity: 0.5
        color: temp_ui_root.tempUiTextColor
    }
    Connections {
        /* Scroll graph when has new value outside the frame of the graph */
        target: temperatureModel
        function onTemperatureDataChanged(tSkin, tRect)
        {
            tskin_value.text = tSkin.toFixed(1)
            trect_value.text = tRect.toFixed(1)
            temp_diff.text = "(" + (tRect - tSkin).toFixed(1) + ")"
        }
    }
}
