import QtQuick
import QtQuick.Controls

Window {
    id: root
    width: 360
    height: 640
    visible: true
    title: qsTr("Karaoke App")
    property real dp: width / 360

    property string globalIdToken: ""
    property string globalLocalId: ""

    Rectangle {
        id: navigationBar
        z: 10
        width: parent.width
        height: 60 * root.dp
        color: "#ffffff"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30 * root.dp
        visible: myStack.currentItem && myStack.currentItem.objectName !== "SignIn"

        Row {
            anchors.fill: parent

            Repeater {
                model: [
                    { name: "Utama",            icon: "assets/home.png",       page: "HalamanUtama.qml" },
                    { name: "CustomerService",  icon: "assets/support.png",  page: "" },
                    { name: "Notifikasi",       icon: "assets/notifications.png", page: "HalamanNotifikasi.qml" },
                    { name: "Profile",          icon: "assets/logout.png",     page: "HalamanSignIn.qml" }
                ]

                delegate: Item {
                    width: navigationBar.width / 4
                    height: navigationBar.height

                    Image {
                        width: 24 * root.dp
                        height: 24 * root.dp
                        source: modelData.icon
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -2 * root.dp
                        fillMode: Image.PreserveAspectFit
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (modelData.name === "Profile") {
                                console.log("Menghapus sesi login...")
                                authManager.logoutUser()
                                root.globalIdToken = ""
                                root.globalLocalId = ""
                                myStack.replace(modelData.page)
                                return
                            }

                            if (modelData.name === "CustomerService") {
                                popupCS.open()
                                return
                            }

                            if (myStack.currentItem && myStack.currentItem.objectName === modelData.name) {
                                return
                            }

                            if (modelData.name === "Utama") {
                                myStack.pop(null)
                            } else {
                                myStack.push(modelData.page)
                            }
                        }
                    }
                }
            }
        }

        Popup {
            id: popupCS
            anchors.centerIn: Overlay.overlay
            width: 280 * root.dp
            height: 180 * root.dp
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

            background: Rectangle {
                color: "#ffffff"
                radius: 12 * root.dp
                border.color: "#e0e0e0"
                border.width: 1
            }

            contentItem: Column {
                spacing: 15 * root.dp
                anchors.fill: parent
                anchors.margins: 10 * root.dp

                Text {
                    text: "Hubungi Customer Service"
                    font.bold: true
                    font.pixelSize: 16 * root.dp
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                }

                Button {
                    width: parent.width
                    text: "Email"
                    onClicked: {
                        Qt.openUrlExternally("mailto:justplay1205@gmail.com")
                        popupCS.close()
                    }
                }

                Text {
                    text: "Pesan Anda akan segera diproses oleh tim kami,\nklik diluar pop-up untuk keluar."
                    font.bold: true
                    font.pixelSize: 10 * root.dp
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                    color: "#adacac"
                }
            }
        }
    }

    StackView {
        id: myStack
        anchors.fill: parent
        initialItem: "HalamanSignIn.qml"
        anchors.bottomMargin: navigationBar.visible ? (navigationBar.height + navigationBar.anchors.bottomMargin) : 0
    }

    Connections {
        target: authManager

        function onSignInSuccess(idToken, localId) {
            console.log("Login valid! Masuk ke aplikasi...")
            root.globalIdToken = idToken
            root.globalLocalId = localId
            myStack.replace("HalamanUtama.qml")
        }
    }
}
