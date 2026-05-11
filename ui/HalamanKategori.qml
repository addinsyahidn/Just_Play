import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

Rectangle {
    id: halaman_kategori
    anchors.fill: parent
    clip: true
    color: "#ffffff"

    property string kategori: ""
    property string genre: ""
    property string judul: ""
    property string penyanyi: ""
    property bool favorit: false

    Column {
        id: mainContent
        width: parent.width
        spacing: 20 * root.dp

        Item { width: 1; height: 30 * root.dp }

        Image {
            id: header
            width: parent.width
            height: 42 * root.dp
            source: Qt.resolvedUrl("assets/header_2.png")

            Shape {
                id: chevron_left_thin
                x: 16 * root.dp; y: 9 * root.dp
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
                text: (kategori == "genre" ? genre : kategori == "judul" ? judul : kategori == "penyanyi" ? penyanyi : kategori)
                anchors.centerIn: parent
                font.family: "Inter"
                font.pixelSize: 17
                font.weight: Font.DemiBold
            }
        }
        Rectangle {
            id: searchContainer
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 16 * root.dp
            anchors.rightMargin: 16 * root.dp
            height: 30 * root.dp
            color: "#f5f5f5"
            radius: 8 * root.dp

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 12 * root.dp
                spacing: 8 * root.dp

                Item { Layout.preferredWidth: 24 * root.dp; Layout.preferredHeight: 24 * root.dp }

                TextInput {
                    id: searchInput
                    Layout.fillWidth: true
                    font.pixelSize: 14 * root.dp
                    verticalAlignment: TextInput.AlignVCenter

                    Text {
                        text: "Cari lagu atau artis..."
                        visible: !searchInput.text && !searchInput.activeFocus
                        color: "#828282"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
        ListView {
            id: musicList
            width: parent.width
            height: halaman_kategori.height - y - navigationBar.height - 40 * root.dp
            spacing: 0
            clip: true

            model: ListModel {
                ListElement {Mgenre: "Rock"; Mjudul: "Nama musik 1"; Mpenyanyi: "Bruno Earth"; isFav: "Favorit"; img: "assets/image_18.png" }
                ListElement {Mgenre: "Pop"; Mjudul: "Nama musik 2"; Mpenyanyi: "Alan Runner"; isFav: "Favorit"; img: "assets/image_19.png" }
                ListElement {Mgenre: "Rock"; Mjudul: "Nama musik 3"; Mpenyanyi: "Bruno Earth"; isFav: "Favorit"; img: "assets/image_18.png" }
                ListElement {Mgenre: "Pop"; Mjudul: "Nama musik 4"; Mpenyanyi: "Blue Day"; isFav: ""; img: "assets/image_19.png" }
                ListElement {Mgenre: "Rock"; Mjudul: "Nama musik 5"; Mpenyanyi: "Blue Day"; isFav: ""; img: "assets/image_18.png" }
                ListElement {Mgenre: "Pop"; Mjudul: "Nama musik 6"; Mpenyanyi: "Justin Bibir"; isFav: ""; img: "assets/image_19.png" }
                ListElement {Mgenre: "Pop"; Mjudul: "Nama musik 7"; Mpenyanyi: "Blue Day"; isFav: ""; img: "assets/image_19.png" }
            }

            delegate: Item {
                width: musicList.width
                property bool matches: (
                                        kategori === "genre" ? model.Mgenre === genre :
                                        kategori === "judul" ? model.Mjudul === judul:
                                        kategori === "penyanyi" ? model.Mpenyanyi === penyanyi:
                                        kategori === "Favorit" ? model.isFav === "Favorit" :
                                        (searchInput.text === "" ||
                                        model.Mjudul.trim().toLowerCase().includes(searchInput.text.trim().toLowerCase()) ||
                                        model.Mpenyanyi.trim().toLowerCase().includes(searchInput.text.trim().toLowerCase()))
                                       )
                visible: matches
                height: matches ? 100 * root.dp : 0

                Row {
                    anchors.fill: parent
                    anchors.topMargin: 8 * root.dp
                    anchors.leftMargin: 16 * root.dp
                    spacing: 12 * root.dp
                    Image { source: Qt.resolvedUrl(model.img); width: 84 * root.dp; height: 84 * root.dp }
                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        Text { text: model.Mjudul; font.bold: true }
                        Text { text: model.Mpenyanyi; color: "#828282" }
                        Text { text: model.isFav }
                    }
                }

                MouseArea {
                    id: albumTouch
                    anchors.fill: parent
                    onClicked: {
                        myStack.push("HalamanPemutaran.qml", {
                            "musik": model.Mjudul,
                            "penyanyi": model.Mpenyanyi
                        })
                    }
                }
            }
        }
    }
    Rectangle {
        id: navigationBar
        z: 10
        width: parent.width
        height: 60 * root.dp
        color: "#ffffff"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30 * root.dp

        Row {
            anchors.fill: parent

            Repeater {
                model: [
                    { name: "Utama",     icon: "components/Icon_Tab_Home.qml" },
                    { name: "Kategori", icon: "components/Icon_Tab_Discover.qml" },
                    { name: "Notifikasi",    icon: "components/Icon_3pt_Bell.qml" },
                    { name: "Profile",  icon: "components/Icon_Person.qml" }
                ]

                delegate: Item {
                    width: navigationBar.width / 4
                    height: navigationBar.height

                    Loader {
                        source: "../" + modelData.icon
                        anchors.centerIn: parent
                        scale: root.dp
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            myStack.push("Halaman" + modelData.name + ".qml")
                        }
                    }
                }
            }
        }
    }
}
