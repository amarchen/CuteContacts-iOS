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
        lineHeight: 1.5
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        text: 'This feature is not yet implemented. See more about the project \
<a href="http://www.codingsubmarine.com/projects/cute-contacts-for-ios/">at CodingSubmarine</a> or \
at <a href="https://github.com/amarchen/CuteContacts-iOS">github project page</a>'
        onLinkActivated: {
            Qt.openUrlExternally(link)
        }
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
