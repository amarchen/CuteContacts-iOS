import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

import "../components"

Item {
    id: wholePage

    MouseArea {
        id: pageArea
        anchors.fill: parent
        onClicked: {
            pageArea.focus = true
        }

        Rectangle {
            id: titleBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 44
            color: "#f6f5f1"

            Label {
                anchors.centerIn: parent
                text: "All Contacts"
                font.family: "Helvetica Neue"
                font.bold: true
                font.pointSize: 17
            }

            IosIconButton {
                anchors.right: parent.right
                anchors.rightMargin: 18
                anchors.verticalCenter: parent.verticalCenter

                width: 18
                height: 18

                iconSource: "qrc:///images/plus.png"

                onClicked: {
                    console.log("Plus clicked")
                    pageStack.push("qrc:///pages/NewContactPage.qml")
                }
            }
        }
        Rectangle {
            id: searchBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: titleBar.bottom
            height: 44
            color: "#c9c9ce"

            Rectangle {
                anchors.fill: parent
                anchors.margins: 8
                radius: 6
                color: "#ffffff"

                TextField {
                    id: searchField
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft

                    style: TextFieldStyle {
                        background: Rectangle {
                            radius: 6
                        }
                    }

                    Item {
                        id: searchTextPlaceholder
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 4
                        width: childrenRect.width
                        height: glassIcon.height

                        Image {
                            id: glassIcon
                            width: sourceSize.width / 2
                            height: sourceSize.height / 2
                            source: "qrc:///images/magnifying-glass.png"
                        }

                        Label {
                            anchors.left: glassIcon.right
                            anchors.leftMargin: 8
                            anchors.verticalCenter: glassIcon.verticalCenter
                            text: "Search"
                            color: "#8e8e93"
                            font.pixelSize: 14
                        }
                    }

                }
            }

        }
        Item {
            id: contactList
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: searchBar.bottom
            anchors.bottom: parent.bottom
    //        color: "white"
        }

        states: [
            State {
                name: "searchBarActive"
                when: searchField.activeFocus
                AnchorChanges {
                    target: titleBar
                    anchors.top: undefined
                    anchors.bottom: pageArea.top
                }
                AnchorChanges {
                    target: searchTextPlaceholder
                    anchors.horizontalCenter: undefined
                    anchors.left: searchField.left
                }
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                AnchorAnimation { duration: 200; easing.type: Easing.InOutQuad }
            }
        ]


    }

}
