cmake_minimum_required(VERSION 3.27)

project(qml_playground LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_PREFIX_PATH "C:/Qt/6.7.1/mingw_64/")
find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick Qml)

qt_standard_project_setup(REQUIRES 6.5)


add_library(qml_playground SHARED
        library.cpp
        library.h)


set(qml_resource_files
        "qml/AlarmDelegate.qml"
        "qml/AlarmDialog.qml"
        "qml/AlarmModel.qml"
        "qml/TumblerDelegate.qml"
        "qml/main.qml"
)

qt_add_resources(qml_playground "qml"
        PREFIX
        "/"
        FILES
        ${qml_resource_files}
)

qt_add_resources(qml_playground "controls_conf"
        PREFIX
        "/"
        FILES
        "qtquickcontrols2.conf"
)


SET_TARGET_PROPERTIES(qml_playground PROPERTIES PREFIX "")
target_link_libraries(qml_playground PUBLIC Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick)
target_link_options(qml_playground PUBLIC -static-libgcc -static-libstdc++ -static)


qt_add_executable(qml_playground_test main.cpp)
target_link_libraries(qml_playground_test PUBLIC qml_playground)
target_link_options(qml_playground PUBLIC -static-libgcc -static-libstdc++ -static)


string(TOLOWER ${CMAKE_BUILD_TYPE} build_type)
if (build_type STREQUAL "release")
    add_custom_command(TARGET qml_playground POST_BUILD
            COMMAND windeployqt --qmldir ${CMAKE_CURRENT_SOURCE_DIR}/qml --${build_type} $<TARGET_FILE:qml_playground>
    )
endif ()
