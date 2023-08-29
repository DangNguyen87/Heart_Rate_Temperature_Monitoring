import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtCharts

Item {
    property color hrUiColor;
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
            //Todo:
            //    add temperature UI
            //    Implement queue and sensor thread

            LineSeries {
                id: heart_rate_seri
                width: 2
                color: hrUiColor
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
            Layout.fillHeight: true
            Layout.minimumWidth: 60
            Layout.preferredWidth: 90
            font.family: "Arial"
            font.pointSize: 12
            color: hrUiColor
            text: "HR"
        }
        Label
        {
            id: heart_rate_value
            Layout.fillHeight: true
            Layout.minimumWidth: 60
            Layout.preferredWidth: 90
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Arial"
            font.pointSize: 30
            font.bold: true
            color: hrUiColor
            text: "0"
        }
        Label
        {
            Layout.fillHeight: true
            Layout.minimumWidth: 60
            Layout.preferredWidth: 90
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignBottom
            font.family: "Arial"
            font.pointSize: 9
            color: hrUiColor
            text: "Cycle/Min"
        }
        Connections
        {
            /* Scroll graph when has new value outside the frame of the graph */
            target: heartRateModel
            function onAddNewDataChanged(xValue, yValue)
            {
                if(xValue >= axis_x_heart_rate.max)
                {
                    var axisLen = axis_x_heart_rate.max - axis_x_heart_rate.min
                    axis_x_heart_rate.max = xValue + 1
                    axis_x_heart_rate.min = axis_x_heart_rate.max - axisLen
                }
                heart_rate_value.text = yValue
            }
        }
    }
}
