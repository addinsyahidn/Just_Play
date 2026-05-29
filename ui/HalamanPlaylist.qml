import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    id: halaman_Playlist
    objectName: "Playlist"
    anchors.fill: parent
    clip: true
    color: "#F6F0FC"

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
                text: "Playlist"
                anchors.centerIn: parent
                font.family: "Inter"
                font.pixelSize: 17 * root.dp
                font.weight: Font.DemiBold
                color: "#000000"
            }
        }
    }

    ListView {
        id: playlistList
        anchors.top: mainContent.bottom
        anchors.bottom: bottomInputArea.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 10 * root.dp
        anchors.bottomMargin: 10 * root.dp
        spacing: 0
        clip: true

        model: ListModel {
            id: localPlaylistModel
        }

        Connections {
            target: DataManager

            function onPlaylistFetchStarted() {
                localPlaylistModel.clear()
            }

            function onPlaylistFetched(playlistName, songCountInfo) {
                if (playlistName !== "" && playlistName !== "EMPTY_PLAYLIST") {
                    localPlaylistModel.append({
                        "PlName": playlistName,
                        "PlSongs": songCountInfo,
                        "img": "assets/placeholder1.png"
                    })
                }
            }

            function onPlaylistDeleted(playlistName) {
                for (var i = 0; i < localPlaylistModel.count; i++) {
                    if (localPlaylistModel.get(i).PlName === playlistName) {
                        localPlaylistModel.remove(i)
                        break
                    }
                }
            }
        }

        Timer {
            id: refreshTimer
            interval: 1200
            repeat: false
            onTriggered: {
                DataManager.fetchUserPlaylists(root.globalLocalId, root.globalIdToken)
            }
        }

        Component.onCompleted: {
            localPlaylistModel.clear()
            DataManager.fetchUserPlaylists(root.globalLocalId, root.globalIdToken)
        }

        delegate: Item {
            width: playlistList.width
            height: 100 * root.dp

            RowLayout {
                anchors.fill: parent
                anchors.topMargin: 8 * root.dp
                anchors.leftMargin: 16 * root.dp
                anchors.rightMargin: 16 * root.dp
                spacing: 12 * root.dp

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Row {
                        anchors.fill: parent
                        spacing: 12 * root.dp
                        Image {
                            source: Qt.resolvedUrl("assets/playlist_placeholder.png")
                            width: 84 * root.dp
                            height: 84 * root.dp
                            fillMode: Image.PreserveAspectCrop
                        }
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 4 * root.dp
                            Text {
                                text: model.PlName
                                font.family: "Inter"
                                font.pixelSize: 14 * root.dp
                                font.bold: true
                                color: "#000000"
                            }
                            Text {
                                text: model.PlSongs
                                font.family: "Inter"
                                font.pixelSize: 12 * root.dp
                                color: "#828282"
                            }
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            myStack.push("HalamanKategori.qml", {
                                             "mode": "playlist",
                                             "targetName": model.PlName
                                         })
                        }
                    }
                }

                Rectangle {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: 64 * root.dp
                    Layout.preferredHeight: 34 * root.dp
                    radius: 8 * root.dp
                    color: hapusTouch.pressed ? "#F0F0F0" : "#FFFFFF"
                    border.width: 1
                    border.color: "#DDDDDD"

                    Behavior on color { ColorAnimation { duration: 80 } }

                    Text {
                        anchors.centerIn: parent
                        text: "Hapus"
                        font.family: "Inter"
                        font.pixelSize: 13 * root.dp
                        font.weight: Font.Medium
                        color: "#000000"
                    }

                    MouseArea {
                        id: hapusTouch
                        anchors.fill: parent
                        onClicked: {
                            DataManager.deleteUserPlaylist(
                                        root.globalLocalId,
                                        root.globalIdToken,
                                        model.PlName
                                        )
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: bottomInputArea
        width: parent.width
        height: 72 * root.dp
        color: "#F6F0FC"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        Rectangle {
            anchors.fill: parent
            anchors.leftMargin: 16 * root.dp
            anchors.rightMargin: 16 * root.dp
            anchors.topMargin: 8 * root.dp
            anchors.bottomMargin: 8 * root.dp
            color: "#EAD6FA"
            radius: 8 * root.dp

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 16 * root.dp
                anchors.rightMargin: 16 * root.dp
                spacing: 12 * root.dp

                TextInput {
                    id: newPlaylistInput
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter
                    font.family: "Inter"
                    font.pixelSize: 14 * root.dp
                    color: "#000000"
                    verticalAlignment: TextInput.AlignVCenter

                    Text {
                        text: "Buat playlist baru..."
                        visible: !newPlaylistInput.text && !newPlaylistInput.activeFocus
                        color: "#828282"
                        font: newPlaylistInput.font
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                Button {
                    id: saveButton
                    text: "Simpan"
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredHeight: 36 * root.dp
                    Layout.preferredWidth: 80 * root.dp

                    contentItem: Text {
                        text: saveButton.text
                        font.family: "Inter"
                        font.pixelSize: 13 * root.dp
                        color: saveButton.enabled ? "#000000" : "#828282"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    enabled: newPlaylistInput.text.trim().length > 0 && localPlaylistModel.count < 5
                    onClicked: {
                        DataManager.createUserPlaylist(
                                    root.globalLocalId,
                                    root.globalIdToken,
                                    newPlaylistInput.text.trim()
                                    )
                        refreshTimer.start()
                        newPlaylistInput.text = ""
                        newPlaylistInput.focus = false
                    }
                }
            }
        }
    }

}
