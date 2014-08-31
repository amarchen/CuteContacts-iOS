import QtQuick 2.2
import QtQuick.Controls 1.1

import "pages"

Item {
    visible: true
    width: 320
    height: 568

    StackView {
        id: pageStack
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
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
        id: statusBarWrapper
        color: "#a3a3a6"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: childrenRect.height

        Image {
            id: statusBar
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            fillMode: Image.PreserveAspectFit
            source: "../images/black-statusbar.png"
            height: sourceSize.height / 2
        }
    }

}
