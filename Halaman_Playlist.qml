import QtQuick
import QtQuick.Shapes

Image {
    id: halaman_Playlist

    clip: true
    source: Qt.resolvedUrl("assets/halaman_Playlist_1.png")

    Rectangle {
        id: checkout_Info

        x: 1
        y: 127

        height: 538
        width: 375

        color: "transparent"

        Image {
            id: items

            clip: true
            source: Qt.resolvedUrl("assets/items_2.png")

            Rectangle {
                id: _item

                x: 19
                y: 429

                height: 84
                width: 337

                clip: true
                color: "#f5ecff"

                Rectangle {
                    id: info

                    height: 84
                    width: 334

                    color: "transparent"

                    Text {
                        id: element

                        height: 84
                        width: 335

                        color: "#000000"
                        elide: Text.ElideRight
                        font.family: "Inter"
                        font.pixelSize: 40
                        font.weight: Font.Normal
                        horizontalAlignment: Text.AlignHCenter
                        lineHeight: 56
                        lineHeightMode: Text.FixedHeight
                        text: "+"
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
            Rectangle {
                id: _item_1

                x: 16
                y: 328

                height: 84
                width: 337

                clip: true
                color: "transparent"

                Image {
                    id: image

                    clip: true
                    source: Qt.resolvedUrl("assets/image_11.png")
                }
                Rectangle {
                    id: info_1

                    x: 112

                    height: 40
                    width: 148

                    color: "transparent"

                    Text {
                        id: nama_Playlist

                        height: 20
                        width: 149

                        color: "#ffffff"
                        elide: Text.ElideRight
                        font.family: "Inter"
                        font.pixelSize: 14
                        font.weight: Font.Normal
                        horizontalAlignment: Text.AlignLeft
                        lineHeight: 19.60
                        lineHeightMode: Text.FixedHeight
                        text: "Nama Playlist "
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }
                    Text {
                        id: xx_lagu

                        y: 22

                        height: 18
                        width: 149

                        color: "#80ffffff"
                        elide: Text.ElideRight
                        font.family: "Inter"
                        font.pixelSize: 12
                        font.weight: Font.Normal
                        horizontalAlignment: Text.AlignLeft
                        lineHeight: 18
                        lineHeightMode: Text.FixedHeight
                        text: "xx lagu"
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }
                }
            }
            Rectangle {
                id: _item_2

                x: 16
                y: 227

                height: 84
                width: 337

                clip: true
                color: "transparent"

                Image {
                    id: image_1

                    clip: true
                    source: Qt.resolvedUrl("assets/image_12.png")
                }
                Rectangle {
                    id: info_2

                    x: 112

                    height: 40
                    width: 148

                    color: "transparent"

                    Text {
                        id: nama_Playlist_1

                        height: 20
                        width: 149

                        color: "#ffffff"
                        elide: Text.ElideRight
                        font.family: "Inter"
                        font.pixelSize: 14
                        font.weight: Font.Normal
                        horizontalAlignment: Text.AlignLeft
                        lineHeight: 19.60
                        lineHeightMode: Text.FixedHeight
                        text: "Nama Playlist"
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }
                    Text {
                        id: xx_lagu_1

                        y: 22

                        height: 18
                        width: 149

                        color: "#80ffffff"
                        elide: Text.ElideRight
                        font.family: "Inter"
                        font.pixelSize: 12
                        font.weight: Font.Normal
                        horizontalAlignment: Text.AlignLeft
                        lineHeight: 18
                        lineHeightMode: Text.FixedHeight
                        text: "xx lagu"
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }
                }
            }
            Rectangle {
                id: _item_3

                x: 16
                y: 126

                height: 84
                width: 337

                clip: true
                color: "transparent"

                Image {
                    id: image_2

                    clip: true
                    source: Qt.resolvedUrl("assets/image_13.png")
                }
                Rectangle {
                    id: info_3

                    x: 112

                    height: 40
                    width: 148

                    color: "transparent"

                    Text {
                        id: nama_Playlist_2

                        height: 20
                        width: 149

                        color: "#ffffff"
                        elide: Text.ElideRight
                        font.family: "Inter"
                        font.pixelSize: 14
                        font.weight: Font.Normal
                        horizontalAlignment: Text.AlignLeft
                        lineHeight: 19.60
                        lineHeightMode: Text.FixedHeight
                        text: "Nama Playlist"
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }
                    Text {
                        id: xx_lagu_2

                        y: 22

                        height: 18
                        width: 149

                        color: "#80ffffff"
                        elide: Text.ElideRight
                        font.family: "Inter"
                        font.pixelSize: 12
                        font.weight: Font.Normal
                        horizontalAlignment: Text.AlignLeft
                        lineHeight: 18
                        lineHeightMode: Text.FixedHeight
                        text: "xx lagu "
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }
                }
            }
            Rectangle {
                id: _item_4

                x: 16
                y: 25

                height: 84
                width: 337

                clip: true
                color: "transparent"

                Image {
                    id: image_3

                    clip: true
                    source: Qt.resolvedUrl("assets/image_14.png")
                }
                Rectangle {
                    id: info_4

                    x: 112

                    height: 40
                    width: 148

                    color: "transparent"

                    Text {
                        id: nama_Playlist_3

                        height: 20
                        width: 149

                        color: "#ffffff"
                        elide: Text.ElideRight
                        font.family: "Inter"
                        font.pixelSize: 14
                        font.weight: Font.Normal
                        horizontalAlignment: Text.AlignLeft
                        lineHeight: 19.60
                        lineHeightMode: Text.FixedHeight
                        text: "Nama Playlist "
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }
                    Text {
                        id: xx_lagu_3

                        y: 22

                        height: 18
                        width: 149

                        color: "#80ffffff"
                        elide: Text.ElideRight
                        font.family: "Inter"
                        font.pixelSize: 12
                        font.weight: Font.Normal
                        horizontalAlignment: Text.AlignLeft
                        lineHeight: 18
                        lineHeightMode: Text.FixedHeight
                        text: "xx lagu"
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }
                }
            }
        }
    }
    Image {
        id: header

        y: 44

        clip: true
        source: Qt.resolvedUrl("assets/header_2.png")

        Rectangle {
            id: icon_Chevron_Left

            x: 16
            y: 9

            height: 24
            width: 24

            color: "transparent"

            Shape {
                id: chevron_left_thin

                x: 6.94
                y: 3.57

                height: 16.86
                width: 9.49

                ShapePath {
                    id: chevron_left_thin_ShapePath0

                    fillColor: "#ffffff"
                    fillRule: ShapePath.WindingFill
                    joinStyle: ShapePath.MiterJoin
                    strokeColor: "#00000000"
                    strokeStyle: ShapePath.SolidLine
                    strokeWidth: 0.50

                    PathSvg {
                        id: chevron_left_thin_ShapePath0_PathSvg0

                        path: "M 2.338477373123169 8.429289817810059 L 9.348527908325195 1.4192390441894531 C 9.543790072202682 1.2239768654108047 9.543790131807327 0.9073939919471741 9.348527908325195 0.7121318578720093 L 8.782841682434082 0.14644651114940643 C 8.587579518556595 -0.048815563321113586 8.27099721133709 -0.04881548881530762 8.075735092163086 0.14644664525985718 L 0.1464465856552124 8.075736045837402 C -0.0488155335187912 8.270998179912567 -0.0488155335187912 8.587580502033234 0.1464465856552124 8.782842636108398 L 8.075735092163086 16.712133407592773 C 8.270997241139412 16.90739557147026 8.587580487132072 16.907393649220467 8.782842636108398 16.71213150024414 L 9.348527908325195 16.146446228027344 C 9.543790057301521 15.951184079051018 9.543790072202682 15.634601786732674 9.348527908325195 15.439339637756348 L 2.338477373123169 8.429289817810059 Z"
                    }
                }
            }
        }
        Text {
            id: playlist

            x: 160
            y: 9

            height: 24
            width: 58

            color: "#ffffff"
            font.family: "Inter"
            font.letterSpacing: -0.34
            font.pixelSize: 17
            font.weight: Font.DemiBold
            horizontalAlignment: Text.AlignHCenter
            lineHeight: 23.80
            lineHeightMode: Text.FixedHeight
            text: "Playlist"
            textFormat: Text.PlainText
            verticalAlignment: Text.AlignTop
        }
    }
    Rectangle {
        id: search

        x: 13
        y: 94

        height: 40
        width: 343

        color: "#f5ecff"
        radius: 8

        Rectangle {
            id: search_1

            x: 12
            y: 8

            height: 24
            width: 24

            clip: true
            color: "transparent"

            Shape {
                id: _vector

                x: 3
                y: 3

                height: 16
                width: 16

                ShapePath {
                    id: _vector_ShapePath0

                    fillColor: "#00000000"
                    strokeColor: "#000000"
                    strokeWidth: 2

                    PathSvg {
                        id: _vector_ShapePath0_PathSvg0

                        path: "M 16 8 C 16 12.418278217315674 12.418278217315674 16 8 16 C 3.581721782684326 16 0 12.418278217315674 0 8 C 0 3.581721782684326 3.581721782684326 0 8 0 C 12.418278217315674 0 16 3.581721782684326 16 8 Z"
                    }
                }
            }
            Shape {
                id: _vector_1

                x: 16.65
                y: 16.65

                height: 4.35
                width: 4.35

                ShapePath {
                    id: _vector_1_ShapePath0

                    fillColor: "#00000000"
                    strokeColor: "#000000"
                    strokeWidth: 2

                    PathSvg {
                        id: _vector_1_ShapePath0_PathSvg0

                        path: "M 4.350000381469727 4.350000381469727 L 0 0"
                    }
                }
            }
        }
        Text {
            id: label

            x: 48
            y: 8

            height: 24
            width: 280

            color: "#000000"
            elide: Text.ElideRight
            font.family: "Inter"
            font.pixelSize: 16
            font.weight: Font.Normal
            horizontalAlignment: Text.AlignLeft
            lineHeight: 24
            lineHeightMode: Text.FixedHeight
            text: "Search"
            textFormat: Text.PlainText
            verticalAlignment: Text.AlignTop
            wrapMode: Text.Wrap
        }
    }
    Rectangle {
        id: status_Bar

        height: 44
        width: 375

        clip: true
        color: "transparent"

        Item {
            id: notch

            x: 78
            y: -2

            height: 30
            width: 219

            visible: false

            Rectangle {
                id: bG

                x: -78
                y: 2

                height: 44
                width: 375

                color: "#000000"
                visible: false
            }
            Image {
                id: exclude

                x: -78
                y: 2

                source: Qt.resolvedUrl("assets/exclude_5.png")
                visible: false
            }
            Shape {
                id: notch_1

                height: 30
                width: 219

                ShapePath {
                    id: notch_1_ShapePath0

                    fillColor: "#000000"
                    fillRule: ShapePath.WindingFill
                    joinStyle: ShapePath.MiterJoin
                    strokeColor: "#00000000"
                    strokeStyle: ShapePath.SolidLine
                    strokeWidth: 0.67

                    PathSvg {
                        id: notch_1_ShapePath0_PathSvg0

                        path: "M 0 0 L 219 0 L 215.4666336479537 1.0112359550561798 L 215.3165137614679 5.561797752808989 L 215.3165137614679 30 L 3.68348623853211 30 L 3.68348623853211 5.561797752808989 L 3.533375293836681 1.0112359550561798 L 0 0 Z"
                    }
                }
            }
        }
        Item {
            id: right_Side

            x: 293.67
            y: 17.33

            height: 11.34
            width: 66.66

            Item {
                id: battery

                x: 42.33

                height: 11.33
                width: 24.33

                Shape {
                    id: rectangle

                    height: 11.33
                    width: 22

                    opacity: 0.35

                    ShapePath {
                        id: rectangle_ShapePath0

                        fillColor: "#00000000"
                        fillRule: ShapePath.OddEvenFill
                        strokeColor: "#ffffff"
                        strokeWidth: 1

                        PathSvg {
                            id: rectangle_ShapePath0_PathSvg0

                            path: "M 0 0 L 22 0 L 22 11.333333015441895 L 0 11.333333015441895 L 0 0 Z"
                        }
                    }
                }
                Shape {
                    id: combined_Shape

                    x: 23
                    y: 3.67

                    height: 4
                    width: 1.33

                    opacity: 0.40

                    ShapePath {
                        id: combined_Shape_ShapePath0

                        fillColor: "#ffffff"
                        fillRule: ShapePath.WindingFill
                        strokeColor: "#00000000"
                        strokeWidth: 0

                        PathSvg {
                            id: combined_Shape_ShapePath0_PathSvg0

                            path: "M 0 0 L 0 4 C 0.8047311305999756 3.6612234711647034 1.328037977218628 2.8731333017349243 1.328037977218628 2 C 1.328037977218628 1.1268666982650757 0.8047311305999756 0.33877652883529663 0 0 Z"
                        }
                    }
                }
                Shape {
                    id: rectangle_1

                    x: 2
                    y: 2

                    height: 7.33
                    width: 18

                    ShapePath {
                        id: rectangle_1_ShapePath0

                        fillColor: "#ffffff"
                        fillRule: ShapePath.WindingFill
                        strokeColor: "#00000000"
                        strokeWidth: 0

                        PathSvg {
                            id: rectangle_1_ShapePath0_PathSvg0

                            path: "M 0 0 L 18 0 L 18 7.333333492279053 L 0 7.333333492279053 L 0 0 Z"
                        }
                    }
                }
            }
            Image {
                id: wifi

                x: 22.03

                source: Qt.resolvedUrl("assets/wifi_5.png")
            }
            Image {
                id: mobile_Signal

                y: 0.34

                source: Qt.resolvedUrl("assets/mobile_Signal_5.png")
            }
            Item {
                id: recording_Indicator

                x: 4.33
                y: -9.33

                height: 6
                width: 6

                visible: false

                Image {
                    id: indicator

                    source: Qt.resolvedUrl("assets/indicator_5.png")
                }
            }
        }
        Item {
            id: left_Side

            x: 21
            y: 12

            height: 21
            width: 54

            Rectangle {
                id: _time

                height: 21
                width: 54

                color: "transparent"
                radius: 32

                Shape {
                    id: element_1

                    x: 12.45
                    y: 5.17

                    height: 11.09
                    width: 28.43

                    ShapePath {
                        id: element_1_ShapePath0

                        fillColor: "#ffffff"
                        fillRule: ShapePath.WindingFill
                        strokeColor: "#00000000"
                        strokeWidth: 0

                        PathSvg {
                            id: element_1_ShapePath0_PathSvg0

                            path: "M 3.8671875 11.0888671875 C 6.55517578125 11.0888671875 8.15185546875 8.98681640625 8.15185546875 5.42724609375 C 8.15185546875 4.0869140625 7.8955078125 2.958984375 7.40478515625 2.08740234375 C 6.6943359375 0.732421875 5.47119140625 0 3.92578125 0 C 1.6259765625 0 0 1.54541015625 0 3.71337890625 C 0 5.74951171875 1.46484375 7.22900390625 3.47900390625 7.22900390625 C 4.716796875 7.22900390625 5.72021484375 6.650390625 6.21826171875 5.64697265625 L 6.240234375 5.64697265625 C 6.240234375 5.64697265625 6.26953125 5.64697265625 6.27685546875 5.64697265625 C 6.29150390625 5.64697265625 6.3427734375 5.64697265625 6.3427734375 5.64697265625 C 6.3427734375 8.06396484375 5.42724609375 9.5068359375 3.8818359375 9.5068359375 C 2.9736328125 9.5068359375 2.2705078125 9.0087890625 2.02880859375 8.21044921875 L 0.146484375 8.21044921875 C 0.46142578125 9.9462890625 1.93359375 11.0888671875 3.8671875 11.0888671875 Z M 3.93310546875 5.7275390625 C 2.71728515625 5.7275390625 1.85302734375 4.86328125 1.85302734375 3.65478515625 C 1.85302734375 2.4755859375 2.76123046875 1.57470703125 3.9404296875 1.57470703125 C 5.11962890625 1.57470703125 6.02783203125 2.490234375 6.02783203125 3.68408203125 C 6.02783203125 4.86328125 5.1416015625 5.7275390625 3.93310546875 5.7275390625 Z"
                        }
                    }
                    ShapePath {
                        id: element_1_ShapePath1

                        fillColor: "#ffffff"
                        fillRule: ShapePath.WindingFill
                        strokeColor: "#00000000"
                        strokeWidth: 0

                        PathSvg {
                            id: element_1_ShapePath1_PathSvg0

                            path: "M 11.24296760559082 10.986328125 C 11.93876838684082 10.986328125 12.41484260559082 10.48828125 12.41484260559082 9.8291015625 C 12.41484260559082 9.16259765625 11.93876838684082 8.671875 11.24296760559082 8.671875 C 10.55449104309082 8.671875 10.07109260559082 9.16259765625 10.07109260559082 9.8291015625 C 10.07109260559082 10.48828125 10.55449104309082 10.986328125 11.24296760559082 10.986328125 Z M 11.24296760559082 5.4931640625 C 11.93876838684082 5.4931640625 12.41484260559082 5.00244140625 12.41484260559082 4.34326171875 C 12.41484260559082 3.6767578125 11.93876838684082 3.18603515625 11.24296760559082 3.18603515625 C 10.55449104309082 3.18603515625 10.07109260559082 3.6767578125 10.07109260559082 4.34326171875 C 10.07109260559082 5.00244140625 10.55449104309082 5.4931640625 11.24296760559082 5.4931640625 Z"
                        }
                    }
                    ShapePath {
                        id: element_1_ShapePath2

                        fillColor: "#ffffff"
                        fillRule: ShapePath.WindingFill
                        strokeColor: "#00000000"
                        strokeWidth: 0

                        PathSvg {
                            id: element_1_ShapePath2_PathSvg0

                            path: "M 19.270605087280273 10.83251953125 L 21.079687118530273 10.83251953125 L 21.079687118530273 8.8623046875 L 22.507909774780273 8.8623046875 L 22.507909774780273 7.265625 L 21.079687118530273 7.265625 L 21.079687118530273 0.263671875 L 18.413671493530273 0.263671875 C 16.545995712280273 3.076171875 15.059179306030273 5.42724609375 14.107030868530273 7.177734375 L 14.107030868530273 8.8623046875 L 19.270605087280273 8.8623046875 L 19.270605087280273 10.83251953125 Z M 15.857519149780273 7.19970703125 C 17.087987899780273 5.03173828125 18.186620712280273 3.2958984375 19.197362899780273 1.8017578125 L 19.299901962280273 1.8017578125 L 19.299901962280273 7.3095703125 L 15.857519149780273 7.3095703125 L 15.857519149780273 7.19970703125 Z"
                        }
                    }
                    ShapePath {
                        id: element_1_ShapePath3

                        fillColor: "#ffffff"
                        fillRule: ShapePath.WindingFill
                        strokeColor: "#00000000"
                        strokeWidth: 0

                        PathSvg {
                            id: element_1_ShapePath3_PathSvg0

                            path: "M 26.53652000427246 10.83251953125 L 28.42616844177246 10.83251953125 L 28.42616844177246 0.263671875 L 26.54384422302246 0.263671875 L 23.78261375427246 2.197265625 L 23.78261375427246 4.013671875 L 26.41200828552246 2.16796875 L 26.53652000427246 2.16796875 L 26.53652000427246 10.83251953125 Z"
                        }
                    }
                }
            }
        }
    }
    Image {
        id: tab_Bar

        x: 0.50
        y: 733.50

        source: Qt.resolvedUrl("assets/tab_Bar_3.png")
    }
}