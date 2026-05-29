import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

import "../components"

Rectangle {
    id: halamanNotifikasi
    objectName: "Notifikasi"

    anchors.fill: parent
    clip: true
    color: "#F6F0FC"

    function getFormattedDate() {
        const date = new Date();
        const months = [
            "Januari", "Februari", "Maret", "April", "Mei", "Juni",
            "Juli", "Agustus", "September", "Oktober", "November", "Desember"
        ];

        let day = date.getDate();
        let month = months[date.getMonth()];
        let year = date.getFullYear();

        return day + " " + month + " " + year;
    }

    Item {
        id: topSpacer
        width: parent.width
        height: 50 * root.dp
        anchors.top: parent.top
    }

    Rectangle {
        id: header
        width: parent.width
        anchors.top: topSpacer.bottom
        height: 42 * root.dp
        color: "#E0D4F0"

        Shape {
            id: chevron_left_thin
            x: 16 * root.dp;
            anchors.verticalCenter: parent.verticalCenter
            width: 9.49; height: 16.86

            MouseArea {
                anchors.fill: parent
                anchors.margins: -10 * root.dp
                onClicked: {
                    myStack.pop()
                }
            }

            ShapePath {
                fillColor: "#000000"
                PathSvg { path: "M 2.338 8.429 L 9.348 1.419 C 9.543 1.223 9.543 0.907 9.348 0.712 L 8.782 0.146 C 8.587 -0.048 8.270 -0.048 8.075 0.146 L 0.146 8.075 C -0.048 8.270 -0.048 8.587 0.146 8.782 L 8.075 16.712 C 8.270 16.907 8.587 16.907 8.782 16.712 L 9.348 16.146 C 9.543 15.951 9.543 15.634 9.348 15.439 L 2.338 8.429 Z" }
            }
        }

        Text {
            text: "Notifikasi"
            anchors.centerIn: parent
            font.family: "Inter"
            font.pixelSize: 17 * root.dp
            font.weight: Font.DemiBold
            color: "#000000"
        }
    }

    Image {
        id: items
        clip: true
        source: Qt.resolvedUrl("assets/items.png")

        anchors.top: header.bottom
        anchors.bottom: navigationBar.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 20 * root.dp
        anchors.bottomMargin: 10 * root.dp

        Text {
            text: "Belum ada notifikasi baru"
            color: "#80ffffff"
            font.family: "Inter"
            font.pixelSize: 14 * root.dp
            anchors.centerIn: parent
            visible: notificationList.count === 0
        }

        ListView {
            id: notificationList
            anchors.fill: parent
            anchors.leftMargin: 16 * root.dp
            anchors.rightMargin: 16 * root.dp
            clip: true
            spacing: 13 * root.dp

            // 1. TAMBAHKAN PROPERTI 'link' DI MODEL DONASI
            model: typeof root.globalNotificationModel !== "undefined" ? root.globalNotificationModel : [
                {
                    judul: "Selamat Datang! ✨",
                    tanggal: halamanNotifikasi.getFormattedDate(),
                    isi: "Halo! Selamat datang di aplikasi Just Play. Selamat menikmati lagu-lagu favoritmu dan selamat bernyanyi! 🎤 Sepuasnya tanpa batas waktu bersama teman-teman.",
                    linkDonasi: "" // Tidak ada link
                },
                {
                    judul: "Dukung Just Play (Donasi) 🙏",
                    tanggal: halamanNotifikasi.getFormattedDate(),
                    isi: "Hai! Jika kamu suka dengan aplikasi ini, yuk bantu developer dengan berdonasi agar aplikasi ini tetap terus berkembang dan bebas iklan. Terima kasih banyak atas dukunganmu! :v Kamu bisa berdonasi melalui link e-wallet resmi yang tersedia.",
                    linkDonasi: "https://trakteer.id" // TULIS LINK DONASI DISINI
                }
            ]

            delegate: Rectangle {
                id: itemWrapper
                width: notificationList.width

                // 2. SESUAIKAN TINGGI DENGAN TAMBAHAN TOMBOL DONASI
                height: isExpanded ? Math.max(107 * root.dp, isi_dari_notifikasi.y + isi_dari_notifikasi.implicitHeight + (modelData.linkDonasi ? 40 * root.dp : 16 * root.dp)) : 107 * root.dp
                clip: true

                color: "#F0E6F7"
                radius: 12 * root.dp

                property bool isExpanded: false

                Behavior on height {
                    NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                }

                Item {
                    id: info
                    anchors.fill: parent
                    anchors.margins: 12 * root.dp

                    Text {
                        id: judul_Notifikasi
                        width: parent.width - 24 * root.dp
                        height: 20 * root.dp
                        color: "#1a0826"
                        elide: Text.ElideRight
                        font.family: "Inter"
                        font.pixelSize: 14 * root.dp
                        font.weight: Font.DemiBold
                        verticalAlignment: Text.AlignVCenter
                        text: modelData.judul || modelData.title || ""
                    }

                    Text {
                        id: tanggal_dikirim
                        y: 22 * root.dp
                        width: parent.width
                        height: 18 * root.dp
                        color: "#6b5b7b"
                        font.family: "Inter"
                        font.pixelSize: 11 * root.dp
                        font.weight: Font.Normal
                        verticalAlignment: Text.AlignVCenter
                        text: modelData.tanggal || modelData.timestamp || ""
                    }

                    Text {
                        id: isi_dari_notifikasi
                        y: 44 * root.dp
                        width: parent.width

                        // Jika tidak di-expand, tinggi teks tetap 45. Jika di-expand dan ada link, beri batas agar teks tidak menubruk link.
                        height: itemWrapper.isExpanded ? implicitHeight : 45 * root.dp
                        elide: itemWrapper.isExpanded ? Text.ElideNone : Text.ElideRight

                        color: "#2c1e3d"
                        font.family: "Inter"
                        font.letterSpacing: 0.12
                        font.pixelSize: 12 * root.dp
                        font.weight: Font.Medium
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.Wrap
                        text: modelData.isi || modelData.body || modelData.message || ""
                    }

                    // 3. TAMBAHKAN TEKS / TOMBOL LINK DONASI YANG INTERAKTIF
                    Text {
                        id: tombolDonasi
                        // Posisinya berada di bawah teks isi notifikasi dengan jarak 8dp
                        y: isi_dari_notifikasi.y + isi_dari_notifikasi.height + 8 * root.dp
                        width: parent.width

                        // Hanya muncul jika notifikasi di-expand DAN ada data linkDonasi di modelnya
                        visible: itemWrapper.isExpanded && (modelData.linkDonasi ? true : false)

                        text: "Klik di sini untuk Donasi 🚀"
                        color: "#8A2BE2" // Warna ungu link cerah agar kontras
                        font.family: "Inter"
                        font.pixelSize: 12 * root.dp
                        font.weight: Font.Bold
                        font.underline: true // Efek garis bawah khas link digital

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor // Mengubah kursor jadi lambang jari menunjuk
                            onClicked: {
                                if (modelData.linkDonasi) {
                                    Qt.openUrlExternally(modelData.linkDonasi)
                                }
                            }
                        }
                    }
                }

                // MouseArea utama untuk expand/collapse kartu
                MouseArea {
                    anchors.fill: parent
                    // Z-index direndahkan agar tidak menutupi MouseArea milik tombolDonasi di atasnya
                    z: -1
                    onClicked: itemWrapper.isExpanded = !itemWrapper.isExpanded
                }
            }
        }
    }
}
