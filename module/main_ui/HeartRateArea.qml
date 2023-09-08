import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtCharts

Item {
    id: hr_ui_root
    required property color hrUiTextColor;

    RowLayout {
        anchors.fill: parent
        spacing: 5

        ChartView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 750
            legend.visible: false
            plotArea: Qt.rect(0, 0, width, height - 1)
            plotAreaColor: "white"
            dropShadowEnabled: true
            antialiasing: true
            clip: true

            LineSeries {
                id: heart_rate_seri
                width: 2
                color: hr_ui_root.hrUiTextColor
                axisX: ValueAxis {
                            id: axis_x_heart_rate
                            min: 0;
                            max: heartRateModel.HR_ROW_COUNT;
                            visible: true ;
                            labelsVisible: false;
                            gridVisible: false}
                axisY: ValueAxis {
                            id: axis_y_heart_rate
                            min: 0;
                            max: heartRateModel.HR_MAX_VALUE;
                            visible: true;
                            lineVisible:false;
                            labelsVisible:false;
                            gridVisible: true;
                            tickCount: 11}
            }
            //Query the data from cpp based on the position of column
            VXYModelMapper {
                model: heartRateModel
                series: heart_rate_seri
                xColumn: 0
                yColumn: 1
            }
            // Right border
            Rectangle {
                height: parent.height
                width: 1
                anchors.right: parent.right
                opacity: 0.5
                color: "lightgray"
            }
        }
        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: 250
            Layout.maximumWidth: 300

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Row {
                        anchors.fill: parent
                        Label {
                            height: parent.height
                            width: 50
                            font.family: "Arial"
                            color: hr_ui_root.hrUiTextColor
                            textFormat: Text.RichText
                            text: "<div style='font-size: 14pt;'>HR</div>
                                   <div style='font-size: 10pt;'>bmp</div>"
                        }
                        Label {
                            height: parent.height
                            width: 50
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignBottom
                            font.family: "Arial"
                            font.pointSize: 12
                            color: hr_ui_root.hrUiTextColor
                            text: "120\n60"
                        }
                        Label {
                            id: heart_rate_value
                            height: parent.height
                            width: 100
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Arial"
                            font.pointSize: 60
                            font.bold: true
                            color: hr_ui_root.hrUiTextColor
                            text: "0"
                        }
                    }
                    // Bottom border
                    Rectangle {
                        height: 1
                        width: parent.width
                        anchors.bottom: parent.bottom
                        opacity: 0.5
                        color: hr_ui_root.hrUiTextColor
                    }
                }
                TemperatureArea {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    tempUiTextColor: "orange"
                }
                // Dummy item to fill empty space
                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            }
        }
        Connections {
            /* Scroll graph when has new value outside the frame of the graph */
            target: heartRateModel
            function onAddNewDataChanged(xValue, yValue) {
                if(xValue >= axis_x_heart_rate.max) {
                    var axisLen = axis_x_heart_rate.max - axis_x_heart_rate.min
                    axis_x_heart_rate.max = xValue + 1
                    axis_x_heart_rate.min = axis_x_heart_rate.max - axisLen
                }
                heart_rate_value.text = yValue
            }
        }
    }
}
