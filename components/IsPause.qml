import QtQuick
import QtQuick.Shapes

Rectangle {
    enum Pause { Pause_True, Pause_False}

    id: isPause

    property int pause_1: IsPause.Pause.Pause_True

    height: 25
    width: 25

    clip: true
    color: "transparent"

    states: [
        State {
            name: "Pause=True"
            when: isPause.pause_1 === IsPause.Pause.Pause_True
    
            PropertyChanges {
                target: pause
                visible: true
            }
            PropertyChanges {
                target: notPause
                visible: false
            }
        },
        State {
            name: "Pause=False"
            when: isPause.pause_1 === IsPause.Pause.Pause_False
    
            PropertyChanges {
                target: pause
                visible: false
            }
            PropertyChanges {
                target: notPause
                visible: true
            }
        }
    ]

    Shape {
        id: pause

        x: 1.56

        height: 25
        width: 21.88

        visible: true

        ShapePath {
            id: pause_ShapePath0

            fillColor: "#000000"
            fillRule: ShapePath.WindingFill
            joinStyle: ShapePath.MiterJoin
            strokeColor: "#00000000"
            strokeStyle: ShapePath.SolidLine
            strokeWidth: 1

            PathSvg {
                id: pause_ShapePath0_PathSvg0

                path: "M 0 0 L 21.875 12.5 L 0 25 L 0 0 Z"
            }
        }
    }
    Shape {
        id: notPause

        x: 4.07
        y: 2.91

        height: 19.77
        width: 16.86

        ShapePath {
            id: notPause_ShapePath0

            fillColor: "#000000"
            fillRule: ShapePath.WindingFill
            joinStyle: ShapePath.MiterJoin
            strokeColor: "#00000000"
            strokeStyle: ShapePath.SolidLine
            strokeWidth: 1

            PathSvg {
                id: notPause_ShapePath0_PathSvg0

                path: "M 0 0 L 5.620155334472656 0 L 5.620155334472656 19.76744270324707 L 0 19.76744270324707 L 0 0 Z M 11.240310668945312 0 L 16.86046600341797 0 L 16.86046600341797 19.76744270324707 L 11.240310668945312 19.76744270324707 L 11.240310668945312 0 Z"
            }
        }
    }
}