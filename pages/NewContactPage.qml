import QtQuick 2.2
import QtQuick.Controls 1.1
import "../components"

Item {
    TitleBar {
        id: titleBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        color: "#f6f5f1"

        title: "New Contact"

        leftButtonText: "Cancel"
        onLeftButtonClicked: pageStack.pop()

        rightButtonText: "Done"
        onRightButtonClicked: console.log("NCP: Done button clicked")

    }

}
