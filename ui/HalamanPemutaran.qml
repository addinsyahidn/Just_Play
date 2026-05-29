import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import QtQuick.Controls
import "../components"

Rectangle {
    id: halamanPemutaran
    objectName: "Pemutaran"
    anchors.fill: parent
    color: "#F6F0FC"
    clip: true

    property string song_id: "Memuat Lagu..."
    property string namaJudulLagu: "Memuat Judul..."
    property string namaPenyanyiBand: "Memuat Nama Band..."
    property string teksLirik: "Memuat lirik..."
    property real posisiLaguMs: 0
    property real durasiLaguMs: 1
    property string albumArtUrl: ""
    property int activeLyricIndex: 0

    ListModel { id: lyricModel }

    function parseLrc(rawText) {
        lyricModel.clear()
        var regex = /\[(\d+):(\d+)(?:\.(\d+))?\](.*)/
        var lines = rawText.split('\n')
        for (var i = 0; i < lines.length; i++) {
            var match = lines[i].trim().match(regex)
            if (match) {
                var lineText = match[4].trim()
                lyricModel.append({ "lineText": lineText })
            }
        }
    }

    Component.onDestruction: {
        DataManager.stopSong()
    }

    function formatWaktu(ms) {
        var totalDetik = Math.floor(ms / 1000);
        var menit = Math.floor(totalDetik / 60);
        var detik = totalDetik % 60;
        return (menit < 10 ? "0" + menit : menit) + ":" + (detik < 10 ? "0" + detik : detik);
    }

    Connections {
        target: DataManager

        function onLrcFetched(lrcRawText) {
            if (lrcRawText.match(/\[\d+:\d+/)) {
                halamanPemutaran.parseLrc(lrcRawText)
            } else {
                halamanPemutaran.teksLirik = lrcRawText
                lyricModel.clear()
            }
        }

        function onActiveLyricIndexChanged(index) {
            halamanPemutaran.activeLyricIndex = index
        }

        function onMetadataFetched(title, artist, imagePath) {
            halamanPemutaran.namaJudulLagu = title
            halamanPemutaran.namaPenyanyiBand = artist
            if (imagePath !== "") halamanPemutaran.albumArtUrl = imagePath
            DataManager.checkIfFollowing(root.globalLocalId, root.globalIdToken, artist)
            DataManager.checkIfFavorite(root.globalLocalId, root.globalIdToken, halamanPemutaran.song_id)
        }

        function onAudioPositionChanged(positionMs, durationMs) {
            halamanPemutaran.posisiLaguMs = positionMs
            if (durationMs > 0) halamanPemutaran.durasiLaguMs = durationMs
        }

        function onFollowStatusChecked(isFollowed) {
            followBtn.isFollowed = isFollowed
        }

        function onFavoriteStatusChecked(isFavorite) {
            isFavorit.active_1 = isFavorite ? IsFavorit.Active.Active_True : IsFavorit.Active.Active_False
        }

        function onPlaylistFetched(playlistName, songCountInfo) {
            playlistPopupModel.append({ "name": playlistName, "info": songCountInfo })
        }
    }

    Component.onCompleted: {
        if (song_id !== "") DataManager.fetchSongLrc(song_id, root.globalIdToken)
    }

    Item {
        id: topSpacer
        width: parent.width
        height: 50 * root.dp
        anchors.top: parent.top
    }

    Rectangle {
        id: headerArea
        width: parent.width
        height: 42 * root.dp
        anchors.top: topSpacer.bottom
        color: "#E0D4F0"

        Shape {
            x: 16 * root.dp
            anchors.verticalCenter: parent.verticalCenter
            width: 9.49; height: 16.86

            MouseArea {
                anchors.fill: parent
                anchors.margins: -10 * root.dp
                onClicked: {
                    DataManager.stopSong()
                    myStack.pop()
                }
            }

            ShapePath {
                fillColor: "#000000"
                PathSvg { path: "M 2.338 8.429 L 9.348 1.419 C 9.543 1.223 9.543 0.907 9.348 0.712 L 8.782 0.146 C 8.587 -0.048 8.270 -0.048 8.075 0.146 L 0.146 8.075 C -0.048 8.270 -0.048 8.587 0.146 8.782 L 8.075 16.712 C 8.270 16.907 8.587 16.907 8.782 16.712 L 9.348 16.146 C 9.543 15.951 9.543 15.634 9.348 15.439 L 2.338 8.429 Z" }
            }
        }

        Text {
            text: "Sekarang Memutar"
            anchors.centerIn: parent
            font.family: "Inter"
            font.pixelSize: 16 * root.dp
            font.weight: Font.DemiBold
            color: "#000000"
        }
    }

    Image {
        id: albumArt
        x: 16 * root.dp
        anchors.top: headerArea.bottom
        anchors.topMargin: 16 * root.dp
        width: parent.width - (32 * root.dp)
        height: 280 * root.dp
        fillMode: Image.PreserveAspectCrop
        clip: true
        source: halamanPemutaran.albumArtUrl !== ""
                ? (halamanPemutaran.albumArtUrl.startsWith("http")
                   ? halamanPemutaran.albumArtUrl
                   : Qt.resolvedUrl(halamanPemutaran.albumArtUrl))
                : Qt.resolvedUrl("assets/image.png")

        Rectangle {
            anchors.fill: parent
            color: "#e6ffffff"
            z: 1

            ListView {
                id: lyricView
                anchors.fill: parent
                anchors.margins: 20 * root.dp
                clip: true
                model: lyricModel
                visible: lyricModel.count > 0

                currentIndex: halamanPemutaran.activeLyricIndex

                preferredHighlightBegin: height * 0.15
                preferredHighlightEnd:   height * 0.15 + (44 * root.dp)
                highlightRangeMode:      ListView.StrictlyEnforceRange
                highlightMoveDuration:   300
                highlight: Item {}

                interactive: false

                delegate: Item {
                    width: lyricView.width
                    height: (index === lyricView.currentIndex ? 46 : 32) * root.dp

                    Behavior on height {
                        NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
                    }

                    Text {
                        anchors.centerIn: parent
                        width: parent.width
                        text: model.lineText
                        font.family: "Inter"
                        font.pixelSize: index === lyricView.currentIndex
                                        ? 17 * root.dp : 13 * root.dp
                        font.weight: index === lyricView.currentIndex
                                     ? Font.Bold : Font.Normal
                        color: index === lyricView.currentIndex ? "#6a1e9a" : "#4a2e66"
                        opacity: {
                            var diff = Math.abs(index - lyricView.currentIndex)
                            if (diff === 0) return 1.0
                            if (diff === 1) return 0.5
                            if (diff === 2) return 0.25
                            return 0.15
                        }
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter

                        Behavior on opacity {
                            NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
                        }
                        Behavior on font.pixelSize {
                            NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
                        }
                        Behavior on color {
                            ColorAnimation { duration: 250 }
                        }
                    }
                }
            }

            Text {
                anchors.centerIn: parent
                width: parent.width - (30 * root.dp)
                text: halamanPemutaran.teksLirik
                font.family: "Inter"
                font.pixelSize: 18 * root.dp
                font.bold: true
                color: "#111111"
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                visible: lyricModel.count === 0
            }
        }
    }

    Item {
        id: infoArea
        anchors.top: albumArt.bottom
        anchors.topMargin: 20 * root.dp
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 24 * root.dp
        anchors.rightMargin: 24 * root.dp
        height: 64 * root.dp

        Column {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - 80 * root.dp
            spacing: 6 * root.dp

            Text {
                id: nama_musik
                width: parent.width
                color: "#000000"
                elide: Text.ElideRight
                font.family: "Inter"
                font.pixelSize: 16 * root.dp
                font.weight: Font.DemiBold
                text: halamanPemutaran.namaJudulLagu
            }

            Row {
                spacing: 12 * root.dp
                width: parent.width

                Text {
                    id: band
                    color: "#80000000"
                    font.family: "Inter"
                    font.pixelSize: 13 * root.dp
                    text: halamanPemutaran.namaPenyanyiBand
                    anchors.verticalCenter: parent.verticalCenter
                }

                Button {
                    id: followBtn
                    property bool isFollowed: false

                    text: isFollowed ? "✓ Diikuti" : "+ Ikuti"
                    anchors.verticalCenter: parent.verticalCenter
                    implicitWidth: 74 * root.dp
                    implicitHeight: 28 * root.dp
                    topPadding: 4 * root.dp
                    bottomPadding: 4 * root.dp

                    background: Rectangle {
                        color: followBtn.isFollowed ? "#E0D7E5" : "#EAD6FA"
                        radius: 4 * root.dp
                    }

                    contentItem: Text {
                        text: followBtn.text
                        font.family: "Inter"
                        font.pixelSize: 10 * root.dp
                        font.weight: Font.Bold
                        color: followBtn.isFollowed ? "#828282" : "#a23ca8"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        if (halamanPemutaran.namaPenyanyiBand === "Memuat Nama Band..." || halamanPemutaran.namaPenyanyiBand === "") return
                        if (isFollowed) {
                            DataManager.unfollowArtist(root.globalLocalId, root.globalIdToken, halamanPemutaran.namaPenyanyiBand)
                            isFollowed = false
                        } else {
                            DataManager.followArtist(root.globalLocalId, root.globalIdToken, halamanPemutaran.namaPenyanyiBand)
                            isFollowed = true
                        }
                    }
                }
            }
        }

        Row {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: 16 * root.dp

            Rectangle {
                id: playlistAddButton
                width: 32 * root.dp
                height: 32 * root.dp
                radius: 6 * root.dp
                color: addPlaylistTouch.pressed ? "#DCC6F5" : "#EAD6FA"
                anchors.verticalCenter: parent.verticalCenter

                Behavior on color { ColorAnimation { duration: 80 } }

                Text {
                    anchors.centerIn: parent
                    text: "+"
                    font.pixelSize: 20 * root.dp
                    font.weight: Font.Light
                    color: "#7C3AED"
                }

                MouseArea {
                    id: addPlaylistTouch
                    anchors.fill: parent
                    onClicked: {
                        playlistPopupModel.clear()
                        DataManager.fetchUserPlaylists(root.globalLocalId, root.globalIdToken)
                        playlistPopup.visible = true
                    }
                }
            }

            IsFavorit {
                id: isFavorit
                active_1: IsFavorit.Active.Active_False
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (halamanPemutaran.song_id === "") return
                        if (isFavorit.active_1 === IsFavorit.Active.Active_True) {
                            DataManager.removeFromFavorites(root.globalLocalId, root.globalIdToken, halamanPemutaran.song_id)
                            isFavorit.active_1 = IsFavorit.Active.Active_False
                        } else {
                            DataManager.addToFavorites(root.globalLocalId, root.globalIdToken, halamanPemutaran.song_id)
                            isFavorit.active_1 = IsFavorit.Active.Active_True
                        }
                    }
                }
            }
        }
    }

    Item {
        id: bottomControlsArea
        width: parent.width
        height: 120 * root.dp
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 24 * root.dp

        Rectangle {
            id: progressBar
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            height: 4 * root.dp
            width: parent.width - (48 * root.dp)
            color: "#d9d9d9"
            radius: 99

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                height: parent.height
                width: (halamanPemutaran.posisiLaguMs / halamanPemutaran.durasiLaguMs) * parent.width
                color: "#eaa0e4"
                radius: 99
            }

            Text {
                anchors.top: parent.bottom
                anchors.topMargin: 6 * root.dp
                anchors.left: parent.left
                text: halamanPemutaran.formatWaktu(halamanPemutaran.posisiLaguMs)
                font.family: "Inter"
                font.pixelSize: 11 * root.dp
                color: "#80000000"
            }

            Text {
                anchors.top: parent.bottom
                anchors.topMargin: 6 * root.dp
                anchors.right: parent.right
                text: halamanPemutaran.formatWaktu(halamanPemutaran.durasiLaguMs)
                font.family: "Inter"
                font.pixelSize: 11 * root.dp
                color: "#80000000"
            }
        }

        Row {
            id: controlsRow
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 48 * root.dp

            Rectangle {
                width: 32 * root.dp; height: 32 * root.dp
                radius: 16 * root.dp
                color: replayTouch.pressed ? "#DCC6F5" : "transparent"
                anchors.verticalCenter: parent.verticalCenter
                Behavior on color { ColorAnimation { duration: 80 } }

                Shape {
                    anchors.centerIn: parent
                    width: 22 * root.dp
                    height: 22 * root.dp

                    ShapePath {
                        strokeColor: "#555555"
                        strokeWidth: 2.2 * root.dp
                        fillColor: "transparent"
                        capStyle: ShapePath.FlatCap
                        PathAngleArc {
                            centerX: 11 * root.dp; centerY: 11 * root.dp
                            radiusX: 8.5 * root.dp; radiusY: 8.5 * root.dp
                            startAngle: -120
                            sweepAngle: 270
                        }
                    }

                    ShapePath {
                        strokeColor: "#555555"
                        strokeWidth: 2.2 * root.dp
                        fillColor: "transparent"
                        capStyle: ShapePath.RoundCap
                        joinStyle: ShapePath.RoundJoin
                        startX: 7.0 * root.dp; startY: 1 * root.dp
                        PathLine { x: 3.5 * root.dp; y: 4.5 * root.dp }
                        PathLine { x: 7.5 * root.dp; y: 6.5 * root.dp }
                    }
                }

                MouseArea {
                    id: replayTouch
                    anchors.fill: parent
                    anchors.margins: -8 * root.dp
                    onClicked: {
                        DataManager.replaySong()
                        playPauseMouseArea.isPlaying = true
                    }
                }
            }

            IsPause {
                id: isPause
                anchors.verticalCenter: parent.verticalCenter
                pause_1: playPauseMouseArea.isPlaying ? IsPause.Pause.Pause_False : IsPause.Pause.Pause_True

                MouseArea {
                    id: playPauseMouseArea
                    anchors.fill: parent
                    property bool isPlaying: true
                    onClicked: {
                        if (isPlaying) { DataManager.pauseSong(); isPlaying = false }
                        else { DataManager.resumeSong(); isPlaying = true }
                    }
                }
            }

            Image {
                width: 32 * root.dp; height: 32 * root.dp
                anchors.verticalCenter: parent.verticalCenter
                source: Qt.resolvedUrl("assets/next.png")
            }
        }
    }

    ListModel { id: playlistPopupModel }

    Rectangle {
        id: playlistPopup
        visible: false
        z: 200

        anchors.fill: parent
        color: "#80000000"

        MouseArea {
            anchors.fill: parent
            onClicked: playlistPopup.visible = false
        }

        Rectangle {
            id: popupPanel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - 48 * root.dp
            height: Math.min(360 * root.dp, 80 * root.dp + playlistPopupModel.count * 52 * root.dp)
            radius: 16 * root.dp
            color: "#FFFFFF"

            MouseArea { anchors.fill: parent }

            Column {
                anchors.fill: parent
                anchors.margins: 16 * root.dp
                spacing: 12 * root.dp

                Text {
                    text: "Tambah ke Playlist"
                    font.family: "Inter"
                    font.pixelSize: 15 * root.dp
                    font.weight: Font.DemiBold
                    color: "#111111"
                    width: parent.width
                }

                Rectangle { width: parent.width; height: 1; color: "#F0EAFA" }

                ListView {
                    id: popupList
                    width: parent.width
                    height: popupPanel.height - 80 * root.dp
                    clip: true
                    model: playlistPopupModel

                    delegate: Rectangle {
                        width: popupList.width
                        height: 48 * root.dp
                        color: popupItemTouch.pressed ? "#F3E8FF" : "transparent"
                        radius: 8 * root.dp

                        Behavior on color { ColorAnimation { duration: 80 } }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 8 * root.dp
                            spacing: 2 * root.dp

                            Text {
                                text: model.name
                                font.family: "Inter"
                                font.pixelSize: 13 * root.dp
                                font.weight: Font.Medium
                                color: "#111111"
                            }
                            Text {
                                text: model.info
                                font.family: "Inter"
                                font.pixelSize: 11 * root.dp
                                color: "#AAAAAA"
                            }
                        }

                        MouseArea {
                            id: popupItemTouch
                            anchors.fill: parent
                            onClicked: {
                                DataManager.addSongToPlaylist(
                                    root.globalLocalId,
                                    root.globalIdToken,
                                    model.name,
                                    halamanPemutaran.song_id
                                )
                                playlistPopup.visible = false
                            }
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "Belum ada playlist"
                        font.family: "Inter"
                        font.pixelSize: 13 * root.dp
                        color: "#BBBBBB"
                        visible: playlistPopupModel.count === 0
                    }
                }
            }
        }
    }
}