import QtQuick.Shapes
import QtQuick

Shape {
    id: cover

    height: 660
    width: 1200

    clip: true

    ShapePath {
        id: coverShapePath

        strokeColor: "#000"
        strokeWidth: 0

        fillGradient: LinearGradient {
            id: gradientNode
        
            x1: cover.width * 0.5
            x2: cover.width * 0.5
            y1: cover.height * -3.0616171314629196e-17
            y2: cover.height * 0.9999999999999999
        
            GradientStop {
                color: "#ffe0c2ff"
                position: 0
            }
            GradientStop {
                color: "#ff5f20a3"
                position: 0.50
            }
            GradientStop {
                color: "#ff010003"
                position: 1
            }
        }

        PathRectangle {
            id: coverPathRectangle

            x: 0
            y: 0

            height: cover.height
            width: cover.width
        }
    }
    Item {
        id: icon

        x: 180
        y: 204

        height: 124
        width: 124

        Image {
            id: icon_mask

            source: Qt.resolvedUrl("assets/icon_mask_2.png")
        }
    }
    Image {
        id: logo_removebg_preview_1

        x: 204
        y: 214

        source: Qt.resolvedUrl("assets/logo_removebg_preview_2.png")
    }
    Text {
        id: instagram_UI

        x: 111
        y: 338

        height: 34
        width: 272

        color: "#ffffff"
        font.family: "Nico Moji"
        font.letterSpacing: -0.33
        font.pixelSize: 40
        font.weight: Font.Normal
        horizontalAlignment: Text.AlignHCenter
        text: "just play"
        textFormat: Text.PlainText
        verticalAlignment: Text.AlignTop
        wrapMode: Text.Wrap
    }
    Shape {
        id: login_sign

        x: 490.72
        y: 164.16

        height: 531.15
        width: 360.61

        clip: true
        rotation: 0.37

        ShapePath {
            id: login_signShapePath

            strokeColor: "#000"
            strokeWidth: 0

            fillGradient: ConicalGradient {
                id: gradientNode_1
            
                angle: -90
                centerX: login_sign.width * 0.5
                centerY: login_sign.height * 0.49999999999999994
            
                GradientStop {
                    color: "#ffffffff"
                    position: 1
                }
                GradientStop {
                    color: "#ffeedeff"
                    position: 0.38
                }
                GradientStop {
                    color: "#ff5f20a3"
                    position: 0
                }
            }

            PathRectangle {
                id: login_signPathRectangle

                x: 0
                y: 0

                height: login_sign.height
                width: login_sign.width
            }
        }
        Text {
            id: welcome_to

            x: 50.02
            y: 70.84

            height: 39
            width: 163

            color: "#000000"
            font.family: "Work Sans"
            font.letterSpacing: 0.78
            font.pixelSize: 26
            font.weight: Font.Bold
            horizontalAlignment: Text.AlignHCenter
            lineHeight: 38.90
            lineHeightMode: Text.FixedHeight
            text: "Welcome to "
            textFormat: Text.PlainText
            verticalAlignment: Text.AlignTop
        }
        Rectangle {
            id: rectangle_4

            y: 177.03

            height: 43.60
            width: 187.50

            color: "#ffffff"
            opacity: 0.10
            topRightRadius: 8.72
        }
        Text {
            id: login

            x: 68.90
            y: 187.50

            height: 23
            width: 52

            color: "#000000"
            font.family: "Work Sans"
            font.pixelSize: 19
            font.weight: Font.Medium
            horizontalAlignment: Text.AlignLeft
            text: "Login"
            textFormat: Text.PlainText
            verticalAlignment: Text.AlignTop
        }
        Text {
            id: sign_Up

            x: 246.68
            y: 181.52

            height: 23
            width: 73

            color: "#000000"
            font.family: "Work Sans"
            font.pixelSize: 19
            font.weight: Font.Medium
            horizontalAlignment: Text.AlignLeft
            rotation: -0.37
            text: "Sign Up"
            textFormat: Text.PlainText
            verticalAlignment: Text.AlignTop
        }
        Text {
            id: login_or_Sign_up_to_access_your_account

            x: 28.86
            y: 113.13

            height: 36
            width: 279

            color: "#1a1a1a"
            font.family: "Work Sans"
            font.pixelSize: 15
            font.weight: Font.Normal
            horizontalAlignment: Text.AlignHCenter
            text: "Login or Sign up to access your account"
            textFormat: Text.PlainText
            verticalAlignment: Text.AlignTop
            wrapMode: Text.Wrap
        }
        Item {
            id: icon_1

            x: 219.12
            y: 40.91

            height: 25.59
            width: 37.58

            rotation: -0.37

            Image {
                id: icon_mask_1

                source: Qt.resolvedUrl("assets/icon_mask_3.png")
            }
        }
        Rectangle {
            id: status_Bar

            x: -5.50
            y: -0.97

            height: 44
            width: 375

            clip: true
            color: "transparent"
            rotation: -0.37

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

                    source: Qt.resolvedUrl("assets/exclude_1.png")
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
                            strokeColor: "#000000"
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

                            fillColor: "#000000"
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

                            fillColor: "#000000"
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

                    source: Qt.resolvedUrl("assets/wifi_1.png")
                }
                Image {
                    id: mobile_Signal

                    y: 0.34

                    source: Qt.resolvedUrl("assets/mobile_Signal_1.png")
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

                        source: Qt.resolvedUrl("assets/indicator_1.png")
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

                            fillColor: "#000000"
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

                            fillColor: "#000000"
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

                            fillColor: "#000000"
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

                            fillColor: "#000000"
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
            id: frame_60353

            x: 12.42
            y: 286.03

            height: 61.05
            width: 340.12

            color: "transparent"
            rotation: -0.37

            Item {
                id: continue_with_Google

                height: 61.05
                width: 340.12

                Rectangle {
                    id: rectangle_2

                    height: 61.05
                    width: 340.12

                    color: "#ffffff"
                    radius: 8.72
                }
                Item {
                    id: group_10

                    x: 70.64
                    y: 17.44

                    height: 26.16
                    width: 214.02

                    Text {
                        id: login_with_Google

                        x: 45.02
                        y: 0.87

                        height: 23
                        width: 170

                        color: "#000000"
                        font.family: "Work Sans"
                        font.pixelSize: 19
                        font.weight: Font.Medium
                        horizontalAlignment: Text.AlignLeft
                        text: "Login with Google"
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignTop
                    }
                    Rectangle {
                        id: social_Icons

                        height: 26.16
                        width: 27.58

                        clip: true
                        color: "transparent"

                        Item {
                            id: _x31__stroke

                            height: 26.16
                            width: 27.58

                            Item {
                                id: google

                                height: 26.16
                                width: 27.58

                                Shape {
                                    id: _vector

                                    height: 26.16
                                    width: 27.58

                                    ShapePath {
                                        id: _vector_ShapePath0

                                        fillColor: "#00000000"
                                        joinStyle: ShapePath.MiterJoin
                                        strokeColor: "#00000000"
                                        strokeStyle: ShapePath.SolidLine
                                        strokeWidth: 0.20

                                        PathSvg {
                                            id: _vector_ShapePath0_PathSvg0

                                            path: "M 0 0 L 27.57699203491211 0 L 27.57699203491211 26.16278839111328 L 0 26.16278839111328 L 0 0 Z"
                                        }
                                    }
                                }
                                Shape {
                                    id: _vector_1

                                    x: 0.29
                                    y: 7.29

                                    height: 11.59
                                    width: 6.06

                                    ShapePath {
                                        id: _vector_1_ShapePath0

                                        fillColor: "#fbbc05"
                                        fillRule: ShapePath.OddEvenFill
                                        joinStyle: ShapePath.MiterJoin
                                        strokeColor: "#00000000"
                                        strokeStyle: ShapePath.SolidLine
                                        strokeWidth: 0.20

                                        PathSvg {
                                            id: _vector_1_ShapePath0_PathSvg0

                                            path: "M 5.64875943878728 5.795058541229038 C 5.64875943878728 4.945380997478195 5.797416737050829 4.1306552111962525 6.063060760498047 3.3666199603698646 L 1.4159063037107935 0 C 0.5101743999960535 1.7445267243518476 0 3.710415424027998 0 5.795058541229038 C 0 7.878066407555 0.5097434379593824 9.842524335813453 1.4139672313765457 11.586029052734375 L 6.058536429605317 8.212868868576146 C 5.79547776744889 7.452308355297309 5.64875943878728 6.640648152720173 5.64875943878728 5.795058541229038 Z"
                                        }
                                    }
                                }
                                Shape {
                                    id: _vector_2

                                    x: 1.71

                                    height: 10.65
                                    width: 21.49

                                    ShapePath {
                                        id: _vector_2_ShapePath0

                                        fillColor: "#ea4335"
                                        fillRule: ShapePath.OddEvenFill
                                        joinStyle: ShapePath.MiterJoin
                                        strokeColor: "#00000000"
                                        strokeStyle: ShapePath.SolidLine
                                        strokeWidth: 0.20

                                        PathSvg {
                                            id: _vector_2_ShapePath0_PathSvg0

                                            path: "M 12.392196633300205 5.351516980719303 C 14.337882885454825 5.351516980719303 16.095269135201075 6.0055869119759535 17.476057845706023 7.075808594309307 L 21.49281883239746 3.270348876571315 C 19.045145120367003 1.2486601225403295 15.906970571045044 0 12.392196633300205 0 C 6.935399055707055 0 2.2455861090662412 2.9604831676926446 0 7.286337053730767 L 4.646939055429527 10.65295696258545 C 5.717701996182525 7.5694266751416865 8.769915388074617 5.351516980719303 12.392196633300205 5.351516980719303 Z"
                                        }
                                    }
                                }
                                Shape {
                                    id: _vector_3

                                    x: 1.71
                                    y: 15.51

                                    height: 10.65
                                    width: 21.39

                                    ShapePath {
                                        id: _vector_3_ShapePath0

                                        fillColor: "#34a853"
                                        fillRule: ShapePath.OddEvenFill
                                        joinStyle: ShapePath.MiterJoin
                                        strokeColor: "#00000000"
                                        strokeStyle: ShapePath.SolidLine
                                        strokeWidth: 0.20

                                        PathSvg {
                                            id: _vector_3_ShapePath0_PathSvg0

                                            path: "M 12.392198441549562 5.301440848150398 C 8.770131994719137 5.301440848150398 5.717918157452988 3.0835303377976917 4.6471550604559875 0 L 0 3.366007110242644 C 2.245586436738546 7.692474310366574 6.935400067709305 10.652957916259766 12.392198441549562 10.652957916259766 C 15.760039368346575 10.652957916259766 18.975558666358946 9.518351892443103 21.388761520385742 7.392625165929909 L 16.977734653641324 4.157431888132392 C 15.73310716483154 4.901231860418414 14.16574422874687 5.301440848150398 12.392198441549562 5.301440848150398 Z"
                                        }
                                    }
                                }
                                Shape {
                                    id: _vector_4

                                    x: 14.10
                                    y: 10.70

                                    height: 12.20
                                    width: 13.18

                                    ShapePath {
                                        id: _vector_4_ShapePath0

                                        fillColor: "#4285f4"
                                        fillRule: ShapePath.OddEvenFill
                                        joinStyle: ShapePath.MiterJoin
                                        strokeColor: "#00000000"
                                        strokeStyle: ShapePath.SolidLine
                                        strokeWidth: 0.20

                                        PathSvg {
                                            id: _vector_4_ShapePath0_PathSvg0

                                            path: "M 13.180295944213867 2.3783616208036378 C 13.180295944213867 1.6053328671610148 13.05469119448765 0.7728243229138394 12.866392022296104 0 L 0 0 L 0 5.054120976330105 L 7.406146618386208 5.054120976330105 C 7.035796196398557 6.777390442612353 6.027942619980425 8.10208567849897 4.585536474012821 8.964231415364056 L 8.996562802129045 12.199424743652344 C 11.531491850848822 9.96741154851508 13.180295944213867 6.642283514089195 13.180295944213867 2.3783616208036378 Z"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        Item {
            id: group_60354

            x: 25.86
            y: 437.09

            height: 151.17
            width: 322.67

            rotation: -0.37

            Rectangle {
                id: frame_8

                height: 122.09
                width: 322.67

                color: "transparent"

                Item {
                    id: email_Address

                    height: 52.33
                    width: 322.67

                    Rectangle {
                        id: rectangle_5

                        height: 52.33
                        width: 322.67

                        color: "#ffffff"
                        radius: 8.72
                    }
                    Text {
                        id: email_Address_1

                        x: 47.09
                        y: 16.57

                        height: 20
                        width: 122

                        color: "#000000"
                        font.family: "Work Sans"
                        font.pixelSize: 17
                        font.weight: Font.Normal
                        horizontalAlignment: Text.AlignHCenter
                        opacity: 0.50
                        text: "Email Address"
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignTop
                    }
                    Rectangle {
                        id: mail_FILL0_wght400_GRAD0_opsz48_1_1

                        x: 17.44
                        y: 15.70

                        height: 20.93
                        width: 20.93

                        clip: true
                        color: "transparent"

                        Shape {
                            id: _vector_5

                            x: 1.74
                            y: 3.49

                            height: 13.95
                            width: 17.44

                            ShapePath {
                                id: _vector_5_ShapePath0

                                fillColor: "#000000"
                                fillRule: ShapePath.WindingFill
                                joinStyle: ShapePath.MiterJoin
                                strokeColor: "#00000000"
                                strokeStyle: ShapePath.SolidLine
                                strokeWidth: 0.02

                                PathSvg {
                                    id: _vector_5_ShapePath0_PathSvg0

                                    path: "M 1.3081395149230957 13.95348834991455 C 0.9593023109436034 13.95348834991455 0.6540697574615478 13.822674396634103 0.3924418544769287 13.561046490073204 C 0.13081395149230957 13.299418583512306 0 12.994186025857925 0 12.645348817110062 L 0 1.3081395328044891 C 0 0.9593023240566254 0.13081395149230957 0.6540697664022446 0.3924418544769287 0.3924418598413468 C 0.6540697574615478 0.13081395328044892 0.9593023109436034 0 1.3081395149230957 0 L 16.133720684051514 0 C 16.482557888031007 0 16.787790441513064 0.13081395328044892 17.04941834449768 0.3924418598413468 C 17.3110462474823 0.6540697664022446 17.44186019897461 0.9593023240566254 17.44186019897461 1.3081395328044891 L 17.44186019897461 12.645348817110062 C 17.44186019897461 12.994186025857925 17.3110462474823 13.299418583512306 17.04941834449768 13.561046490073204 C 16.787790441513064 13.822674396634103 16.482557888031007 13.95348834991455 16.133720684051514 13.95348834991455 L 1.3081395149230957 13.95348834991455 Z M 16.133720684051514 2.507267437875271 L 9.069767303466797 7.129360453784466 C 9.011627767737522 7.158430222046468 8.957121954615726 7.18386626765132 8.90624986410141 7.2056685931980615 C 8.855377773587094 7.227470918744803 8.793604515250339 7.238372081518174 8.720930099487305 7.238372081518174 C 8.64825568372427 7.238372081518174 8.586482425387516 7.227470918744803 8.5356103348732 7.2056685931980615 C 8.484738244358883 7.18386626765132 8.430232431237087 7.158430222046468 8.372092895507812 7.129360453784466 L 1.3081395149230957 2.507267437875271 L 1.3081395149230957 12.645348817110062 L 16.133720684051514 12.645348817110062 L 16.133720684051514 2.507267437875271 Z M 8.720930099487305 6.0610465019941335 L 16.04651138305664 1.3081395328044891 L 1.417151141166687 1.3081395328044891 L 8.720930099487305 6.0610465019941335 Z M 1.3081395149230957 2.659883716702461 L 1.3081395149230957 1.8026813212285562 L 1.3081395149230957 1.8186405064264364 L 1.3081395149230957 1.3081395328044891 L 1.3081395149230957 1.8095930203795434 L 1.3081395149230957 1.7897095762682511 L 1.3081395149230957 2.659883716702461 Z"
                                }
                            }
                        }
                    }
                }
                Item {
                    id: password

                    y: 69.77

                    height: 52.33
                    width: 322.67

                    Rectangle {
                        id: rectangle_6

                        height: 52.33
                        width: 322.67

                        color: "#ffffff"
                        radius: 8.72
                    }
                    Text {
                        id: password_1

                        x: 47.09
                        y: 16.57

                        height: 20
                        width: 82

                        color: "#000000"
                        font.family: "Work Sans"
                        font.pixelSize: 17
                        font.weight: Font.Normal
                        horizontalAlignment: Text.AlignLeft
                        opacity: 0.50
                        text: "Password"
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignTop
                    }
                    Shape {
                        id: _vector_6

                        x: 280.81
                        y: 19.19

                        height: 14.53
                        width: 21.80

                        opacity: 0.30

                        ShapePath {
                            id: _vector_6_ShapePath0

                            fillColor: "#000000"
                            fillRule: ShapePath.WindingFill
                            joinStyle: ShapePath.MiterJoin
                            strokeColor: "#00000000"
                            strokeStyle: ShapePath.SolidLine
                            strokeWidth: 0.09

                            PathSvg {
                                id: _vector_6_ShapePath0_PathSvg0

                                path: "M 21.73965256188719 6.973110095251422 C 21.707857479125778 6.901344110733878 20.938417010186104 5.194403504141553 19.227841535421977 3.483829521502184 C 16.94858826421973 1.204578238478939 14.069770357096983 0 10.901163101196289 0 C 7.732555845295595 0 4.85373793817285 1.204578238478939 2.5744846669706027 3.483829521502184 C 0.8639091922064741 5.194403504141553 0.09083439377572398 6.904069404026781 0.06267303406230121 6.973110095251422 C 0.02135139099895169 7.0660531459325515 0 7.166634481408998 0 7.268349203879096 C 0 7.370063926349195 0.02135139099895169 7.470645954902851 0.06267303406230121 7.563589005583981 C 0.09446811682371348 7.635354990101525 0.8639091922064741 9.341387665550348 2.5744846669706027 11.051961648189717 C 4.85373793817285 13.330304480261555 7.732555845295595 14.534882545471191 10.901163101196289 14.534882545471191 C 14.069770357096983 14.534882545471191 16.94858826421973 13.330304480261555 19.227841535421977 11.051961648189717 C 20.938417010186104 9.341387665550348 21.707857479125778 7.635354990101525 21.73965256188719 7.563589005583981 C 21.78097420495054 7.470645954902851 21.802326202392575 7.370063926349195 21.802326202392578 7.268349203879096 C 21.802326202392578 7.166634481408998 21.78097420495054 7.0660531459325515 21.73965256188719 6.973110095251422 Z M 10.901163101196289 10.901161909103394 C 10.182480437699294 10.901161909103394 9.479937174020177 10.688048334570205 8.882374363411445 10.288769976660841 C 8.284811552802713 9.889491618751478 7.8190676806042525 9.321982066829744 7.544039719681794 8.658006433652007 C 7.269011758759335 7.99403080047427 7.19705191517181 7.263410422323983 7.337259954069567 6.558537645893239 C 7.477467992967323 5.853664869462494 7.823546955877191 5.2061977289553365 8.331732357640616 4.698012770478999 C 8.839917759404042 4.189827812002662 9.487384771615593 3.8437491509754036 10.192258162903183 3.7035412343802814 C 10.897131554190773 3.563333317785159 11.627753262735219 3.6352930986025425 12.291729475095435 3.910320819619755 C 12.955705687455652 4.185348540636968 13.523215734413007 4.651092006569834 13.9224944406108 5.248654295928099 C 14.321773146808592 5.846216585286364 14.534886907239636 6.5487592361411915 14.534886907239638 7.267441272735596 C 14.534886907239638 8.231163918658888 14.152049262977986 9.155414951195654 13.470593844751962 9.836869774992191 C 12.789138426525938 10.518324598788729 11.864886587769817 10.901161909103394 10.901163101196289 10.901161909103394 Z"
                            }
                        }
                    }
                    Rectangle {
                        id: lock_FILL0_wght400_GRAD0_opsz48_1

                        x: 17.44
                        y: 15.70

                        height: 20.93
                        width: 20.93

                        clip: true
                        color: "transparent"

                        Shape {
                            id: _vector_7

                            x: 3.49
                            y: 0.87

                            height: 18.31
                            width: 13.95

                            ShapePath {
                                id: _vector_7_ShapePath0

                                fillColor: "#000000"
                                fillRule: ShapePath.WindingFill
                                joinStyle: ShapePath.MiterJoin
                                strokeColor: "#00000000"
                                strokeStyle: ShapePath.SolidLine
                                strokeWidth: 0.02

                                PathSvg {
                                    id: _vector_7_ShapePath0_PathSvg0

                                    path: "M 1.3081395328044891 18.313953399658203 C 0.9484011612832546 18.313953399658203 0.6404433129355311 18.185864737487975 0.3842659877613187 17.92968741314752 C 0.12808866258710622 17.673510088807063 0 17.365552241461618 0 17.00581387111119 L 0 7.543604614621118 C 0 7.183866244270689 0.12808866258710622 6.8759083969252455 0.3842659877613187 6.619731072584789 C 0.6404433129355311 6.363553748244332 0.9484011612832546 6.235465086074103 1.3081395328044891 6.235465086074103 L 2.834302321076393 6.235465086074103 L 2.834302321076393 4.142441840398879 C 2.834302321076393 2.996366286733662 3.238415407977294 2.019440646702268 4.046642163963997 1.2116645044583407 C 4.854868919950701 0.4038883622144135 5.832339820906521 0 6.9790549500007275 0 C 8.125770079094934 0 9.10247091576457 0.4038883622144135 9.909156960994006 1.2116645044583407 C 10.71584300622344 2.019440646702268 11.119186028838158 2.996366286733662 11.119186028838158 4.142441840398879 L 11.119186028838158 6.235465086074103 L 12.645348817110062 6.235465086074103 C 13.005087188631297 6.235465086074103 13.31304503697902 6.363553748244332 13.569222362153232 6.619731072584789 C 13.825399687327444 6.8759083969252455 13.95348834991455 7.183866244270689 13.95348834991455 7.543604614621118 L 13.95348834991455 17.00581387111119 C 13.95348834991455 17.365552241461618 13.825399687327444 17.673510088807063 13.569222362153232 17.92968741314752 C 13.31304503697902 18.185864737487975 13.005087188631297 18.313953399658203 12.645348817110062 18.313953399658203 L 1.3081395328044891 18.313953399658203 Z M 1.3081395328044891 17.00581387111119 L 12.645348817110062 17.00581387111119 L 12.645348817110062 7.543604614621118 L 1.3081395328044891 7.543604614621118 L 1.3081395328044891 17.00581387111119 Z M 6.980406949680628 13.953488304501489 C 7.443081350472454 13.953488304501489 7.837936034053564 13.793379160966447 8.164970917254687 13.4731611441965 C 8.492005800455809 13.152943127426552 8.65552324205637 12.767994134067003 8.65552324205637 12.31831389381772 C 8.65552324205637 11.882267384302049 8.490784230986169 11.486191818686859 8.16130747717716 11.130087155387516 C 7.831830723368152 10.773982492088173 7.435755801025749 10.595930181230818 6.973081400233923 10.595930181230818 C 6.510406999442097 10.595930181230818 6.115552315860987 10.773982492088173 5.788517432659865 11.130087155387516 C 5.461482549458743 11.486191818686859 5.2979651078581815 11.885901091353135 5.2979651078581815 12.329215056555613 C 5.2979651078581815 12.772529021758091 5.462703453574209 13.154069696791986 5.792180207383217 13.47383714403425 C 6.121656961192226 13.793604591276516 6.517732548888802 13.953488304501489 6.980406949680628 13.953488304501489 Z M 4.142441853880882 6.235465086074103 L 9.811046496033669 6.235465086074103 L 9.811046496033669 4.142441840398879 C 9.811046496033669 3.3551308280855405 9.535740862150087 2.6859228009592178 8.985130384491004 2.1348181332816325 C 8.43450539379402 1.583698952566192 7.765901381325028 1.3081395285470145 6.97931709954496 1.3081395285470145 C 6.192718263142353 1.3081395285470145 5.523255819036056 1.583698952566192 4.970930224657059 2.1348181332816325 C 4.418604630278063 2.6859228009592178 4.142441853880882 3.3551308280855405 4.142441853880882 4.142441840398879 L 4.142441853880882 6.235465086074103 Z"
                                }
                            }
                        }
                    }
                }
            }
            Text {
                id: forgot_password_

                x: 0.87
                y: 135.17

                height: 16
                width: 122

                color: "#000000"
                font.family: "Work Sans"
                font.pixelSize: 13
                font.weight: Font.Normal
                horizontalAlignment: Text.AlignRight
                text: "Forgot password?"
                textFormat: Text.PlainText
                verticalAlignment: Text.AlignTop
            }
        }
        Rectangle {
            id: rectangle_7

            x: 5.49
            y: 729.97

            height: 120
            width: 375

            color: "#ffffff"
            rotation: -0.37
        }
        Image {
            id: by_signing_in_with_an_account_you_agree_to_SO_s_

            x: 16.80
            y: 743.78

            rotation: -0.37
            source: Qt.resolvedUrl("assets/by_signing_in_with_an_account_you_agree_to_SO_s_1.png")
        }
        Rectangle {
            id: rectangle_3

            x: 8.87
            y: 237.74

            height: 492
            width: 375

            color: "#6750a4"
            opacity: 0.10
            rotation: -0.37
        }
        Item {
            id: line

            x: 21.12
            y: 360.77

            height: 15
            width: 322.67

            rotation: -0.37

            Image {
                id: line_1

                y: 10.47

                source: Qt.resolvedUrl("assets/line_2.png")
            }
            Rectangle {
                id: frame_60352

                x: 80.12

                height: 15
                width: 162.44

                color: "#eedeff"

                Text {
                    id: or_continue_with_email

                    x: 8.72

                    height: 15
                    width: 146

                    color: "#000000"
                    font.family: "Work Sans"
                    font.pixelSize: 13
                    font.weight: Font.Normal
                    horizontalAlignment: Text.AlignHCenter
                    text: "or continue with email"
                    textFormat: Text.PlainText
                    verticalAlignment: Text.AlignTop
                }
            }
        }
        Item {
            id: sign_In

            x: 7.05
            y: 634.83

            height: 60.05
            width: 335.67

            rotation: -0.37

            Image {
                id: rectangle_8

                source: Qt.resolvedUrl("assets/rectangle_2.png")
            }
            Text {
                id: login_1

                x: 142.78
                y: 18.07

                height: 25.57
                width: 62

                color: "#ffffff"
                font.family: "Work Sans"
                font.pixelSize: 21
                font.weight: Font.Bold
                horizontalAlignment: Text.AlignHCenter
                text: "Login"
                textFormat: Text.PlainText
                verticalAlignment: Text.AlignTop
                wrapMode: Text.Wrap
            }
        }
        Item {
            id: icon_2

            x: 220.69
            y: 56.16

            height: 35.01
            width: 38.22

            rotation: -0.37

            Image {
                id: icon_mask_2

                source: Qt.resolvedUrl("assets/icon_mask_4.png")
            }
        }
    }
    Image {
        id: halaman_Playlist

        x: 732
        y: 67

        clip: true
        source: Qt.resolvedUrl("assets/halaman_Playlist.png")

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
                source: Qt.resolvedUrl("assets/items.png")

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
                            id: element_1

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
                        source: Qt.resolvedUrl("assets/image.png")
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
                        source: Qt.resolvedUrl("assets/image_1.png")
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
                        source: Qt.resolvedUrl("assets/image_2.png")
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
                        source: Qt.resolvedUrl("assets/image_3.png")
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
                    id: _vector_8

                    x: 3
                    y: 3

                    height: 16
                    width: 16

                    ShapePath {
                        id: _vector_8_ShapePath0

                        fillColor: "#00000000"
                        strokeColor: "#000000"
                        strokeWidth: 2

                        PathSvg {
                            id: _vector_8_ShapePath0_PathSvg0

                            path: "M 16 8 C 16 12.418278217315674 12.418278217315674 16 8 16 C 3.581721782684326 16 0 12.418278217315674 0 8 C 0 3.581721782684326 3.581721782684326 0 8 0 C 12.418278217315674 0 16 3.581721782684326 16 8 Z"
                        }
                    }
                }
                Shape {
                    id: _vector_9

                    x: 16.65
                    y: 16.65

                    height: 4.35
                    width: 4.35

                    ShapePath {
                        id: _vector_9_ShapePath0

                        fillColor: "#00000000"
                        strokeColor: "#000000"
                        strokeWidth: 2

                        PathSvg {
                            id: _vector_9_ShapePath0_PathSvg0

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
            id: status_Bar_1

            height: 44
            width: 375

            clip: true
            color: "transparent"

            Item {
                id: notch_2

                x: 78
                y: -2

                height: 30
                width: 219

                visible: false

                Rectangle {
                    id: bG_1

                    x: -78
                    y: 2

                    height: 44
                    width: 375

                    color: "#000000"
                    visible: false
                }
                Image {
                    id: exclude_1

                    x: -78
                    y: 2

                    source: Qt.resolvedUrl("assets/exclude_2.png")
                    visible: false
                }
                Shape {
                    id: notch_3

                    height: 30
                    width: 219

                    ShapePath {
                        id: notch_3_ShapePath0

                        fillColor: "#000000"
                        fillRule: ShapePath.WindingFill
                        joinStyle: ShapePath.MiterJoin
                        strokeColor: "#00000000"
                        strokeStyle: ShapePath.SolidLine
                        strokeWidth: 0.67

                        PathSvg {
                            id: notch_3_ShapePath0_PathSvg0

                            path: "M 0 0 L 219 0 L 215.4666336479537 1.0112359550561798 L 215.3165137614679 5.561797752808989 L 215.3165137614679 30 L 3.68348623853211 30 L 3.68348623853211 5.561797752808989 L 3.533375293836681 1.0112359550561798 L 0 0 Z"
                        }
                    }
                }
            }
            Item {
                id: right_Side_1

                x: 293.67
                y: 17.33

                height: 11.34
                width: 66.66

                Item {
                    id: battery_1

                    x: 42.33

                    height: 11.33
                    width: 24.33

                    Shape {
                        id: rectangle_9

                        height: 11.33
                        width: 22

                        opacity: 0.35

                        ShapePath {
                            id: rectangle_9_ShapePath0

                            fillColor: "#00000000"
                            fillRule: ShapePath.OddEvenFill
                            strokeColor: "#ffffff"
                            strokeWidth: 1

                            PathSvg {
                                id: rectangle_9_ShapePath0_PathSvg0

                                path: "M 0 0 L 22 0 L 22 11.333333015441895 L 0 11.333333015441895 L 0 0 Z"
                            }
                        }
                    }
                    Shape {
                        id: combined_Shape_1

                        x: 23
                        y: 3.67

                        height: 4
                        width: 1.33

                        opacity: 0.40

                        ShapePath {
                            id: combined_Shape_1_ShapePath0

                            fillColor: "#ffffff"
                            fillRule: ShapePath.WindingFill
                            strokeColor: "#00000000"
                            strokeWidth: 0

                            PathSvg {
                                id: combined_Shape_1_ShapePath0_PathSvg0

                                path: "M 0 0 L 0 4 C 0.8047311305999756 3.6612234711647034 1.328037977218628 2.8731333017349243 1.328037977218628 2 C 1.328037977218628 1.1268666982650757 0.8047311305999756 0.33877652883529663 0 0 Z"
                            }
                        }
                    }
                    Shape {
                        id: rectangle_10

                        x: 2
                        y: 2

                        height: 7.33
                        width: 18

                        ShapePath {
                            id: rectangle_10_ShapePath0

                            fillColor: "#ffffff"
                            fillRule: ShapePath.WindingFill
                            strokeColor: "#00000000"
                            strokeWidth: 0

                            PathSvg {
                                id: rectangle_10_ShapePath0_PathSvg0

                                path: "M 0 0 L 18 0 L 18 7.333333492279053 L 0 7.333333492279053 L 0 0 Z"
                            }
                        }
                    }
                }
                Image {
                    id: wifi_1

                    x: 22.03

                    source: Qt.resolvedUrl("assets/wifi_2.png")
                }
                Image {
                    id: mobile_Signal_1

                    y: 0.34

                    source: Qt.resolvedUrl("assets/mobile_Signal_2.png")
                }
                Item {
                    id: recording_Indicator_1

                    x: 4.33
                    y: -9.33

                    height: 6
                    width: 6

                    visible: false

                    Image {
                        id: indicator_1

                        source: Qt.resolvedUrl("assets/indicator_2.png")
                    }
                }
            }
            Item {
                id: left_Side_1

                x: 21
                y: 12

                height: 21
                width: 54

                Rectangle {
                    id: _time_1

                    height: 21
                    width: 54

                    color: "transparent"
                    radius: 32

                    Shape {
                        id: element_2

                        x: 12.45
                        y: 5.17

                        height: 11.09
                        width: 28.43

                        ShapePath {
                            id: element_2_ShapePath0

                            fillColor: "#ffffff"
                            fillRule: ShapePath.WindingFill
                            strokeColor: "#00000000"
                            strokeWidth: 0

                            PathSvg {
                                id: element_2_ShapePath0_PathSvg0

                                path: "M 3.8671875 11.0888671875 C 6.55517578125 11.0888671875 8.15185546875 8.98681640625 8.15185546875 5.42724609375 C 8.15185546875 4.0869140625 7.8955078125 2.958984375 7.40478515625 2.08740234375 C 6.6943359375 0.732421875 5.47119140625 0 3.92578125 0 C 1.6259765625 0 0 1.54541015625 0 3.71337890625 C 0 5.74951171875 1.46484375 7.22900390625 3.47900390625 7.22900390625 C 4.716796875 7.22900390625 5.72021484375 6.650390625 6.21826171875 5.64697265625 L 6.240234375 5.64697265625 C 6.240234375 5.64697265625 6.26953125 5.64697265625 6.27685546875 5.64697265625 C 6.29150390625 5.64697265625 6.3427734375 5.64697265625 6.3427734375 5.64697265625 C 6.3427734375 8.06396484375 5.42724609375 9.5068359375 3.8818359375 9.5068359375 C 2.9736328125 9.5068359375 2.2705078125 9.0087890625 2.02880859375 8.21044921875 L 0.146484375 8.21044921875 C 0.46142578125 9.9462890625 1.93359375 11.0888671875 3.8671875 11.0888671875 Z M 3.93310546875 5.7275390625 C 2.71728515625 5.7275390625 1.85302734375 4.86328125 1.85302734375 3.65478515625 C 1.85302734375 2.4755859375 2.76123046875 1.57470703125 3.9404296875 1.57470703125 C 5.11962890625 1.57470703125 6.02783203125 2.490234375 6.02783203125 3.68408203125 C 6.02783203125 4.86328125 5.1416015625 5.7275390625 3.93310546875 5.7275390625 Z"
                            }
                        }
                        ShapePath {
                            id: element_2_ShapePath1

                            fillColor: "#ffffff"
                            fillRule: ShapePath.WindingFill
                            strokeColor: "#00000000"
                            strokeWidth: 0

                            PathSvg {
                                id: element_2_ShapePath1_PathSvg0

                                path: "M 11.24296760559082 10.986328125 C 11.93876838684082 10.986328125 12.41484260559082 10.48828125 12.41484260559082 9.8291015625 C 12.41484260559082 9.16259765625 11.93876838684082 8.671875 11.24296760559082 8.671875 C 10.55449104309082 8.671875 10.07109260559082 9.16259765625 10.07109260559082 9.8291015625 C 10.07109260559082 10.48828125 10.55449104309082 10.986328125 11.24296760559082 10.986328125 Z M 11.24296760559082 5.4931640625 C 11.93876838684082 5.4931640625 12.41484260559082 5.00244140625 12.41484260559082 4.34326171875 C 12.41484260559082 3.6767578125 11.93876838684082 3.18603515625 11.24296760559082 3.18603515625 C 10.55449104309082 3.18603515625 10.07109260559082 3.6767578125 10.07109260559082 4.34326171875 C 10.07109260559082 5.00244140625 10.55449104309082 5.4931640625 11.24296760559082 5.4931640625 Z"
                            }
                        }
                        ShapePath {
                            id: element_2_ShapePath2

                            fillColor: "#ffffff"
                            fillRule: ShapePath.WindingFill
                            strokeColor: "#00000000"
                            strokeWidth: 0

                            PathSvg {
                                id: element_2_ShapePath2_PathSvg0

                                path: "M 19.270605087280273 10.83251953125 L 21.079687118530273 10.83251953125 L 21.079687118530273 8.8623046875 L 22.507909774780273 8.8623046875 L 22.507909774780273 7.265625 L 21.079687118530273 7.265625 L 21.079687118530273 0.263671875 L 18.413671493530273 0.263671875 C 16.545995712280273 3.076171875 15.059179306030273 5.42724609375 14.107030868530273 7.177734375 L 14.107030868530273 8.8623046875 L 19.270605087280273 8.8623046875 L 19.270605087280273 10.83251953125 Z M 15.857519149780273 7.19970703125 C 17.087987899780273 5.03173828125 18.186620712280273 3.2958984375 19.197362899780273 1.8017578125 L 19.299901962280273 1.8017578125 L 19.299901962280273 7.3095703125 L 15.857519149780273 7.3095703125 L 15.857519149780273 7.19970703125 Z"
                            }
                        }
                        ShapePath {
                            id: element_2_ShapePath3

                            fillColor: "#ffffff"
                            fillRule: ShapePath.WindingFill
                            strokeColor: "#00000000"
                            strokeWidth: 0

                            PathSvg {
                                id: element_2_ShapePath3_PathSvg0

                                path: "M 26.53652000427246 10.83251953125 L 28.42616844177246 10.83251953125 L 28.42616844177246 0.263671875 L 26.54384422302246 0.263671875 L 23.78261375427246 2.197265625 L 23.78261375427246 4.013671875 L 26.41200828552246 2.16796875 L 26.53652000427246 2.16796875 L 26.53652000427246 10.83251953125 Z"
                            }
                        }
                    }
                }
            }
        }
        Image {
            id: tab_Bar

            x: 1
            y: 734

            source: Qt.resolvedUrl("assets/tab_Bar.png")
        }
    }
    Text {
        id: karaoke_Anytime_

        x: 129
        y: 385

        height: 21
        width: 227

        color: "#ffffff"
        font.family: "Modern Antiqua"
        font.letterSpacing: -0.33
        font.pixelSize: 16
        font.weight: Font.Medium
        horizontalAlignment: Text.AlignHCenter
        text: "-- karaoke Anytime --"
        textFormat: Text.PlainText
        verticalAlignment: Text.AlignTop
        wrapMode: Text.Wrap
    }
}