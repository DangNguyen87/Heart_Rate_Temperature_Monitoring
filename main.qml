import QtQuick 2.15
import QtCharts

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ChartView {
        title: "Line Chart"
        anchors.fill: parent
        antialiasing: true

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

//    ChartView {
//        id: chart
//        title: "Top-5 car brand shares in Finland"
//        anchors.fill: parent
//        legend.alignment: Qt.AlignBottom
//        antialiasing: true

//        property variant othersSlice: 0

//        PieSeries {
//            id: pieSeries
//            PieSlice { label: "Volkswagen"; value: 13.5 }
//            PieSlice { label: "Toyota"; value: 10.9 }
//            PieSlice { label: "Ford"; value: 8.6 }
//            PieSlice { label: "Skoda"; value: 8.2 }
//            PieSlice { label: "Volvo"; value: 6.8 }
//        }

//        Component.onCompleted: {
//            // You can also manipulate slices dynamically, like append a slice or set a slice exploded
//            othersSlice = pieSeries.append("Others", 52.0);
//            pieSeries.find("Volkswagen").exploded = true;
//        }
//    }
}
