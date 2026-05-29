import QtQuick
import QtQuick.Controls

Rectangle {
    id: splash_screen

    // Mengikuti ukuran jendela induk secara otomatis agar responsif di HP
    anchors.fill: parent
    clip: true

    // 1. Menyederhanakan Gradasi Menggunakan Properti bawaan Rectangle
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#000000" }
        GradientStop { position: 1.0; color: "#9b49f2" }
    }

    // 2. Konten Tengah (Logo dan Teks) dibungkus Column agar posisinya otomatis rapi
    Column {
        anchors.centerIn: parent
        spacing: 24

        Image {
            id: logo_removebg_preview_1
            source: Qt.resolvedUrl("assets/logo_removebg_preview_1.png")
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Image {
            id: whatsApp_UI
            source: Qt.resolvedUrl("assets/whatsApp_UI_1.png")
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: karaoke_Anytime_
            color: "#ffffff"
            font { family: "Modern Antiqua"; letterSpacing: -0.33; pixelSize: 20; weight: Font.Medium }
            horizontalAlignment: Text.AlignHCenter
            text: "-- karaoke Anytime --"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
