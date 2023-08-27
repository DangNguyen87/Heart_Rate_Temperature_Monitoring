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
            antialiasing: true
            plotArea: Qt.rect(0, 0, width, height)
            clip: true
            focus: true
            //dropShadowEnabled: true
            //backgroundColor: "transparent"
            //plotAreaColor: "transparent"

            LineSeries {
                name: "Line"
                //style: Qt.DotLine
                //width: 4.0
                XYPoint { x: 0; y: 0 }
                XYPoint { x: 1.1; y: 2.1 }
                XYPoint { x: 1.9; y: 3.3 }
                XYPoint { x: 2.1; y: 2.1 }
                XYPoint { x: 2.9; y: 4.9 }
                XYPoint { x: 3.4; y: 3.0 }
                XYPoint { x: 4.1; y: 3.3 }
            }

            LineSeries {
                name: "Line 1"
                //style: Qt.DotLine
                //width: 4.0
                XYPoint { x: 0; y: 1 }
                XYPoint { x: 1.1; y: 3.1 }
                XYPoint { x: 1.9; y: 4.3 }
                XYPoint { x: 2.1; y: 4.1 }
                XYPoint { x: 2.9; y: 5.9 }
                XYPoint { x: 3.4; y: 4.0 }
                XYPoint { x: 4.1; y: 3.3 }
            }
        }
        Label
        {
            Layout.fillHeight: true
            Layout.minimumWidth: 60
            Layout.preferredWidth: 90
            text: "Data"
            font.family: "Arial"
            font.pointSize: 12
            //color: JsUtil.set_color(index)
        }
        Label
        {
            Layout.fillHeight: true
            Layout.minimumWidth: 60
            Layout.preferredWidth: 90
            text: "N/A"
            font.family: "Arial"
            //color: JsUtil.set_color(index)
            font.pointSize: 30
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }
        Label
        {
            Layout.fillHeight: true
            Layout.minimumWidth: 60
            Layout.preferredWidth: 90
            font.family: "Arial"
            text: "Unit"
            font.pointSize: 9
            Layout.alignment: Qt.AlignRight
            //color: JsUtil.set_color(index)
        }
    }
}
