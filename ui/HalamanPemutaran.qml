import QtQuick
import QtQuick.Shapes

Rectangle {
    id: halaman_pemutaran

    height: 812
    width: 375

    clip: true
    color: "#ffffff"

    property string judul: ""
    property string penyanyi: ""
    property bool favorit: false

    Rectangle {
        id: map

        y: 93

        height: 272
        width: 376

        clip: true
        color: "#fafcff"
        visible: false

        Image {
            id: map_1

            clip: true
            source: Qt.resolvedUrl("assets/map.png")
        }
        Image {
            id: chip

            x: 151.50
            y: 33

            source: Qt.resolvedUrl("assets/chip.png")
        }
        Image {
            id: chip_1

            x: 32.50
            y: 59

            source: Qt.resolvedUrl("assets/chip_1.png")
        }
        Image {
            id: chip_2

            x: 22.50
            y: 146

            source: Qt.resolvedUrl("assets/chip_2.png")
        }
        Image {
            id: chip_3

            x: 99.50
            y: 184

            source: Qt.resolvedUrl("assets/chip_3.png")
        }
        Image {
            id: chip_4

            x: 292
            y: 60

            source: Qt.resolvedUrl("assets/chip_4.png")
        }
        Image {
            id: chip_5

            x: 271
            y: 153

            source: Qt.resolvedUrl("assets/chip_5.png")
        }
    }
    Image {
        id: image

        x: 5
        y: 93

        clip: true
        source: Qt.resolvedUrl("assets/image_11.png")

        Rectangle {
            id: chip_6

            x: 100
            y: 88

            height: 28
            width: 170

            color: "#00000000"
            radius: 24

            Image {
                id: price

                x: -59.50

                source: Qt.resolvedUrl("assets/price.png")
            }
        }
    }
    Image {
        id: header

        x: -5
        y: 44

        clip: true
        source: Qt.resolvedUrl("assets/header.png")

        Rectangle {
            id: icon_Chevron_Left

            x: 16
            y: 9

            height: 24
            width: 24

            color: "transparent"

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
        }
    }
    Rectangle {
        id: _list

        y: 463

        height: 320
        width: 376

        clip: true
        color: "#ffffff"
        topLeftRadius: 24
        topRightRadius: 24

        Rectangle {
            id: handle

            height: 24
            width: 375

            color: "transparent"

            Rectangle {
                id: handle_1

                x: 164
                y: 8

                height: 4
                width: 48

                color: "#33000000"
                radius: 100
            }
        }
        Rectangle {
            id: listing

            x: 16
            y: 24

            height: 640
            width: 344

            color: "transparent"

            Rectangle {
                id: checkout_Info

                height: 640
                width: 344

                color: "transparent"

                Image {
                    id: items

                    clip: true
                    source: Qt.resolvedUrl("assets/items.png")

                    Rectangle {
                        id: _item

                        x: 16
                        y: 25

                        height: 84
                        width: 324

                        clip: true
                        color: "transparent"

                        Image {
                            id: image_1

                            clip: true
                            source: Qt.resolvedUrl("assets/image_12.png")
                        }
                        Rectangle {
                            id: info

                            x: 112

                            height: 62
                            width: 148

                            color: "transparent"

                            Text {
                                id: nama_musik

                                height: 20
                                width: 149

                                color: "#000000"
                                elide: Text.ElideRight
                                font.family: "Inter"
                                font.pixelSize: 14
                                font.weight: Font.Normal
                                horizontalAlignment: Text.AlignLeft
                                lineHeight: 19.60
                                lineHeightMode: Text.FixedHeight
                                text: musik
                                textFormat: Text.PlainText
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                            }
                            Text {
                                id: band

                                y: 22

                                height: 18
                                width: 149

                                color: "#80000000"
                                elide: Text.ElideRight
                                font.family: "Inter"
                                font.pixelSize: 12
                                font.weight: Font.Normal
                                horizontalAlignment: Text.AlignLeft
                                lineHeight: 18
                                lineHeightMode: Text.FixedHeight
                                text: "Band "
                                textFormat: Text.PlainText
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                            }
                            Text {
                                id: favorit

                                y: 42

                                height: 20
                                width: 149

                                color: "#000000"
                                elide: Text.ElideRight
                                font.family: "Inter"
                                font.pixelSize: 14
                                font.weight: Font.Normal
                                horizontalAlignment: Text.AlignLeft
                                lineHeight: 19.60
                                lineHeightMode: Text.FixedHeight
                                text: "Favorit"
                                textFormat: Text.PlainText
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                            }
                        }
                    }
                    Rectangle {
                        id: _item_1

                        x: 16
                        y: 227

                        height: 84
                        width: 324

                        clip: true
                        color: "transparent"

                        Image {
                            id: image_2

                            clip: true
                            source: Qt.resolvedUrl("assets/image_13.png")
                        }
                        Rectangle {
                            id: info_1

                            x: 112

                            height: 62
                            width: 148

                            color: "transparent"

                            Text {
                                id: nama_musik_1

                                height: 20
                                width: 149

                                color: "#000000"
                                elide: Text.ElideRight
                                font.family: "Inter"
                                font.pixelSize: 14
                                font.weight: Font.Normal
                                horizontalAlignment: Text.AlignLeft
                                lineHeight: 19.60
                                lineHeightMode: Text.FixedHeight
                                text: "Nama musik "
                                textFormat: Text.PlainText
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                            }
                            Text {
                                id: band_1

                                y: 22

                                height: 18
                                width: 149

                                color: "#80000000"
                                elide: Text.ElideRight
                                font.family: "Inter"
                                font.pixelSize: 12
                                font.weight: Font.Normal
                                horizontalAlignment: Text.AlignLeft
                                lineHeight: 18
                                lineHeightMode: Text.FixedHeight
                                text: "Band "
                                textFormat: Text.PlainText
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                            }
                            Text {
                                id: favorit_1

                                y: 42

                                height: 20
                                width: 149

                                color: "#000000"
                                elide: Text.ElideRight
                                font.family: "Inter"
                                font.pixelSize: 14
                                font.weight: Font.Normal
                                horizontalAlignment: Text.AlignLeft
                                lineHeight: 19.60
                                lineHeightMode: Text.FixedHeight
                                text: "Favorit"
                                textFormat: Text.PlainText
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                            }
                        }
                    }
                    Rectangle {
                        id: _item_2

                        x: 16
                        y: 126

                        height: 84
                        width: 324

                        clip: true
                        color: "transparent"

                        Image {
                            id: image_3

                            clip: true
                            source: Qt.resolvedUrl("assets/image_14.png")
                        }
                        Rectangle {
                            id: info_2

                            x: 112

                            height: 62
                            width: 148

                            color: "transparent"

                            Text {
                                id: nama_musik_2

                                height: 20
                                width: 149

                                color: "#000000"
                                elide: Text.ElideRight
                                font.family: "Inter"
                                font.pixelSize: 14
                                font.weight: Font.Normal
                                horizontalAlignment: Text.AlignLeft
                                lineHeight: 19.60
                                lineHeightMode: Text.FixedHeight
                                text: "Nama musik "
                                textFormat: Text.PlainText
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                            }
                            Text {
                                id: band_2

                                y: 22

                                height: 18
                                width: 149

                                color: "#80000000"
                                elide: Text.ElideRight
                                font.family: "Inter"
                                font.pixelSize: 12
                                font.weight: Font.Normal
                                horizontalAlignment: Text.AlignLeft
                                lineHeight: 18
                                lineHeightMode: Text.FixedHeight
                                text: "Band "
                                textFormat: Text.PlainText
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                            }
                            Text {
                                id: favorit_2

                                y: 42

                                height: 20
                                width: 149

                                color: "#000000"
                                elide: Text.ElideRight
                                font.family: "Inter"
                                font.pixelSize: 14
                                font.weight: Font.Normal
                                horizontalAlignment: Text.AlignLeft
                                lineHeight: 19.60
                                lineHeightMode: Text.FixedHeight
                                text: "Favorit"
                                textFormat: Text.PlainText
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                            }
                        }
                    }
                    Rectangle {
                        id: _item_3

                        x: 16
                        y: 328

                        height: 84
                        width: 343

                        clip: true
                        color: "transparent"

                        Image {
                            id: image_4

                            clip: true
                            source: Qt.resolvedUrl("assets/image_15.png")
                        }
                        Rectangle {
                            id: info_3

                            x: 112

                            height: 40
                            width: 148

                            color: "transparent"

                            Text {
                                id: nama_musik_3

                                height: 20
                                width: 149

                                color: "#000000"
                                elide: Text.ElideRight
                                font.family: "Inter"
                                font.pixelSize: 14
                                font.weight: Font.Normal
                                horizontalAlignment: Text.AlignLeft
                                lineHeight: 19.60
                                lineHeightMode: Text.FixedHeight
                                text: "Nama musik "
                                textFormat: Text.PlainText
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                            }
                            Text {
                                id: band_3

                                y: 22

                                height: 18
                                width: 149

                                color: "#80000000"
                                elide: Text.ElideRight
                                font.family: "Inter"
                                font.pixelSize: 12
                                font.weight: Font.Normal
                                horizontalAlignment: Text.AlignLeft
                                lineHeight: 18
                                lineHeightMode: Text.FixedHeight
                                text: "Band "
                                textFormat: Text.PlainText
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                            }
                        }
                    }
                    Rectangle {
                        id: _item_4

                        x: 16
                        y: 530

                        height: 84
                        width: 343

                        clip: true
                        color: "transparent"

                        Image {
                            id: image_5

                            clip: true
                            source: Qt.resolvedUrl("assets/image_16.png")
                        }
                        Rectangle {
                            id: info_4

                            x: 112

                            height: 40
                            width: 148

                            color: "transparent"

                            Text {
                                id: nama_musik_4

                                height: 20
                                width: 149

                                color: "#000000"
                                elide: Text.ElideRight
                                font.family: "Inter"
                                font.pixelSize: 14
                                font.weight: Font.Normal
                                horizontalAlignment: Text.AlignLeft
                                lineHeight: 19.60
                                lineHeightMode: Text.FixedHeight
                                text: "Nama musik "
                                textFormat: Text.PlainText
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                            }
                            Text {
                                id: band_4

                                y: 22

                                height: 18
                                width: 149

                                color: "#80000000"
                                elide: Text.ElideRight
                                font.family: "Inter"
                                font.pixelSize: 12
                                font.weight: Font.Normal
                                horizontalAlignment: Text.AlignLeft
                                lineHeight: 18
                                lineHeightMode: Text.FixedHeight
                                text: "Band "
                                textFormat: Text.PlainText
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                            }
                        }
                    }
                    Rectangle {
                        id: _item_5

                        x: 16
                        y: 429

                        height: 84
                        width: 343

                        clip: true
                        color: "transparent"

                        Image {
                            id: image_6

                            clip: true
                            source: Qt.resolvedUrl("assets/image_17.png")
                        }
                        Rectangle {
                            id: info_5

                            x: 112

                            height: 40
                            width: 148

                            color: "transparent"

                            Text {
                                id: nama_musik_5

                                height: 20
                                width: 149

                                color: "#000000"
                                elide: Text.ElideRight
                                font.family: "Inter"
                                font.pixelSize: 14
                                font.weight: Font.Normal
                                horizontalAlignment: Text.AlignLeft
                                lineHeight: 19.60
                                lineHeightMode: Text.FixedHeight
                                text: "Nama musik "
                                textFormat: Text.PlainText
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                            }
                            Text {
                                id: band_5

                                y: 22

                                height: 18
                                width: 149

                                color: "#80000000"
                                elide: Text.ElideRight
                                font.family: "Inter"
                                font.pixelSize: 12
                                font.weight: Font.Normal
                                horizontalAlignment: Text.AlignLeft
                                lineHeight: 18
                                lineHeightMode: Text.FixedHeight
                                text: "Band "
                                textFormat: Text.PlainText
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                            }
                        }
                    }
                    Image {
                        id: header_1

                        clip: true
                        source: Qt.resolvedUrl("assets/header_1.png")

                        Text {
                            id: akan_Diputar

                            x: 118
                            y: 9

                            height: 24
                            width: 105

                            color: "#000000"
                            font.family: "Inter"
                            font.letterSpacing: -0.34
                            font.pixelSize: 17
                            font.weight: Font.DemiBold
                            horizontalAlignment: Text.AlignHCenter
                            lineHeight: 23.80
                            lineHeightMode: Text.FixedHeight
                            text: "Akan Diputar"
                            textFormat: Text.PlainText
                            verticalAlignment: Text.AlignTop
                        }
                    }
                }
            }
        }
    }
    Rectangle {
        id: info_6

        x: 18
        y: 365

        height: 60
        width: 148

        color: "transparent"

        Text {
            id: nama_musik_6

            height: 40
            width: 149

            color: "#000000"
            elide: Text.ElideRight
            font.family: "Inter"
            font.pixelSize: 14
            font.weight: Font.Normal
            horizontalAlignment: Text.AlignLeft
            lineHeight: 19.60
            lineHeightMode: Text.FixedHeight
            text: "Nama musik "
            textFormat: Text.PlainText
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
        }
        Text {
            id: band_6

            y: 42

            height: 18
            width: 149

            color: "#80000000"
            elide: Text.ElideRight
            font.family: "Inter"
            font.pixelSize: 12
            font.weight: Font.Normal
            horizontalAlignment: Text.AlignLeft
            lineHeight: 18
            lineHeightMode: Text.FixedHeight
            text: "Band "
            textFormat: Text.PlainText
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
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
                            let targetPage = "Halaman" + modelData.name + ".qml"
                            if (myStack.currentItem.objectName !== modelData.name) {
                                myStack.replace(targetPage)
                            }
                        }
                    }
                }
            }
        }
    }
    Text {
        id: favorit_3

        x: 298
        y: 375

        height: 20
        width: 149

        color: "#000000"
        elide: Text.ElideRight
        font.family: "Inter"
        font.pixelSize: 14
        font.weight: Font.Normal
        horizontalAlignment: Text.AlignLeft
        lineHeight: 19.60
        lineHeightMode: Text.FixedHeight
        text: "Favorit"
        textFormat: Text.PlainText
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.Wrap
    }
}