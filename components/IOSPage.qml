/**
 * Page overlayeble with menu
 */
import QtQuick 2.0
import QtGraphicalEffects 1.0

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
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    wholePage.state = ""
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
