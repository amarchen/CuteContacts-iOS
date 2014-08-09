import QtQuick 2.0

import "../settings.js" as Settings

Rectangle {
    id: wholeAddPhoneLine
    height: Settings.pne_height
    signal clicked

    Item {
        id: addPhoneRow
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: parent.height

        Image {
            id: phonePlus
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            source: "../images/green-plus.png"
            width: 20
            height: 20
        }

        Text {
            id: addPhoneButton
            anchors.left: phonePlus.right
            anchors.verticalCenter: phonePlus.verticalCenter
            anchors.leftMargin: 10
            anchors.right: parent.right
            text: "add phone"
            color: Settings.colorActiveBlue
        }

        Rectangle {
            id: underline
            anchors.top: parent.bottom
            anchors.left: addPhoneButton.left
            anchors.right: addPhoneButton.right

            anchors.topMargin: -1
            height: 1
            color: "#cccccc"
        }

        MouseArea {
            id: addPhoneArea
            anchors.fill: parent
            onClicked: {
                wholeAddPhoneLine.clicked()
            }
        }
    }

}
