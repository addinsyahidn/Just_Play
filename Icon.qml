import QtQuick

Item {
    id: icon

    height: 310
    width: 320

    Image {
        id: icon_mask

        source: Qt.resolvedUrl("assets/icon_mask.png")
    }
}