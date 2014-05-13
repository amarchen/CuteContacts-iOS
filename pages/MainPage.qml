import QtQuick 2.2
import QtQuick.Controls 1.1

import "../components"

Item {
    Rectangle {
        id: titleBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 44
        color: "#f6f5f1"

        Label {
            anchors.centerIn: parent
            text: "All Contacts"
            font.family: "Helvetica Neue"
            font.bold: true
            font.pointSize: 17
        }

        IosIconButton {
            anchors.right: parent.right
            anchors.rightMargin: 18
            anchors.verticalCenter: parent.verticalCenter

            width: 18
            height: 18

            iconSource: "qrc:///images/plus.png"

            onClicked: {
                console.log("Plus clicked")
                pageStack.push("qrc:///pages/NewContactPage.qml")
            }
        }
    }
    Rectangle {
        id: searchBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        height: 44
        color: "white"
        TextField {
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            placeholderText: "Search"
        }
    }
}
