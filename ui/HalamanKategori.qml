import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

Rectangle {
    id: halaman_kategori
    objectName: "Kategori"

    clip: true
    anchors.fill: parent
    color: "#F6F0FC"

    property string kategori: ""
    property string genre: ""
    property string judul: ""
    property string penyanyi: ""
    property bool favorit: false
    property string mode: ""
    property string targetName: ""

    // ── State search ──────────────────────────────────────────────────────────
    property bool isSearchMode: searchInput.text.trim().length > 0
    property bool searchIsLoading: false
    property var allSearchResults: []
    property int loadedCount: 0
    readonly property int pageSize: 20

    // ── Models ────────────────────────────────────────────────────────────────
    ListModel { id: musicModel }
    ListModel { id: searchResultModel }

    // ── Debounce timer ────────────────────────────────────────────────────────
    Timer {
        id: searchDebounceTimer
        interval: 400
        repeat: false
        onTriggered: {
            let q = searchInput.text.trim()
            if (q.length > 0) {
                halaman_kategori.searchIsLoading = true
                halaman_kategori.allSearchResults = []
                halaman_kategori.loadedCount = 0
                searchResultModel.clear()
                DataManager.fetchSearchResults(root.globalIdToken, q, "lagu", 0)
            }
        }
    }

    // ── Load batch berikutnya dari buffer ─────────────────────────────────────
    function loadNextPage() {
        let start = halaman_kategori.loadedCount
        let end   = Math.min(start + halaman_kategori.pageSize, halaman_kategori.allSearchResults.length)
        for (let i = start; i < end; i++) {
            searchResultModel.append(halaman_kategori.allSearchResults[i])
        }
        halaman_kategori.loadedCount = end
    }

    // ── Connections ───────────────────────────────────────────────────────────
    Connections {
        target: DataManager

        function onPlaylistSongsClearRequested() {
            musicModel.clear()
        }

        function onPlaylistSongItemFetched(songId, title, artist, imagePath) {
            musicModel.append({
                "id_song": songId,
                "judul":   title,
                "artist":  artist,
                "src":     imagePath !== "" ? imagePath : "assets/musik_placeholder.png"
            })
        }

        // FIX: Hapus lagu dari model lokal setelah C++ konfirmasi sukses ke Firestore
        function onPlaylistSongRemoved(songId) {
            for (var i = 0; i < musicModel.count; i++) {
                if (musicModel.get(i).id_song === songId) {
                    musicModel.remove(i)
                    break
                }
            }
        }

        function onSearchResultClearRequested() {
            halaman_kategori.allSearchResults = []
            halaman_kategori.loadedCount = 0
            searchResultModel.clear()
        }

        function onSearchResultItemFetched(songId, title, artist, imagePath) {
            halaman_kategori.searchIsLoading = false
            let item = {
                "id_song": songId,
                "judul":   title,
                "artist":  artist,
                "src":     imagePath !== "" ? imagePath : "assets/musik_placeholder.png"
            }
            halaman_kategori.allSearchResults.push(item)
            if (halaman_kategori.allSearchResults.length <= halaman_kategori.pageSize) {
                searchResultModel.append(item)
                halaman_kategori.loadedCount = halaman_kategori.allSearchResults.length
            }
        }
    }

    Component.onCompleted: {
        if (mode === "playlist") {
            DataManager.fetchSongsInPlaylist(root.globalLocalId, root.globalIdToken, targetName)
        } else if (kategori === "penyanyi") {
            DataManager.fetchSongsByArtist(root.globalIdToken, penyanyi)
        } else if (kategori === "Favorit") {
            DataManager.fetchFavoriteSongs(root.globalLocalId, root.globalIdToken)
        }
    }

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
                x: 16 * root.dp;
                anchors.verticalCenter: parent.verticalCenter
                width: 9.49; height: 16.86
                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -10 * root.dp
                    onClicked: { myStack.pop() }
                }
                ShapePath {
                    fillColor: "#000000"
                    PathSvg { path: "M 2.338 8.429 L 9.348 1.419 C 9.543 1.223 9.543 0.907 9.348 0.712 L 8.782 0.146 C 8.587 -0.048 8.270 -0.048 8.075 0.146 L 0.146 8.075 C -0.048 8.270 -0.048 8.587 0.146 8.782 L 8.075 16.712 C 8.270 16.907 8.587 16.907 8.782 16.712 L 9.348 16.146 C 9.543 15.951 9.543 15.634 9.348 15.439 L 2.338 8.429 Z" }
                }
            }

            Text {
                text: mode === "playlist" ? targetName
                    : kategori === "genre"    ? genre
                    : kategori === "judul"    ? judul
                    : kategori === "penyanyi" ? penyanyi
                    : kategori
                anchors.centerIn: parent
                font.family: "Inter"
                font.pixelSize: 17 * root.dp
                font.weight: Font.DemiBold
                color: "#000000"
            }
        }

        // ── Search bar ────────────────────────────────────────────────────────
        Rectangle {
            anchors.left:        parent.left
            anchors.right:       parent.right
            anchors.leftMargin:  16 * root.dp
            anchors.rightMargin: 16 * root.dp
            height: 36 * root.dp
            color: "#EAD6FA"
            radius: 8 * root.dp

            RowLayout {
                anchors.fill:        parent
                anchors.leftMargin:  12 * root.dp
                anchors.rightMargin: 8  * root.dp
                spacing: 8 * root.dp

                Item {
                    Layout.preferredWidth: 20 * root.dp
                    Layout.preferredHeight: 20 * root.dp
                    Layout.alignment: Qt.AlignVCenter
                    Shape {
                        anchors.centerIn: parent
                        width: 16 * root.dp; height: 16 * root.dp
                        ShapePath {
                            strokeColor: "#000000"; strokeWidth: 2
                            fillColor: "transparent"; capStyle: ShapePath.RoundCap
                            PathSvg { path: "M 16 8 C 16 12.4183 12.4183 16 8 16 C 3.5817 16 0 12.4183 0 8 C 0 3.5817 3.5817 0 8 0 C 12.4183 0 16 3.5817 16 8 Z" }
                        }
                        ShapePath {
                            strokeColor: "#000000"; strokeWidth: 2
                            fillColor: "transparent"; capStyle: ShapePath.RoundCap
                            PathSvg { path: "M 14 14 L 18 18" }
                        }
                    }
                }

                TextInput {
                    id: searchInput
                    Layout.fillWidth: true
                    height: parent.height
                    font.family: "Inter"
                    font.pixelSize: 14 * root.dp
                    color: "#000000"
                    verticalAlignment: TextInput.AlignVCenter
                    clip: true

                    Text {
                        text: "Cari lagu..."
                        color: "#828282"
                        visible: !searchInput.text && !searchInput.activeFocus
                        font: searchInput.font
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    onTextChanged: {
                        if (text.trim() === "") {
                            halaman_kategori.searchIsLoading = false
                            halaman_kategori.allSearchResults = []
                            halaman_kategori.loadedCount = 0
                            searchResultModel.clear()
                            searchDebounceTimer.stop()
                            return
                        }
                        halaman_kategori.searchIsLoading = true
                        searchDebounceTimer.restart()
                    }

                    onAccepted: {
                        searchDebounceTimer.stop()
                        let q = text.trim()
                        if (q.length > 0) {
                            halaman_kategori.searchIsLoading = true
                            halaman_kategori.allSearchResults = []
                            halaman_kategori.loadedCount = 0
                            searchResultModel.clear()
                            DataManager.fetchSearchResults(root.globalIdToken, q, "lagu", 0)
                        }
                    }
                }

                Item {
                    Layout.preferredWidth:  searchInput.text !== "" ? 28 * root.dp : 0
                    Layout.preferredHeight: 28 * root.dp
                    Layout.alignment: Qt.AlignVCenter
                    visible: searchInput.text !== ""
                    clip: true
                    Rectangle {
                        anchors.centerIn: parent
                        width: 20 * root.dp; height: 20 * root.dp
                        radius: 10 * root.dp; color: "#B0B0B0"
                        Text {
                            anchors.centerIn: parent
                            text: "✕"; font.pixelSize: 10 * root.dp
                            font.weight: Font.Bold; color: "#FFFFFF"
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: { searchInput.text = ""; searchInput.focus = false }
                    }
                }
            }
        }

        // ── List lagu ─────────────────────────────────────────────────────────
        ListView {
            id: musicList
            width:  parent.width
            height: halaman_kategori.height - y - navigationBar.height - 40 * root.dp
            clip:   true

            model: halaman_kategori.isSearchMode ? searchResultModel : musicModel

            onContentYChanged: {
                if (!halaman_kategori.isSearchMode) return
                if ((contentHeight - contentY - height) < 300 * root.dp &&
                    halaman_kategori.loadedCount < halaman_kategori.allSearchResults.length) {
                    halaman_kategori.loadNextPage()
                }
            }

            // Pesan kosong / loading
            Item {
                anchors.centerIn: parent
                width: parent.width
                height: 80 * root.dp
                visible: halaman_kategori.isSearchMode && musicList.count === 0

                Text {
                    anchors.centerIn: parent
                    text: "Mencari..."
                    font.family: "Inter"; font.pixelSize: 14 * root.dp; color: "#AAAAAA"
                    visible: halaman_kategori.searchIsLoading
                }
                Text {
                    anchors.centerIn: parent
                    text: "Tidak ada hasil untuk \"" + searchInput.text.trim() + "\""
                    font.family: "Inter"; font.pixelSize: 13 * root.dp; color: "#BBBBBB"
                    width: parent.width - 32 * root.dp
                    horizontalAlignment: Text.AlignHCenter; wrapMode: Text.WordWrap
                    visible: !halaman_kategori.searchIsLoading
                }
            }

            delegate: Item {
                id: delegateRoot
                width: musicList.width
                height: 76 * root.dp

                // Garis pemisah bawah
                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left; anchors.right: parent.right
                    anchors.leftMargin: 16 * root.dp; anchors.rightMargin: 16 * root.dp
                    height: 1; color: "#E8DDF7"
                    visible: index < musicList.count - 1
                }

                // Highlight saat ditekan — hanya area kiri (bukan area tombol ✕)
                Rectangle {
                    anchors.fill: parent
                    // Kalau mode playlist, highlight hanya sampai sebelum tombol ✕
                    anchors.rightMargin: mode === "playlist" ? 52 * root.dp : 0
                    color: itemTouch.pressed ? "#F3E8FF" : "transparent"
                    Behavior on color { ColorAnimation { duration: 80 } }
                }

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left:  parent.left
                    // FIX: sisakan ruang 52dp di kanan untuk tombol ✕ saat mode playlist
                    anchors.right: parent.right
                    anchors.leftMargin:  16 * root.dp
                    anchors.rightMargin: mode === "playlist" ? 52 * root.dp : 16 * root.dp
                    spacing: 12 * root.dp

                    Rectangle {
                        width: 52 * root.dp; height: 52 * root.dp
                        radius: 6 * root.dp; color: "#EAD6FA"; clip: true
                        Image {
                            anchors.fill: parent
                            source: model.src.startsWith("http") ? model.src : Qt.resolvedUrl(model.src)
                            fillMode: Image.PreserveAspectCrop
                            sourceSize.width: 52 * root.dp; sourceSize.height: 52 * root.dp
                        }
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 4 * root.dp
                        // Lebar otomatis mengisi sisa Row (setelah image + spacing)
                        width: parent.width - 52 * root.dp - 12 * root.dp

                        Text {
                            width: parent.width; text: model.judul
                            font.family: "Inter"; font.pixelSize: 14 * root.dp
                            font.weight: Font.Medium; color: "#000000"; elide: Text.ElideRight
                        }
                        Text {
                            width: parent.width; text: model.artist
                            font.family: "Inter"; font.pixelSize: 12 * root.dp
                            color: "#828282"; elide: Text.ElideRight
                        }
                    }
                }

                // MouseArea utama — tap lagu untuk putar
                MouseArea {
                    id: itemTouch
                    anchors.fill: parent
                    // Jangan tutup area tombol ✕ agar tombol itu bisa diklik
                    anchors.rightMargin: mode === "playlist" ? 52 * root.dp : 0
                    onClicked: {
                        let sid = model.id_song
                        myStack.push("HalamanPemutaran.qml", { "song_id": sid })
                    }
                }

                Rectangle {
                    visible: mode === "playlist"
                    Layout.alignment: Qt.AlignVCenter
                    width: 64 * root.dp
                    height: 34 * root.dp
                    radius: 8 * root.dp
                    anchors.right:          parent.right
                    anchors.rightMargin:    8 * root.dp
                    anchors.verticalCenter: parent.verticalCenter
                    color: removeTouch.pressed ? "#F0F0F0" : "#FFFFFF"
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
                        id: removeTouch
                        anchors.fill: parent
                        anchors.margins: -4 * root.dp
                        onClicked: {
                            let songIdToRemove = model.id_song
                            DataManager.removeSongFromPlaylist(
                                root.globalLocalId,
                                root.globalIdToken,
                                targetName,
                                songIdToRemove
                            )
                        }
                    }
                }
            }

            // Footer loading "Memuat lebih banyak"
            footer: Item {
                width: musicList.width
                height: halaman_kategori.isSearchMode &&
                        halaman_kategori.loadedCount < halaman_kategori.allSearchResults.length
                        ? 40 * root.dp : 0
                visible: height > 0
                Text {
                    anchors.centerIn: parent
                    text: "Memuat lebih banyak..."
                    font.family: "Inter"; font.pixelSize: 12 * root.dp; color: "#AAAAAA"
                }
            }
        }
    }
}
