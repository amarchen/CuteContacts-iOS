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
            text: "All Contacts"
        }

        ToolButton {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            text: "+"
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
