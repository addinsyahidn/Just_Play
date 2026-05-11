import QtQuick
import QtQuick.Controls

Window {
    id: root
    width: 360
    height: 640
    visible: true
    title: qsTr("Karaoke App")
    property real dp: width / 360

    StackView {
            id: myStack
            anchors.fill: parent

            initialItem: "HalamanUtama.qml"
    }
}