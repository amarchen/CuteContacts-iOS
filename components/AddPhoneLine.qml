import QtQuick 2.0

Rectangle {
    id: wholeAddPhoneLine
    height: childrenRect.height
    signal clicked
    Item {
        id: addPhoneRow
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: childrenRect.height

        Image {
            id: phonePlus
            anchors.left: parent.left
            anchors.leftMargin: 10
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
            color: "#0079ff"
        }

        Rectangle {
            id: underline
            anchors.top: addPhoneButton.bottom
            anchors.left: addPhoneButton.left
            anchors.right: addPhoneButton.right

            anchors.topMargin: 12
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
