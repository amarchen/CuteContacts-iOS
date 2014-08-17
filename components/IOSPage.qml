/**
 * Page overlayeble with menu
 */
import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../settings.js" as Settings

Item {
    id: wholePage
    default property alias contents: pageContent.children
    property alias menu: backgroundOverlay.menu
    property string mobileNumber: ""
    property bool _menuIsActive: false

    function showMenu() {
        _menuIsActive = true
    }

    Item {
        id: pageContent
        anchors.fill: parent
    }

    Item {
        id: backgroundOverlay
        anchors.fill: parent
        visible: false
        opacity: 0

        Desaturate {
            anchors.fill: parent
            source: pageContent
            desaturation: 0.8

            Rectangle {
                anchors.fill: parent
                color: "black"
                opacity: 0.4
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        _menuIsActive = false
                    }
                }
            }
        }

        property Item menu: Item {}

        onMenuChanged: {
            if(menu) {
                menu.parent = backgroundOverlay
                menu.anchors.left = backgroundOverlay.left
                menu.anchors.right = backgroundOverlay.right
                menu.anchors.top = backgroundOverlay.bottom
            }
        }
    }

    states: [
        State {
            name: "menuIsActive"
            when: _menuIsActive
            PropertyChanges {
                target: backgroundOverlay
                opacity: 1
            }
            PropertyChanges {
                target: backgroundOverlay
                visible: true
            }
            AnchorChanges {
                target: menu
                anchors.top: undefined
                anchors.bottom: backgroundOverlay.bottom
            }
        }
    ]

    // First make things visible (even with opacity 0), then increase opacity
    transitions: [
        Transition {
            from: "*"
            to: "menuIsActive"
            SequentialAnimation {
                PropertyAnimation {
                    properties: "visible"
                }
                ParallelAnimation {
                    AnchorAnimation {
                        easing.type: Easing.InOutQuad
                        duration: 80
                    }
                    PropertyAnimation {
                        properties: "opacity"
                        duration: 50
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        },
        Transition {
            from: "menuIsActive"
            to: "*"
            SequentialAnimation {
                ParallelAnimation {
                    AnchorAnimation {
                        easing.type: Easing.InOutQuad
                        duration: 80
                    }
                    PropertyAnimation {
                        properties: "opacity"
                        duration: 80
                        easing.type: Easing.InOutQuad
                    }
                }
                PropertyAnimation {
                    properties: "visible"
                }
            }
        }

    ]

}
