import QtQuick
import QtQuick.Shapes

Rectangle {
    enum Active { Active_True, Active_False}

    id: isFavorit

    property int active_1: IsFavorit.Active.Active_False

    height: 26.92
    width: 28.50

    color: "transparent"

    states: [
        State {
            name: "Active=False"
            when: isFavorit.active_1 === IsFavorit.Active.Active_False
    
            PropertyChanges {
                target: notFavorit
                visible: true
            }
            PropertyChanges {
                target: favorit
                visible: false
            }
        },
        State {
            name: "Active=True"
            when: isFavorit.active_1 === IsFavorit.Active.Active_True
    
            PropertyChanges {
                target: notFavorit
                visible: false
            }
            PropertyChanges {
                target: favorit
                visible: true
            }
        }
    ]

    Shape {
        id: notFavorit

        height: 26.92
        width: 28.50

        visible: true

        ShapePath {
            id: notFavorit_ShapePath0

            fillColor: "#00000000"
            fillRule: ShapePath.WindingFill
            strokeColor: "#000000"
            strokeWidth: 1.50

            PathSvg {
                id: notFavorit_ShapePath0_PathSvg0

                path: "M 7.520833333333333 0 C 3.367750147978465 0 0 3.578333233711767 0 7.991083035861747 C 0 16.822916269302368 14.25 26.91666603088379 14.25 26.91666603088379 C 14.25 26.91666603088379 28.5 16.822916269302368 28.5 7.991083035861747 C 28.5 2.5238330562815996 25.13224985202153 0 20.979166666666664 0 C 18.0341666440169 0 15.48499995470047 1.7986664943227608 14.25 4.417499835257438 C 13.01500004529953 1.7986664943227608 10.465833355983097 0 7.520833333333333 0 Z"
            }
        }
    }
    Shape {
        id: favorit

        height: 26.92
        width: 28.50

        ShapePath {
            id: favorit_ShapePath0

            fillColor: "#000000"
            fillRule: ShapePath.WindingFill
            strokeColor: "#000000"
            strokeWidth: 1.50

            PathSvg {
                id: favorit_ShapePath0_PathSvg0

                path: "M 7.520833333333333 0 C 3.367750147978465 0 0 3.578333233711767 0 7.991083035861747 C 0 16.822916269302368 14.25 26.91666603088379 14.25 26.91666603088379 C 14.25 26.91666603088379 28.5 16.822916269302368 28.5 7.991083035861747 C 28.5 2.5238330562815996 25.13224985202153 0 20.979166666666664 0 C 18.0341666440169 0 15.48499995470047 1.7986664943227608 14.25 4.417499835257438 C 13.01500004529953 1.7986664943227608 10.465833355983097 0 7.520833333333333 0 Z"
            }
        }
    }
}