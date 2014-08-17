import QtQuick 2.0
import "../settings.js" as Settings

Item {
    id: menu
    height: 80
    anchors.leftMargin: 8
    anchors.rightMargin: anchors.leftMargin
    anchors.bottomMargin: anchors.leftMargin
    Rectangle {
        id: cancelButton
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 44
        radius: 4

        color: "white"

        Text {
            anchors.centerIn: parent
            font.bold: true
            font.pixelSize: 19
            color: Settings.colorActiveBlue
            text: "Cancel"
        }
    }

    Rectangle {
        id: topMenuPart
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: cancelButton.top
        anchors.bottomMargin: 8
        height: 88
        radius: 4

        Item {
            id: menuTitle
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.verticalCenter
            Text {
                anchors.centerIn: parent
                font.pixelSize: 12
                color: "#777777"
                text: "Add to Favorites"
            }
        }
        Rectangle {
            id: divider
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: menuTitle.bottom
            height: 1
            color: "#cccccc"
        }
        Item {
            id: mobileNumberItem
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: divider.bottom
            anchors.bottom: parent.bottom
            Text {
                anchors.centerIn: parent
                text: "mobile: " + mobileNumber
            }
        }
    }
}
