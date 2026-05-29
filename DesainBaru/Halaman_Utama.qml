import QtQuick.Shapes
import QtQuick

Shape {
    id: halaman_Utama

    height: 812
    width: 375

    clip: true

    ShapePath {
        id: halaman_UtamaShapePath

        strokeColor: "#000"
        strokeWidth: 0

        fillGradient: RadialGradient {
            id: gradientNode
        
            centerRadius: Math.max(halaman_Utama.width, halaman_Utama.height) * 1.0158982230177005
            centerX: halaman_Utama.width * 0.4986666406781146
            centerY: halaman_Utama.height * 0.16133003937350598
            focalRadius: Math.max(halaman_Utama.width, halaman_Utama.height) * 0
            focalX: halaman_Utama.width * 0.4986666406781146
            focalY: halaman_Utama.height * 0.16133003937350598
        
            GradientStop {
                color: "#ff000000"
                position: 0
            }
            GradientStop {
                color: "#ff9b49f2"
                position: 1
            }
        }

        PathRectangle {
            id: halaman_UtamaPathRectangle

            x: 0
            y: 0

            height: halaman_Utama.height
            width: halaman_Utama.width
        }
    }
    Item {
        id: row

        x: 9
        y: 307

        height: 38.56
        width: 291.93

        Rectangle {
            id: title

            height: 38.56
            width: 291.93

            clip: true
            color: "transparent"

            Text {
                id: sering_Diputar

                x: 16
                y: 8.28

                height: 22
                width: 109

                color: "#ffffff"
                font.family: "Inter"
                font.letterSpacing: -0.32
                font.pixelSize: 16
                font.weight: Font.DemiBold
                horizontalAlignment: Text.AlignLeft
                lineHeight: 22.40
                lineHeightMode: Text.FixedHeight
                text: "Sering Diputar"
                textFormat: Text.PlainText
                verticalAlignment: Text.AlignVCenter
            }
            Item {
                id: chevron

                x: 134
                y: 9.28

                height: 20
                width: 20

                Image {
                    id: container

                    source: Qt.resolvedUrl("assets/container.png")
                }
                Icon_Chevron_Right_Slim_LTR {
                    id: icon_Chevron

                    x: 7
                    y: 3
                }
            }
        }
    }
    Item {
        id: row_1

        x: -4
        y: 531

        height: 196
        width: 500

        Rectangle {
            id: carousel

            height: 196
            width: 500

            color: "transparent"

            Rectangle {
                id: card

                x: 16
                y: 8

                height: 180
                width: 148

                clip: true
                color: "transparent"

                Image {
                    id: image

                    source: Qt.resolvedUrl("assets/image_4.png")
                }
                Rectangle {
                    id: info

                    y: 160

                    height: 20
                    width: 148

                    color: "transparent"

                    Text {
                        id: pop

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
                        text: "Pop"
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }
                }
            }
            Rectangle {
                id: card_1

                x: 176
                y: 8

                height: 180
                width: 148

                clip: true
                color: "transparent"

                Image {
                    id: image_1

                    source: Qt.resolvedUrl("assets/image_5.png")
                }
                Rectangle {
                    id: info_1

                    y: 160

                    height: 20
                    width: 148

                    color: "transparent"

                    Text {
                        id: rock

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
                        text: "Rock"
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }
                }
            }
            Rectangle {
                id: card_2

                x: 336
                y: 8

                height: 180
                width: 148

                clip: true
                color: "transparent"

                Image {
                    id: image_2

                    source: Qt.resolvedUrl("assets/image_6.png")
                }
                Rectangle {
                    id: info_2

                    y: 160

                    height: 20
                    width: 148

                    color: "transparent"

                    Text {
                        id: r_B

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
                        text: "R&B"
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }
                }
            }
        }
    }
    Rectangle {
        id: header

        x: 5
        y: 495

        height: 38
        width: 375

        clip: true
        color: "transparent"

        Text {
            id: genre

            x: 16
            y: 8

            height: 22
            width: 47

            color: "#ffffff"
            font.family: "Inter"
            font.letterSpacing: -0.32
            font.pixelSize: 16
            font.weight: Font.DemiBold
            horizontalAlignment: Text.AlignLeft
            lineHeight: 22.40
            lineHeightMode: Text.FixedHeight
            text: "Genre"
            textFormat: Text.PlainText
            verticalAlignment: Text.AlignVCenter
        }
        Item {
            id: group_123201

            x: 72
            y: 9

            height: 20
            width: 20

            Image {
                id: ellipse_160

                source: Qt.resolvedUrl("assets/ellipse_160.png")
            }
            Icon_Chevron_Right_Slim_LTR {
                id: icon_Chevron_Right_Slim_LTR

                x: 7
                y: 3
            }
        }
    }
    Image {
        id: banner

        x: 16
        y: 148

        clip: true
        source: Qt.resolvedUrl("assets/banner.png")

        Text {
            id: rilis_Terbaru

            x: 20
            y: 54

            height: 28
            width: 147

            color: "#000000"
            font.family: "Inter"
            font.letterSpacing: -0.40
            font.pixelSize: 20
            font.weight: Font.DemiBold
            horizontalAlignment: Text.AlignLeft
            lineHeight: 28
            lineHeightMode: Text.FixedHeight
            text: "Rilis Terbaru"
            textFormat: Text.PlainText
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
        }
        Rectangle {
            id: pagination

            x: 149
            y: 123

            height: 5
            width: 45

            clip: true
            color: "transparent"

            Image {
                id: selected

                source: Qt.resolvedUrl("assets/selected.png")
            }
            Image {
                id: _default

                x: 10

                source: Qt.resolvedUrl("assets/_default.png")
            }
            Image {
                id: _default_1

                x: 20

                source: Qt.resolvedUrl("assets/_default_1.png")
            }
            Image {
                id: _default_2

                x: 30

                source: Qt.resolvedUrl("assets/_default_2.png")
            }
            Image {
                id: _default_3

                x: 40

                source: Qt.resolvedUrl("assets/_default_3.png")
            }
        }
    }
    Rectangle {
        id: pills

        x: 1
        y: 104

        height: 32
        width: 382

        color: "transparent"

        Rectangle {
            id: pill

            height: 32
            width: 89

            border.color: "#ffffff"
            border.width: 1
            clip: true
            color: "transparent"
            radius: 6

            Rectangle {
                id: icon_Label

                x: 10
                y: 5

                height: 22
                width: 69

                color: "transparent"

                Icon_Like {
                    id: icon_Favorite

                    y: 2

                    clip: true
                    like_ShapePath0FillColor: "#ffffff"
                }
                Text {
                    id: label

                    x: 22

                    height: 22
                    width: 48

                    color: "#ffffff"
                    elide: Text.ElideRight
                    font.family: "Inter"
                    font.pixelSize: 14
                    font.weight: Font.Medium
                    horizontalAlignment: Text.AlignLeft
                    lineHeight: 22
                    lineHeightMode: Text.FixedHeight
                    text: "Favorit"
                    textFormat: Text.PlainText
                    verticalAlignment: Text.AlignTop
                }
            }
        }
        Rectangle {
            id: pill_1

            x: 97

            height: 32
            width: 95

            border.color: "#ffffff"
            border.width: 1
            clip: true
            color: "transparent"
            radius: 6

            Rectangle {
                id: icon_Label_1

                x: 10
                y: 5

                height: 22
                width: 75

                color: "transparent"

                Icon_Watch_History {
                    id: icon_History

                    y: 2

                    clip: true
                    watch_history_ShapePath0FillColor: "#ffffff"
                    watch_history_ShapePath1FillColor: "#ffffff"
                }
                Text {
                    id: label_1

                    x: 22

                    height: 22
                    width: 54

                    color: "#ffffff"
                    elide: Text.ElideRight
                    font.family: "Inter"
                    font.pixelSize: 14
                    font.weight: Font.Medium
                    horizontalAlignment: Text.AlignLeft
                    lineHeight: 22
                    lineHeightMode: Text.FixedHeight
                    text: "Riwayat"
                    textFormat: Text.PlainText
                    verticalAlignment: Text.AlignTop
                }
            }
        }
        Rectangle {
            id: pill_2

            x: 200

            height: 32
            width: 84

            border.color: "#ffffff"
            border.width: 1
            clip: true
            color: "transparent"
            radius: 6

            Rectangle {
                id: icon_Label_2

                x: 10
                y: 5

                height: 22
                width: 64

                color: "transparent"

                Icon_Person_Tick {
                    id: icon_Following

                    y: 2

                    clip: true
                    person_tick_ShapePath0FillColor: "#ffffff"
                    person_tick_ShapePath1FillColor: "#ffffff"
                    person_tick_ShapePath2FillColor: "#ffffff"
                }
                Text {
                    id: label_2

                    x: 22

                    height: 22
                    width: 43

                    color: "#ffffff"
                    elide: Text.ElideRight
                    font.family: "Inter"
                    font.pixelSize: 14
                    font.weight: Font.Medium
                    horizontalAlignment: Text.AlignLeft
                    lineHeight: 22
                    lineHeightMode: Text.FixedHeight
                    text: "Diikuti"
                    textFormat: Text.PlainText
                    verticalAlignment: Text.AlignTop
                }
            }
        }
        Rectangle {
            id: pill_3

            x: 292

            height: 32
            width: 90

            border.color: "#ffffff"
            border.width: 1
            clip: true
            color: "transparent"
            radius: 6

            Rectangle {
                id: icon_Label_3

                x: 10
                y: 5

                height: 22
                width: 70

                color: "transparent"

                Icon_Lines_Horizontal_Decrease_Rectangle_LTR {
                    id: icon_Order

                    y: 2

                    clip: true
                    lines_horizontal_decrease_rectangle_ShapePath0FillColor: "#ffffff"
                    lines_horizontal_decrease_rectangle_ShapePath1FillColor: "#ffffff"
                    lines_horizontal_decrease_rectangle_ShapePath2FillColor: "#ffffff"
                    lines_horizontal_decrease_rectangle_ShapePath3FillColor: "#ffffff"
                }
                Text {
                    id: label_3

                    x: 22

                    height: 22
                    width: 49

                    color: "#ffffff"
                    elide: Text.ElideRight
                    font.family: "Inter"
                    font.pixelSize: 14
                    font.weight: Font.Medium
                    horizontalAlignment: Text.AlignLeft
                    lineHeight: 22
                    lineHeightMode: Text.FixedHeight
                    text: "Playlist"
                    textFormat: Text.PlainText
                    verticalAlignment: Text.AlignTop
                }
            }
        }
    }
    Rectangle {
        id: search

        x: 16
        y: 52

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
            id: label_4

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

                source: Qt.resolvedUrl("assets/exclude_3.png")
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

                source: Qt.resolvedUrl("assets/wifi_3.png")
            }
            Image {
                id: mobile_Signal

                y: 0.34

                source: Qt.resolvedUrl("assets/mobile_Signal_3.png")
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

                    source: Qt.resolvedUrl("assets/indicator_3.png")
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
                    id: element

                    x: 12.45
                    y: 5.17

                    height: 11.09
                    width: 28.43

                    ShapePath {
                        id: element_ShapePath0

                        fillColor: "#ffffff"
                        fillRule: ShapePath.WindingFill
                        strokeColor: "#00000000"
                        strokeWidth: 0

                        PathSvg {
                            id: element_ShapePath0_PathSvg0

                            path: "M 3.8671875 11.0888671875 C 6.55517578125 11.0888671875 8.15185546875 8.98681640625 8.15185546875 5.42724609375 C 8.15185546875 4.0869140625 7.8955078125 2.958984375 7.40478515625 2.08740234375 C 6.6943359375 0.732421875 5.47119140625 0 3.92578125 0 C 1.6259765625 0 0 1.54541015625 0 3.71337890625 C 0 5.74951171875 1.46484375 7.22900390625 3.47900390625 7.22900390625 C 4.716796875 7.22900390625 5.72021484375 6.650390625 6.21826171875 5.64697265625 L 6.240234375 5.64697265625 C 6.240234375 5.64697265625 6.26953125 5.64697265625 6.27685546875 5.64697265625 C 6.29150390625 5.64697265625 6.3427734375 5.64697265625 6.3427734375 5.64697265625 C 6.3427734375 8.06396484375 5.42724609375 9.5068359375 3.8818359375 9.5068359375 C 2.9736328125 9.5068359375 2.2705078125 9.0087890625 2.02880859375 8.21044921875 L 0.146484375 8.21044921875 C 0.46142578125 9.9462890625 1.93359375 11.0888671875 3.8671875 11.0888671875 Z M 3.93310546875 5.7275390625 C 2.71728515625 5.7275390625 1.85302734375 4.86328125 1.85302734375 3.65478515625 C 1.85302734375 2.4755859375 2.76123046875 1.57470703125 3.9404296875 1.57470703125 C 5.11962890625 1.57470703125 6.02783203125 2.490234375 6.02783203125 3.68408203125 C 6.02783203125 4.86328125 5.1416015625 5.7275390625 3.93310546875 5.7275390625 Z"
                        }
                    }
                    ShapePath {
                        id: element_ShapePath1

                        fillColor: "#ffffff"
                        fillRule: ShapePath.WindingFill
                        strokeColor: "#00000000"
                        strokeWidth: 0

                        PathSvg {
                            id: element_ShapePath1_PathSvg0

                            path: "M 11.24296760559082 10.986328125 C 11.93876838684082 10.986328125 12.41484260559082 10.48828125 12.41484260559082 9.8291015625 C 12.41484260559082 9.16259765625 11.93876838684082 8.671875 11.24296760559082 8.671875 C 10.55449104309082 8.671875 10.07109260559082 9.16259765625 10.07109260559082 9.8291015625 C 10.07109260559082 10.48828125 10.55449104309082 10.986328125 11.24296760559082 10.986328125 Z M 11.24296760559082 5.4931640625 C 11.93876838684082 5.4931640625 12.41484260559082 5.00244140625 12.41484260559082 4.34326171875 C 12.41484260559082 3.6767578125 11.93876838684082 3.18603515625 11.24296760559082 3.18603515625 C 10.55449104309082 3.18603515625 10.07109260559082 3.6767578125 10.07109260559082 4.34326171875 C 10.07109260559082 5.00244140625 10.55449104309082 5.4931640625 11.24296760559082 5.4931640625 Z"
                        }
                    }
                    ShapePath {
                        id: element_ShapePath2

                        fillColor: "#ffffff"
                        fillRule: ShapePath.WindingFill
                        strokeColor: "#00000000"
                        strokeWidth: 0

                        PathSvg {
                            id: element_ShapePath2_PathSvg0

                            path: "M 19.270605087280273 10.83251953125 L 21.079687118530273 10.83251953125 L 21.079687118530273 8.8623046875 L 22.507909774780273 8.8623046875 L 22.507909774780273 7.265625 L 21.079687118530273 7.265625 L 21.079687118530273 0.263671875 L 18.413671493530273 0.263671875 C 16.545995712280273 3.076171875 15.059179306030273 5.42724609375 14.107030868530273 7.177734375 L 14.107030868530273 8.8623046875 L 19.270605087280273 8.8623046875 L 19.270605087280273 10.83251953125 Z M 15.857519149780273 7.19970703125 C 17.087987899780273 5.03173828125 18.186620712280273 3.2958984375 19.197362899780273 1.8017578125 L 19.299901962280273 1.8017578125 L 19.299901962280273 7.3095703125 L 15.857519149780273 7.3095703125 L 15.857519149780273 7.19970703125 Z"
                        }
                    }
                    ShapePath {
                        id: element_ShapePath3

                        fillColor: "#ffffff"
                        fillRule: ShapePath.WindingFill
                        strokeColor: "#00000000"
                        strokeWidth: 0

                        PathSvg {
                            id: element_ShapePath3_PathSvg0

                            path: "M 26.53652000427246 10.83251953125 L 28.42616844177246 10.83251953125 L 28.42616844177246 0.263671875 L 26.54384422302246 0.263671875 L 23.78261375427246 2.197265625 L 23.78261375427246 4.013671875 L 26.41200828552246 2.16796875 L 26.53652000427246 2.16796875 L 26.53652000427246 10.83251953125 Z"
                        }
                    }
                }
            }
        }
    }
    Rectangle {
        id: carousel_1

        x: 2
        y: 345

        height: 140
        width: 375

        clip: true
        color: "transparent"

        Rectangle {
            id: _item

            x: 16
            y: 8

            height: 124
            width: 76

            color: "transparent"
            radius: 4

            Image {
                id: image_3

                clip: true
                source: Qt.resolvedUrl("assets/image_7.png")
            }
            Text {
                id: alan_Runner

                y: 84

                height: 40
                width: 78

                color: "#ffffff"
                font.family: "Inter"
                font.letterSpacing: 0.14
                font.pixelSize: 14
                font.weight: Font.Medium
                horizontalAlignment: Text.AlignHCenter
                lineHeight: 19.60
                lineHeightMode: Text.FixedHeight
                text: "Alan Runner"
                textFormat: Text.PlainText
                verticalAlignment: Text.AlignTop
                wrapMode: Text.Wrap
            }
        }
        Rectangle {
            id: _item_1

            x: 111
            y: 8

            height: 124
            width: 76

            color: "transparent"
            radius: 4

            Image {
                id: image_4

                clip: true
                source: Qt.resolvedUrl("assets/image_8.png")
            }
            Text {
                id: bruno_Earth

                y: 84

                height: 40
                width: 78

                color: "#ffffff"
                font.family: "Inter"
                font.letterSpacing: 0.14
                font.pixelSize: 14
                font.weight: Font.Medium
                horizontalAlignment: Text.AlignHCenter
                lineHeight: 19.60
                lineHeightMode: Text.FixedHeight
                text: "Bruno Earth"
                textFormat: Text.PlainText
                verticalAlignment: Text.AlignTop
                wrapMode: Text.Wrap
            }
        }
        Rectangle {
            id: _item_2

            x: 206
            y: 8

            height: 124
            width: 76

            color: "transparent"
            radius: 4

            Image {
                id: image_5

                clip: true
                source: Qt.resolvedUrl("assets/image_9.png")
            }
            Text {
                id: justin_Bibir

                y: 84

                height: 40
                width: 78

                color: "#ffffff"
                font.family: "Inter"
                font.letterSpacing: 0.14
                font.pixelSize: 14
                font.weight: Font.Medium
                horizontalAlignment: Text.AlignHCenter
                lineHeight: 19.60
                lineHeightMode: Text.FixedHeight
                text: "Justin Bibir"
                textFormat: Text.PlainText
                verticalAlignment: Text.AlignTop
                wrapMode: Text.Wrap
            }
        }
        Rectangle {
            id: _item_3

            x: 301
            y: 8

            height: 104
            width: 76

            color: "transparent"
            radius: 4

            Image {
                id: image_6

                clip: true
                source: Qt.resolvedUrl("assets/image_10.png")
            }
            Text {
                id: blue_Day

                y: 84

                height: 20
                width: 78

                color: "#ffffff"
                font.family: "Inter"
                font.letterSpacing: 0.14
                font.pixelSize: 14
                font.weight: Font.Medium
                horizontalAlignment: Text.AlignHCenter
                lineHeight: 19.60
                lineHeightMode: Text.FixedHeight
                text: "Blue Day"
                textFormat: Text.PlainText
                verticalAlignment: Text.AlignTop
                wrapMode: Text.Wrap
            }
        }
    }
    Image {
        id: tab_Bar

        x: 0.50
        y: 733.50

        source: Qt.resolvedUrl("assets/tab_Bar_1.png")
    }
}