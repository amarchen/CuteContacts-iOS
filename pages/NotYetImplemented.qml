import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

import "../components"

Item {
    id: wholePage

    TitleBar {
        id: titleBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        color: "#f6f5f1"

        title: "Not yet"
        leftButtonText: "Back"
        rightButtonText: ""

        onLeftButtonClicked: pageStack.pop()
    }

    Text {
        anchors.centerIn: parent
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        text: "This feature is not yet implemented"
    }

    onFocusChanged: {
        if(focus) {
            Qt.inputMethod.hide()
        }
    }

    Component.onCompleted: {
        wholePage.focus = true
    }
}
