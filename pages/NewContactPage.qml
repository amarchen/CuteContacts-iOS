import QtQuick 2.2
import QtQuick.Controls 1.1

Item {
    Rectangle {
        id: titleBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 49
        color: "#f6f5f1"

        Label {
            anchors.centerIn: parent
            text: "New Contact"
            font.family: "Helvetica Neue"
            font.bold: true
            font.pointSize: 17
        }

        Label {
            id: cancelLabel
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            clip: true
            font.family: "Helvetica Neue"
            font.pointSize: 18
            color: "#0079ff"
            text: "Cancel"

            MouseArea {
                anchors.fill: parent
                onClicked: pageStack.pop()
            }

        }

        Label {
            id: doneLabel
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            clip: true
            font.family: "Helvetica Neue"
            font.pointSize: 18
            color: "#0079ff"
            text: "Done"

            MouseArea {
                anchors.fill: parent
                onClicked: pageStack.pop()
            }
        }


    }

}
