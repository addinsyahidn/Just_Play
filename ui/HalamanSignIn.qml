import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../components"

Rectangle {
    id: halamanSignIn
    objectName: "SignIn"
    anchors.fill: parent
    clip: true

    color: "#F6F0FC"

    property bool isRememberMeChecked: false

    Connections {
        target: authManager

        function onSignInSuccess(idToken, localId) {
            errorText.visible = false
            loadingOverlay.visible = false
            console.log("Login/Registrasi valid! Membuka gerbang utama aplikasi...")
            myStack.replace("HalamanUtama.qml")
        }

        function onSignInFailed(errorMessage) {
            loadingOverlay.visible = false

            if (errorMessage === "NO_SAVED_SESSION" || errorMessage === "SESSION_EXPIRED") {
                errorText.visible = false
                return;
            }

            errorText.visible = true

            if (errorMessage === "EMAIL_NOT_FOUND") {
                errorText.text = "Email baru terdeteksi. Mendaftarkan akun Anda..."
            }
            else if (errorMessage === "INVALID_PASSWORD") {
                errorText.text = "Kata sandi yang Anda masukkan salah*"
            }
            else if (errorMessage === "EMAIL_EXISTS") {
                errorText.text = "Email sudah terdaftar, silakan masukkan password yang benar*"
            }
            else if (errorMessage === "INVALID_EMAIL") {
                errorText.text = "Format penulisan email tidak valid*"
            }
            else {
                console.log("Respon Error Firebase asli: " + errorMessage)
                errorText.text = "Gagal memproses: " + errorMessage
            }
        }
    }

    Column {
        id: mainContent
        width: parent.width * 0.88
        anchors.centerIn: parent
        spacing: 16 * root.dp

        Text {
            text: "Just Play"
            font.family: "Inter"
            font.pixelSize: 24 * root.dp
            font.weight: Font.DemiBold
            color: "#000000"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Image {
            id: appLogo
            width: 100 * root.dp
            height: 100 * root.dp
            source: Qt.resolvedUrl("assets/app_icon.png")
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Item { width: 1; height: 10 * root.dp }

        Text {
            text: "Sign In atau Log In Akunmu"
            font.family: "Inter"
            font.pixelSize: 16 * root.dp
            font.weight: Font.DemiBold
            color: "#000000" // Diganti hitam
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "Massukan email dan sandi"
            font.family: "Inter"
            font.pixelSize: 13 * root.dp
            color: "#000000" // Diganti hitam
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Item { width: 1; height: 10 * root.dp }

        Rectangle {
            width: parent.width
            height: 40 * root.dp
            border.color: emailInput.activeFocus ? "#000000" : "#e0e0e0"
            border.width: 1
            radius: 8 * root.dp
            color: "#ffffff"

            TextInput {
                id: emailInput
                anchors.fill: parent
                anchors.leftMargin: 16 * root.dp
                anchors.rightMargin: 16 * root.dp
                verticalAlignment: TextInput.AlignVCenter
                font.pixelSize: 14 * root.dp
                color: "#000000"
                selectByMouse: true

                Text {
                    text: "email@domain.com"
                    visible: !emailInput.text && !emailInput.activeFocus
                    color: "#828282"
                    font: parent.font
                }
            }
        }

        Rectangle {
            width: parent.width
            height: 40 * root.dp
            border.color: passwordInput.activeFocus ? "#000000" : "#e0e0e0"
            border.width: 1
            radius: 8 * root.dp
            color: "#ffffff"

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 16 * root.dp
                anchors.rightMargin: 12 * root.dp

                TextInput {
                    id: passwordInput
                    Layout.fillWidth: true
                    verticalAlignment: TextInput.AlignVCenter
                    color: "#000000"
                    selectByMouse: true
                    echoMode: toggleEye.isPasswordVisible ? TextInput.Normal : TextInput.Password

                    font.pixelSize: toggleEye.isPasswordVisible ? 14 * root.dp : 10 * root.dp

                    Text {
                        text: "sandi"
                        visible: !passwordInput.text && !passwordInput.activeFocus
                        color: "#828282"
                        font.pixelSize: 14 * root.dp
                        font.family: "Inter"
                    }
                }


                Component_1 {
                    id: toggleEye
                    Layout.preferredWidth: 24 * root.dp
                    Layout.preferredHeight: 24 * root.dp
                    property bool isPasswordVisible: false

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            toggleEye.isPasswordVisible = !toggleEye.isPasswordVisible
                        }
                    }
                }
            }
        }

        RowLayout {
            width: parent.width
            spacing: 8 * root.dp

            Rectangle {
                width: 18 * root.dp
                height: 18 * root.dp
                radius: 4 * root.dp
                border.color: isRememberMeChecked ? "#000000" : "#e0e0e0"
                border.width: 1
                color: isRememberMeChecked ? "#000000" : "transparent"

                Text {
                    text: "✓"
                    color: "#ffffff"
                    font.pixelSize: 12 * root.dp
                    anchors.centerIn: parent
                    visible: isRememberMeChecked
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: isRememberMeChecked = !isRememberMeChecked
                }
            }

            Text {
                text: "Ingat saya"
                font.family: "Inter"
                font.pixelSize: 13 * root.dp
                color: "#000000"
                MouseArea {
                    anchors.fill: parent
                    onClicked: isRememberMeChecked = !isRememberMeChecked
                }
            }
        }

        Text {
            id: errorText
            text: ""
            color: "#ff0000"
            font.family: "Inter"
            font.pixelSize: 12 * root.dp
            anchors.horizontalCenter: parent.horizontalCenter
            visible: text !== ""
        }

        Item { width: 1; height: 5 * root.dp }

        Rectangle {
            id: loginButton
            width: parent.width
            height: 42 * root.dp
            color: clickArea.pressed ? "#333333" : "#000000"
            radius: 8 * root.dp

            Text {
                text: "Lanjutkan"
                color: "#ffffff"
                font.family: "Inter"
                font.pixelSize: 14 * root.dp
                font.weight: Font.Medium
                anchors.centerIn: parent
            }
            MouseArea {
                id: clickArea
                anchors.fill: parent
                onClicked: {
                    authManager.signInUser(emailInput.text, passwordInput.text, isRememberMeChecked)
                }
            }
        }
    }

    Component.onCompleted: {
        authManager.checkAutoLogin()
    }

    Loader {
        id: loadingOverlay
        anchors.fill: parent
        visible: true
        source: "SplashScreen.qml"

        MouseArea {
            anchors.fill: parent
            enabled: parent.visible
        }
    }
}
