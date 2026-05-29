import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

import "../components"

Rectangle {
    id: halaman_utama
    objectName: "Utama"

    height: parent.height
    width: parent.width
    clip: true
    anchors.fill: parent
    color: "#F6F0FC"

    ListModel { id: bannerModel }

    ListModel { id: seringDiputarModel }

    ListModel { id: searchResultModel }

    property bool searchIsLoading: false

    Timer {
        id: searchDebounceTimer
        interval: 400
        repeat: false
        onTriggered: {
            let q = searchInput.text.trim()
            if (q.length > 0) {
                halaman_utama.searchIsLoading = true
                let tipe = searchDropdown.activeFilter === "Artis" ? "artis" : "lagu"
                DataManager.fetchSearchResults(root.globalIdToken, q, tipe)
            }
        }
    }


    Component.onCompleted: {
        DataManager.fetchLatestSongsBanner(root.globalIdToken)
        DataManager.fetchSeringDiputar(root.globalIdToken)
    }

    Connections {
        target: DataManager
        function onBannerClearRequested() {
            bannerModel.clear()
        }
        function onSeringDiputarClearRequested() {
            seringDiputarModel.clear()
        }
        function onLatestSongBannerFetched(songId, title, artist, imagePath) {
            bannerModel.append({
                                   "id_song": songId,
                                   "judul": title,
                                   "artist": artist,
                                   "src": imagePath !== "" ? imagePath : "assets/banner.png"
                               })
        }
        function onSeringDiputarItemFetched(songId, title, artist, imagePath) {
            for (var i = 0; i < seringDiputarModel.count; i++) {
                if (seringDiputarModel.get(i).id_song === songId) return
            }
            seringDiputarModel.append({
                "id_song": songId,
                "judul":   title,
                "artist":  artist,
                "src":     imagePath !== "" ? imagePath : "assets/musik_placeholder.png"
            })
        }
        function onSearchResultClearRequested() {
            searchResultModel.clear()
        }
        function onSearchResultItemFetched(songId, title, artist, imagePath) {
            halaman_utama.searchIsLoading = false   // ← matikan loading
            searchResultModel.append({
                "id_song": songId,
                "judul":   title,
                "artist":  artist,
                "src":     imagePath !== "" ? imagePath : "assets/musik_placeholder.png"
            })
            searchDropdown.visible = true
        }
    }


    Column {
        id: mainContent
        width: parent.width
        spacing: 20 * root.dp

        Item { width: 1; height: 30 * root.dp }

        Item {
            width: parent.width
            height: 30 * root.dp   // disesuaikan agar Column menghitung tinggi yang benar

            Rectangle {
                id: searchContainer
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16 * root.dp
                anchors.rightMargin: 16 * root.dp
                height: 30 * root.dp
                color: "#EAD6FA"
                radius: 8 * root.dp

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 12 * root.dp
                    anchors.rightMargin: 8 * root.dp
                    spacing: 8 * root.dp

                    // Ikon kaca pembesar
                    Item {
                        Layout.preferredWidth: 20 * root.dp
                        Layout.preferredHeight: 20 * root.dp
                        Layout.alignment: Qt.AlignVCenter

                        Shape {
                            anchors.centerIn: parent
                            width: 16 * root.dp
                            height: 16 * root.dp

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

                    // Kolom input teks
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
                            text: "Cari lagu atau artis..."
                            color: "#828282"
                            visible: !searchInput.text && !searchInput.activeFocus
                            font: searchInput.font
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        // NEW: picu debounce timer setiap kali teks berubah
                        onTextChanged: {
                            if (text.trim() === "") {
                                halaman_utama.searchIsLoading = false
                                searchResultModel.clear()
                                searchDebounceTimer.stop()
                                return
                            }
                            halaman_utama.searchIsLoading = true
                            searchDebounceTimer.restart()
                        }

                        // Ganti onAccepted — jangan tutup dropdown, langsung fetch saja
                        onAccepted: {
                            searchDebounceTimer.stop()
                            let q = text.trim()
                            if (q.length > 0) {
                                halaman_utama.searchIsLoading = true
                                let tipe = searchDropdown.activeFilter === "Artis" ? "artis" : "lagu"
                                DataManager.fetchSearchResults(root.globalIdToken, q, tipe)
                            }
                        }
                    }

                    // NEW: Tombol ✕ — hanya muncul saat ada teks
                    Item {
                        Layout.preferredWidth: searchInput.text !== "" ? 28 * root.dp : 0
                        Layout.preferredHeight: 28 * root.dp
                        Layout.alignment: Qt.AlignVCenter
                        visible: searchInput.text !== ""
                        clip: true

                        // Lingkaran latar abu-abu
                        Rectangle {
                            anchors.centerIn: parent
                            width: 20 * root.dp
                            height: 20 * root.dp
                            radius: 10 * root.dp
                            color: "#B0B0B0"

                            Text {
                                anchors.centerIn: parent
                                text: "✕"
                                font.pixelSize: 10 * root.dp
                                font.weight: Font.Bold
                                color: "#FFFFFF"
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                searchInput.text = ""
                                searchInput.focus = false
                                searchResultModel.clear()
                                searchDropdown.visible = false
                            }
                        }
                    }
                }
            }
        }
        Rectangle {
            id: pillsContainer

            anchors.left: parent.left
            anchors.leftMargin: 16 * root.dp
            anchors.right: parent.right
            anchors.rightMargin: 16 * root.dp

            height: 32 * root.dp
            color: "transparent"

            Row {
                id: layoutRow
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 24 * root.dp

                Repeater {
                    model: [
                        { name: "Favorit"},
                        { name: "Diikuti"},
                        { name: "Playlist"},
                        { name: "Pencarian"}
                    ]

                    delegate: Rectangle {
                        id: pillDelegate
                        width: contentLayout.implicitWidth + (18 * root.dp)
                        height: 28 * root.dp
                        radius: 6 * root.dp

                        border.width: 1
                        border.color: pillTouch.pressed ? "#999999" : "#cccccc"

                        color: pillTouch.pressed ? "#08000000" : "transparent"

                        Row {
                            id: contentLayout
                            anchors.centerIn: parent
                            spacing: 4 * root.dp

                            Text {
                                text: modelData.name
                                font.pixelSize: 12 * root.dp
                                font.family: "Inter"
                                color: "#000000"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        MouseArea {
                            id: pillTouch
                            anchors.fill: parent
                            onClicked: {
                                if (modelData.name === "Playlist") {
                                    myStack.push("HalamanPlaylist.qml")
                                } else if (modelData.name === "Diikuti") {
                                    myStack.push("HalamanDiikuti.qml")
                                } else {
                                    myStack.push("HalamanKategori.qml", {"kategori": modelData.name})
                                }
                            }
                        }
                    }
                }
            }
        }
        Image {
            id: banner
            x: 16; y: 148
            width: 343; height: 170
            clip: true
            source: Qt.resolvedUrl("assets/banner.png")
            sourceSize.width: 343 * root.dp
            sourceSize.height: 170 * root.dp

            ListView {
                id: bannerList
                anchors.fill: parent
                orientation: ListView.Horizontal
                snapMode: ListView.SnapOneItem
                interactive: true
                highlightRangeMode: ListView.StrictlyEnforceRange
                boundsBehavior: ListView.StopAtBounds
                model: bannerModel

                delegate: Item {
                    width: 343
                    height: 170

                    Image {
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectCrop
                        source: model.src.startsWith("http") ? model.src : Qt.resolvedUrl(model.src)

                        Rectangle {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            height: 60
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "transparent" }
                                GradientStop { position: 1.0; color: "#99000000" }
                            }
                        }

                        Text {
                            text: model.judul + " - " + model.artist
                            x: 20
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 16
                            font.family: "Inter"
                            font.pixelSize: 13 * root.dp
                            font.weight: Font.Bold
                            color: "#ffffff"
                            width: parent.width - 40
                            elide: Text.ElideRight
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        propagateComposedEvents: true
                        onClicked: (mouse) => {
                                       myStack.push("HalamanPemutaran.qml", { "song_id": model.id_song })
                                       mouse.accepted = true
                                   }
                    }
                }
            }

            Text {
                id: rilis_Terbaru
                x: 20; y: 54
                text: "Rilis Terbaru"
                color: "#000000"
                font.pixelSize: 20
                font.weight: Font.DemiBold
                font.family: "Inter"
                font.letterSpacing: -0.40
                horizontalAlignment: Text.AlignLeft
                lineHeight: 28
                lineHeightMode: Text.FixedHeight
                textFormat: Text.PlainText
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
            }

            Rectangle {
                id: pagination
                x: 149; y: 123
                height: 5; width: 45
                color: "transparent"

                Timer {
                    id: autoTimer
                    interval: 5000
                    running: bannerList.count > 0
                    repeat: true
                    onTriggered: {
                        if (bannerList.currentIndex < bannerList.count - 1) {
                            bannerList.currentIndex += 1
                        } else {
                            bannerList.currentIndex = 0
                        }
                    }
                }

                Row {
                    spacing: 5
                    Repeater {
                        model: bannerList.count
                        Image { source: Qt.resolvedUrl("assets/_default.png") }
                    }
                }

                Image {
                    id: selected
                    source: Qt.resolvedUrl("assets/selected.png")
                    x: bannerList.currentIndex * 10
                    Behavior on x {
                        NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                    }
                }
            }
        }
        Item {
            id: seringDiputarSection
            width: parent.width
            height: 135 * root.dp

            Rectangle {
                id: titleBar
                width: parent.width
                height: 38 * root.dp
                color: "transparent"

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: 16 * root.dp
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8 * root.dp

                    Text {
                        text: "Sering Diputar"
                        font.family: "Inter"
                        font.pixelSize: 16 * root.dp
                        font.weight: Font.DemiBold
                        color: "#000000"
                    }

                    Icon_Chevron_Right_Slim_LTR {
                        width: 24 * root.dp
                        height: 24 * root.dp
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            ListView {
                id: carousel
                y: 38 * root.dp
                width: parent.width
                height: 110 * root.dp
                orientation: ListView.Horizontal
                spacing: 12 * root.dp
                leftMargin: 16 * root.dp
                rightMargin: 16 * root.dp
                clip: true
                snapMode: ListView.NoSnap
                model: seringDiputarModel

                delegate: Item {
                    width: 74 * root.dp
                    height: 110 * root.dp

                    Image {
                        id: albumArt
                        width: 74 * root.dp
                        height: 74 * root.dp
                        source: model.src.startsWith("http") ? model.src : Qt.resolvedUrl(model.src)
                        fillMode: Image.PreserveAspectCrop
                        sourceSize.width: 74 * root.dp
                        sourceSize.height: 74 * root.dp
                        anchors.horizontalCenter: parent.horizontalCenter
                        opacity: albumTouch.pressed ? 0.7 : 1.0
                        Behavior on opacity { NumberAnimation { duration: 100 } }
                    }

                    Text {
                        id: songText
                        anchors.top: albumArt.bottom
                        anchors.topMargin: 6 * root.dp
                        anchors.horizontalCenter: albumArt.horizontalCenter
                        width: parent.width
                        text: model.judul
                        color: "#000000"
                        font.family: "Inter"
                        font.pixelSize: 12 * root.dp
                        font.weight: Font.Medium
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.Wrap
                        maximumLineCount: 2
                    }

                    MouseArea {
                        id: albumTouch
                        anchors.fill: parent
                        onClicked: myStack.push("HalamanPemutaran.qml", {
                                                    "song_id": model.id_song
                                                })
                    }
                }
            }
        }
        Item {
            id: genreSection
            width: parent.width
            height: 200 * root.dp

            Rectangle {
                id: genreHeader
                width: parent.width
                height: 38 * root.dp
                color: "transparent"

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: 16 * root.dp
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8 * root.dp

                    Text {
                        text: "Genre"
                        font.family: "Inter"
                        font.pixelSize: 16 * root.dp
                        font.weight: Font.DemiBold
                        color: "#000000"
                    }

                    Icon_Chevron_Right_Slim_LTR {
                        width: 24 * root.dp
                        height: 24 * root.dp
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
            ListView {
                id: genreList
                anchors.top: genreHeader.bottom
                anchors.topMargin: 8 * root.dp
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16 * root.dp
                anchors.rightMargin: 16 * root.dp
                height: 170 * root.dp

                orientation: ListView.Horizontal
                spacing: 12 * root.dp
                leftMargin: 16 * root.dp
                rightMargin: 16 * root.dp
                clip: true
                snapMode: ListView.NoSnap

                model: [
                    { genre: "Pop", img: "assets/genre_pop.png" },
                    { genre: "Rock", img: "assets/genre_rock.png" },
                    { genre: "R&B", img: "assets/genre_r&b.png" },
                    { genre: "Jazz", img: "assets/genre_jazz.png" },
                    { genre: "Lainnya", img: "assets/genre_lainnya.png" }
                ]

                delegate: Item {
                    width: 148 * root.dp
                    height: 148 * root.dp

                    Image {
                        id: genreImage
                        width: 148 * root.dp
                        height: 148 * root.dp
                        source: Qt.resolvedUrl(modelData.img)
                        fillMode: Image.PreserveAspectCrop
                        sourceSize.width: 148 * root.dp
                        sourceSize.height: 148 * root.dp
                        opacity: genreTouch.pressed ? 0.7 : 1.0
                        Behavior on opacity { NumberAnimation { duration: 100 } }
                    }

                    MouseArea {
                        id: genreTouch
                        anchors.fill: parent
                        onClicked: myStack.push("HalamanKategori.qml", {"kategori": "genre", "genre": modelData.genre})
                    }
                }
            }
        }
    }
    Rectangle {
        id: searchDropdown
        property string activeFilter: "Semua"

        onActiveFilterChanged: {
            let q = searchInput.text.trim()
            if (q.length > 0) {
                halaman_utama.searchIsLoading = true
                let tipe = activeFilter === "Artis" ? "artis" : "lagu"
                DataManager.fetchSearchResults(root.globalIdToken, q, tipe)
            }
        }

        // ✅ FIX 2: tampil otomatis selama ada teks, tidak perlu di-toggle manual
        visible: searchInput.text.trim().length > 0

        z: 100
        anchors.top:         parent.top
        anchors.topMargin:   (30 + 20 + 30 + 4) * root.dp
        anchors.left:        parent.left
        anchors.leftMargin:  16 * root.dp
        anchors.right:       parent.right
        anchors.rightMargin: 16 * root.dp

        height: filterRow.height
                + (searchResultModel.count > 0
                   ? searchResultModel.count * 56 * root.dp
                   : 48 * root.dp)

        color:  "white"
        radius: 10 * root.dp

        Rectangle {
            anchors.fill: parent; anchors.margins: -1
            radius: parent.radius + 1; color: "transparent"
            border.width: 1; border.color: "#25000000"; z: -1
        }
        Rectangle {
            anchors.fill: parent; anchors.margins: -4; anchors.topMargin: -2
            radius: parent.radius + 3; color: "#12000000"; z: -2
        }

        // ── Chip filter ─────────────────────────────────────────────────────────
        Item {
            id: filterRow
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 36 * root.dp

            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10 * root.dp
                spacing: 6 * root.dp

                Repeater {
                    model: ["Semua", "Lagu", "Artis"]
                    delegate: Rectangle {
                        property bool isActive: searchDropdown.activeFilter === modelData
                        height: 24 * root.dp
                        width:  chipLabel.implicitWidth + 14 * root.dp
                        radius: 12 * root.dp
                        color:  isActive ? "#8B5CF6" : "#F0E6FD"
                        Behavior on color { ColorAnimation { duration: 120 } }

                        Text {
                            id: chipLabel
                            anchors.centerIn: parent
                            text:           modelData
                            font.family:    "Inter"
                            font.pixelSize: 11 * root.dp
                            font.weight:    isActive ? Font.SemiBold : Font.Normal
                            color:          isActive ? "white" : "#6B21C8"
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: searchDropdown.activeFilter = modelData
                        }
                    }
                }
            }

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left; anchors.right: parent.right
                height: 1; color: "#F0F0F0"
            }
        }

        Item {
            anchors.top:    filterRow.bottom
            anchors.left:   parent.left
            anchors.right:  parent.right
            anchors.bottom: parent.bottom

            // Loading
            Text {
                anchors.centerIn: parent
                text: "Mencari..."
                font.family: "Inter"; font.pixelSize: 13 * root.dp; color: "#AAAAAA"
                visible: halaman_utama.searchIsLoading && searchResultModel.count === 0
            }

            // Tidak ditemukan
            Text {
                anchors.centerIn: parent
                text: "Tidak ada hasil untuk \"" + searchInput.text.trim() + "\""
                font.family: "Inter"; font.pixelSize: 12 * root.dp; color: "#BBBBBB"
                width: parent.width - 24 * root.dp
                horizontalAlignment: Text.AlignHCenter; wrapMode: Text.WordWrap
                visible: !halaman_utama.searchIsLoading && searchResultModel.count === 0
            }

            ListView {
                id: searchResultList
                anchors.fill: parent
                anchors.margins: 4 * root.dp
                model: searchResultModel
                clip: true
                interactive: false

                delegate: Item {
                    width: searchResultList.width
                    height: 56 * root.dp

                    Rectangle {
                        visible: index < searchResultModel.count - 1
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left; anchors.right: parent.right
                        anchors.leftMargin: 8 * root.dp; anchors.rightMargin: 8 * root.dp
                        height: 1; color: "#F0F0F0"
                    }

                    Rectangle {
                        anchors.fill: parent; radius: 6 * root.dp
                        color: itemTouch.pressed ? "#F3E8FF" : "transparent"
                        Behavior on color { ColorAnimation { duration: 80 } }
                    }

                    Row {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left; anchors.right: parent.right
                        anchors.leftMargin: 8 * root.dp; anchors.rightMargin: 8 * root.dp
                        spacing: 12 * root.dp

                        Rectangle {
                            width: 40 * root.dp; height: 40 * root.dp
                            radius: 6 * root.dp; color: "#EAD6FA"; clip: true
                            Image {
                                anchors.fill: parent
                                source: model.src.startsWith("http") ? model.src : Qt.resolvedUrl(model.src)
                                fillMode: Image.PreserveAspectCrop
                                sourceSize.width: 40 * root.dp; sourceSize.height: 40 * root.dp
                            }
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 3 * root.dp
                            width: parent.width - 40 * root.dp - 12 * root.dp

                            Text {
                                width: parent.width; text: model.judul
                                font.family: "Inter"; font.pixelSize: 13 * root.dp
                                font.weight: Font.Medium; color: "#111111"; elide: Text.ElideRight
                            }

                            Row {
                                spacing: 4 * root.dp
                                Rectangle {
                                    height: 14 * root.dp
                                    width: badgeText.implicitWidth + 6 * root.dp
                                    radius: 3 * root.dp; color: "#EAD6FA"
                                    anchors.verticalCenter: parent.verticalCenter
                                    Text {
                                        id: badgeText
                                        anchors.centerIn: parent
                                        text: searchDropdown.activeFilter === "Artis" ? "Artis" : "Lagu"
                                        font.family: "Inter"; font.pixelSize: 9 * root.dp
                                        font.weight: Font.Medium; color: "#7C3AED"
                                    }
                                }
                                Text {
                                    text: model.artist
                                    font.family: "Inter"; font.pixelSize: 11 * root.dp
                                    color: "#888888"; elide: Text.ElideRight
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: parent.parent.width - 14 * root.dp - 4 * root.dp
                                }
                            }
                        }
                    }

                    MouseArea {
                        id: itemTouch
                        anchors.fill: parent
                        onClicked: {
                            // ✅ FIX 1: tangkap dulu sebelum apapun berubah
                            let songId = model.id_song
                            myStack.push("HalamanPemutaran.qml", {"song_id": songId})
                        }
                    }
                }
            }
        }
    }
}