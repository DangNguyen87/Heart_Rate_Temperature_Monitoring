import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtCharts

Item {
    RowLayout {
        anchors.fill: parent
        spacing: 5
        ChartView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            legend.visible: false
            plotArea: Qt.rect(0, 0, width, height)
            plotAreaColor: "white"
            antialiasing: true
            clip: true
            //Todo: data expose from model (max x, max y), color, line style
            //Number of chart gird line

            LineSeries {
                id: heart_rate_seri
                axisX: ValueAxis {
                    id: axis_x_heart_rate
                    min: 0; max: 100; visible: true ;
                    labelsVisible: false; gridVisible: false}
                axisY: ValueAxis {
                    min: 0; max: 100; visible: true;
                    labelsVisible:false; gridVisible: true}
                name: "Line"
            }
            //Query the data from cpp based on the position of column
            VXYModelMapper
            {
                model: heartRateModel
                series: heart_rate_seri
                xColumn: 0
                yColumn: 1
            }
        }
        Label
        {
            id: _title_MF
            Layout.fillHeight: true
            Layout.minimumWidth: 60
            Layout.preferredWidth: 90
            text: "Data"
            font.family: "Arial"
            font.pointSize: 12
        }
        Label
        {
            id: _value_MF
            Layout.fillHeight: true
            Layout.minimumWidth: 60
            Layout.preferredWidth: 90
            text: "N/A"
            font.family: "Arial"
            font.pointSize: 30
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }
        Label
        {
            id: _unit_MF
            Layout.fillHeight: true
            Layout.minimumWidth: 60
            Layout.preferredWidth: 90
            font.family: "Arial"
            text: "Unit"
            font.pointSize: 9
            Layout.alignment: Qt.AlignRight
        }
        Connections
        {
            /* Scroll graph when has new value outside the frame of the graph */
            target: heartRateModel
            function onAddNewDataChanged(timeValue)
            {
                if(timeValue >= axis_x_heart_rate.max)
                {
                    var axisXLen = axis_x_heart_rate.max - axis_x_heart_rate.min
                    axis_x_heart_rate.max = timeValue + 1
                    axis_x_heart_rate.min = axis_x_heart_rate.max - axisXLen
                }
            }
        }
    }
}
