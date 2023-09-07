import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtCharts

Item {
    required property color hrUiTextColor;
    RowLayout {
        anchors.fill: parent
        spacing: 5
        ChartView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            legend.visible: false
            plotArea: Qt.rect(0, 0, width, height - 1)
            plotAreaColor: "white"
            dropShadowEnabled: true
            antialiasing: true
            clip: true

            LineSeries {
                id: heart_rate_seri
                width: 2
                color: hrUiTextColor
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
        }
        Column {
            Layout.fillHeight: true
            Layout.minimumWidth: 200
            Layout.preferredWidth: 250
            spacing: 10

            Row {
                height: parent.height / 4
                width: parent.width

                Label {
                    height: parent.height
                    width: 50
                    font.family: "Arial"
                    color: hrUiTextColor
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
                    color: hrUiTextColor
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
                    color: hrUiTextColor
                    text: "0"
                }
                Label {
                    height: parent.height
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignBottom
                    font.family: "Arial"
                    font.pointSize: 9
                    color: hrUiTextColor
                    text: ""
                }
            }
            Rectangle {
                height: parent.height * 1 / 4
                width: parent.width
                TemperatureArea {
                    anchors.fill: parent
                    tempUiTextColor: "orange"
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
