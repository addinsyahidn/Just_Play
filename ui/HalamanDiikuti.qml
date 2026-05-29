import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

Rectangle {
    id: halaman_diikuti
    anchors.fill: parent
    clip: true
    color: "#F6F0FC"

    Connections {
        target: DataManager

        function onFollowedArtistClearRequested() {
            artistModel.clear()
        }

        function onFollowedArtistFetched(artistName, artistImg) {
            artistModel.append({
                "NamaArtis": artistName,
                "ImgArtis": artistImg !== "" ? artistImg : "assets/artist_placeholder.png"
            })
        }
    }

    // 1. HEADER HALAMAN
    Column {
        id: mainContent
        width: parent.width
        spacing: 20 * root.dp
        Item { width: 1; height: 30 * root.dp }

        Rectangle {
            id: header
            width: parent.width
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
                text: "Diikuti"
                anchors.centerIn: parent
                font.family: "Inter"
                font.pixelSize: 17 * root.dp
                font.weight: Font.DemiBold
                color: "#000000"
            }
        }
    }

    Component.onCompleted: {
        artistModel.clear()
        DataManager.fetchFollowedArtists(root.globalLocalId, root.globalIdToken)
    }

    // 2. DAFTAR ARTIS (LISTVIEW)
    ListView {
        id: artistList
        width: parent.width
        anchors.top: mainContent.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 16 * root.dp
        clip: true

        model: ListModel { id: artistModel }

        delegate: Item {
            width: artistList.width
            height: 90 * root.dp // Dikembalikan ke tinggi konstan

            Row {
                anchors.fill: parent
                anchors.leftMargin: 16 * root.dp
                spacing: 16 * root.dp

                Rectangle {
                    width: 64 * root.dp
                    height: 64 * root.dp
                    radius: width / 2
                    color: "#dbdbdb"
                    clip: true
                    anchors.verticalCenter: parent.verticalCenter

                    Image {
                        source: model.ImgArtis.startsWith("http") ? model.ImgArtis : Qt.resolvedUrl(model.ImgArtis)
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                Text {
                    text: model.NamaArtis
                    font.family: "Inter"
                    font.pixelSize: 16 * root.dp
                    font.bold: true
                    color: "#000000"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    myStack.push("HalamanKategori.qml", {
                        "kategori": "penyanyi",
                        "penyanyi": model.NamaArtis
                    })
                }
            }
        }
    }
}
