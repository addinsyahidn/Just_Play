import QtQuick.Shapes
import QtQuick

Shape {
    id: splash_screen

    height: 812
    width: 375

    clip: true

    ShapePath {
        id: splash_screenShapePath

        strokeColor: "#000"
        strokeWidth: 0

        fillGradient: RadialGradient {
            id: gradientNode
        
            centerRadius: Math.max(splash_screen.width, splash_screen.height) * 1.1690429566123532
            centerX: splash_screen.width * 0.49999993559307243
            centerY: splash_screen.height * 0.499999962211789
            focalRadius: Math.max(splash_screen.width, splash_screen.height) * 0
            focalX: splash_screen.width * 0.49999993559307243
            focalY: splash_screen.height * 0.499999962211789
        
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
            id: splash_screenPathRectangle

            x: 0
            y: 0

            height: splash_screen.height
            width: splash_screen.width
        }
    }
    Image {
        id: logo_removebg_preview_1

        x: 78
        y: 168

        source: Qt.resolvedUrl("assets/logo_removebg_preview_1.png")
    }
    Item {
        id: app

        x: 20
        y: 427

        height: 40
        width: 343

        Image {
            id: whatsApp_UI

            source: Qt.resolvedUrl("assets/whatsApp_UI_1.png")
        }
    }
    Text {
        id: karaoke_Anytime_

        x: 72
        y: 488

        height: 21
        width: 227

        color: "#ffffff"
        font.family: "Modern Antiqua"
        font.letterSpacing: -0.33
        font.pixelSize: 20
        font.weight: Font.Medium
        horizontalAlignment: Text.AlignHCenter
        text: "-- karaoke Anytime --"
        textFormat: Text.PlainText
        verticalAlignment: Text.AlignTop
        wrapMode: Text.Wrap
    }
}