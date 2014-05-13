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

}
