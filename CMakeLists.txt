cmake_minimum_required(VERSION 3.16)

project(KaraokeApp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Network)

qt_standard_project_setup(REQUIRES 6.10)

include_directories(include)

qt_add_executable(appKaraokeApp
    main.cpp
)

file(GLOB_RECURSE QML_COMPONENTS_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "ui/*.qml" "components/*.qml")
file(GLOB_RECURSE ASSETS_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "ui/assets/*")

# 2. Tambahkan ke module
qt_add_qml_module(appKaraokeApp
    URI appKaraokeApp
    QML_FILES
        ${QML_COMPONENTS_FILES}
    RESOURCES
        ${ASSETS_FILES}
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appKaraokeApp PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appKaraokeApp
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appKaraokeApp
    PRIVATE Qt6::Quick Qt6::Network
)

install(TARGETS appKaraokeApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
