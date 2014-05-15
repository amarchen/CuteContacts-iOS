import QtQuick 2.2
import QtQuick.Controls 1.1

import "pages"

ApplicationWindow {
    visible: true
    width: 320
    height: 568
    title: qsTr("Hello World")

    StackView {
        id: pageStack
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: fakeStatusBar.height
        anchors.bottom: parent.bottom
        onYChanged: {
            console.log("pageStack y ch to " + y)
        }

        delegate: StackViewDelegate {
            pushTransition: StackViewTransition {
                PropertyAnimation {
                    target: enterItem
                    property: "y"
                    from: 568
                    to: 0
                    easing.type: Easing.InOutQuad
                    duration: 300
                }
            }
            popTransition: StackViewTransition {
                PropertyAnimation {
                    target: exitItem
                    property: "y"
                    from: 0
                    to: 568
                    easing.type: Easing.InOutQuad
                    duration: 300
                }
            }
        }

        initialItem: MainPage {
//            anchors.fill: parent
        }
    }

    Rectangle {
        id: fakeStatusBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: Qt.platform.os == "ios" ? 0 : 15
        color: "#f6f5f1"
        Image {
            anchors.fill: parent
            source: "qrc:///images/status-bar-black.png"
        }
    }


}
