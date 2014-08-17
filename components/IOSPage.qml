/**
 * Page overlayeble with menu
 */
import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../settings.js" as Settings

Item {
    id: wholePage
    default property alias contents: pageContent.children
    property bool _menuIsActive: false

    function showMenu() {
        console.log("showMenu")
        _menuIsActive = true
    }

    Item {
        id: pageContent
        anchors.fill: parent
    }

    Item {
        id: backgroundOverlay
        visible: false
        anchors.fill: parent

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

        Item {
            id: menu
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 80
            anchors.leftMargin: 8
            anchors.rightMargin: anchors.leftMargin
            anchors.bottomMargin: anchors.leftMargin
            Rectangle {
                id: cancelButton
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 44
                radius: 4

                color: "white"

                Text {
                    anchors.centerIn: parent
                    font.bold: true
                    font.pixelSize: 19
                    color: Settings.colorActiveBlue
                    text: "Cancel"
                }
            }

            Rectangle {
                id: topMenuPart
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: cancelButton.top
                anchors.bottomMargin: 8
                height: 88
                radius: 4

                Item {
                    id: menuTitle
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.verticalCenter
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 12
                        color: "#777777"
                        text: "Add to Favorites"
                    }
                }
                Rectangle {
                    id: divider
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: menuTitle.bottom
                    height: 1
                    color: "#cccccc"
                }
                Item {
                    id: mobileNumberItem
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: divider.bottom
                    anchors.bottom: parent.bottom
                    Text {
                        anchors.centerIn: parent
                        text: "mobile: +0223"
                    }
                }
            }
        }
    }

    states: [
        State {
            name: "menuIsActive"
            when: _menuIsActive
            PropertyChanges {
                target: backgroundOverlay
                visible: true
            }
            StateChangeScript {
                script: console.log("state ch to menuIsActive")
            }
        }

    ]

}
