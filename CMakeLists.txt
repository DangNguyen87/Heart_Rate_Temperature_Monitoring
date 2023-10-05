cmake_minimum_required(VERSION 3.16)

project(Continuous_Patient_Monitoring VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Charts)

qt_standard_project_setup()

qt_add_executable(appContinuous_Patient_Monitoring
    main.cpp
    temperatureDataModel.h temperatureDataModel.cpp
    temperatureData.h temperatureData.cpp
    sensorDataThread.h sensorDataThread.cpp
    heartRateDataModel.h heartRateDataModel.cpp
    ecgData.h ecgData.cpp
)

qt_add_qml_module(appContinuous_Patient_Monitoring
    URI Continuous_Patient_Monitoring
    VERSION 1.0
    QML_FILES Main.qml
    QML_FILES module/main_ui/HeartRateArea.qml module/main_ui/MainScreen.qml module/main_ui/TemperatureArea.qml module/setting_ui/setting_menu.qml
    RESOURCES Resources.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appContinuous_Patient_Monitoring PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appContinuous_Patient_Monitoring
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appContinuous_Patient_Monitoring
    PRIVATE Qt6::Quick Qt6::Charts
)

include(GNUInstallDirs)
install(TARGETS appContinuous_Patient_Monitoring
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
