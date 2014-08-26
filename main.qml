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

            function getTransition(properties)
            {
                var usedPushTransition = properties.enterItem.pushTransition ? properties.enterItem.pushTransition : pageStack.transitionPopFromBottom
                var usedPopTransition = properties.exitItem.popTransition ? properties.exitItem.popTransition : pageStack.transitionSlideToBottom

                if(properties.name == "pushTransition") {
                    return usedPushTransition
                } else if(properties.name == "popTransition") {
                    return usedPopTransition
                } else {
                    console.error("Requested unexpected transition type " + properties.name)
                }
            }

        }

        property Component transitionSlideFromRight: Component {
            StackViewTransition {
                PropertyAnimation {
                    target: enterItem
                    property: "x"
                    from: 320
                    to: 0
                    easing.type: Easing.InOutQuad
                    duration: 200
                }
            }
        }

        property Component transitionSlideToRight: Component {
            StackViewTransition {
                PropertyAnimation {
                    target: exitItem
                    property: "x"
                    from: 0
                    to: 320
                    easing.type: Easing.InOutQuad
                    duration: 200
                }
            }
        }

        property Component transitionSlideToBottom: Component {
            StackViewTransition {
                PropertyAnimation {
                    target: exitItem
                    property: "y"
                    from: 0
                    to: 568
                    easing.type: Easing.InOutQuad
                    duration: 200
                }
            }
        }


        property Component transitionPopFromBottom: Component {
            StackViewTransition {
                PropertyAnimation {
                    target: enterItem
                    property: "y"
                    from: 568
                    to: 0
                    easing.type: Easing.InOutQuad
                    duration: 200
                }
        }
        }


        initialItem: MainPage {
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
