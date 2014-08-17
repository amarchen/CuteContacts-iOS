/**
 * Page overlayeble with menu
 */
import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../settings.js" as Settings

Item {
    id: wholePage
    default property alias contents: pageContent.children
    property string mobileNumber: ""
    property bool _menuIsActive: false

    property Item menu: Item {}

    onMenuChanged: {
        if(menu) {
            menu.parent = backgroundOverlay
            menu.anchors.left = backgroundOverlay.left
            menu.anchors.right = backgroundOverlay.right
            menu.anchors.bottom = backgroundOverlay.bottom
        }
    }


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

//        AddToFavoritesMenu {
//            id: menu
//        }

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
