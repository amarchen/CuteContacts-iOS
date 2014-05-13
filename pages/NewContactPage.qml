import QtQuick 2.2
import QtQuick.Controls 1.1

Item {
    Rectangle {
        id: titleBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 44
        color: "white"
        Label {
            anchors.centerIn: parent
            text: "New Contact"
        }

        ToolButton {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            text: "Done"
            onClicked: {
                console.log("Done clicked")
                pageStack.pop()
            }
        }
    }

}
