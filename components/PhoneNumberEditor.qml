import QtQuick 2.0

import "../settings.js" as Settings

Rectangle {
    id: wholeEditor
    property alias type: phoneTypeButton.text

    height: Settings.pne_height

    onFocusChanged: {
        phoneNumberField.focus = focus
    }

    Rectangle {
        id: deleteButtonBlock
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: 90
        color: "red"

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 24

            font.pixelSize: 18
            color: "white"
            text: "Delete"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: pageStack.push("qrc:///pages/NotYetImplemented.qml")
        }
    }
    Rectangle {
        id: swipablePart
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: parent.width

        Behavior on anchors.leftMargin {
            NumberAnimation {
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }

        Image {
            id: deleteIcon
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 24
            height: 26

            source: "../images/red-minus.png"

            MouseArea {
                id: deletionIconArea
                anchors.fill: parent
                onClicked: wholeEditor.state = "deletionQuery"
            }
        }

        Rectangle {
    //        color: "lightgreen"
    //        opacity: 0.8
            id: typeAndNumberBlock
            anchors.top: parent.top
            anchors.left: deleteIcon.right
    //        anchors.right: parent.right
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            width: parent.width - deleteIcon.width - 10

            Rectangle {
                id: buttonAndChevronBlock
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: childrenRect.width

                Text {
                    id: phoneTypeButton
                    text: "home"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 75
                    clip: true
                    elide: Text.ElideRight
                    color: "#0079ff"
                }

                Image {
                    id: chevronIcon
                    anchors.left: phoneTypeButton.right
                    anchors.verticalCenter: phoneTypeButton.verticalCenter
                    anchors.leftMargin: 5
                    width: 8
                    height: 12

                    source: "../images/chevron.png"

                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        function selectionCompletionHandler(selectedText) {
                            phoneTypeButton.text = selectedText
                            pageStack.currentItem.selectionCompleted.disconnect(selectionCompletionHandler)
                        }

                        pageStack.push("qrc:///pages/ListSelectorPage.qml",
                                       {
                                           leftButtonText: "Cancel",
                                           title: "Label",
                                           items: ["home", "work", "mobile", "company main", "work fax",
                                                   "home fax", "assistant", "pager", "car", "radio"],
                                           selectedText: phoneTypeButton.text,
                                       })
                        pageStack.currentItem.selectionCompleted.connect(selectionCompletionHandler)

                    }
                }
            }

            // @TODO add some proper gradient
            Rectangle {
                id: verticalSeparator
                anchors.left: buttonAndChevronBlock.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 4
                anchors.leftMargin: 4

                width: 1
                color: "#cccccc"
            }

            IOSTextField {
                id: phoneNumberField
                anchors.left: verticalSeparator.right
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                placeholderText: "Phone"
                showUnderline: false
                inputMethodHints: Qt.ImhDialableCharactersOnly
                onLostActiveFocus: {
                    wholeEditor.state = ""
                }
            }

            Rectangle {
                id: underline
                anchors.top: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: -1

                height: 1
                color: "#cccccc"
            }

        }
    }

    states: [
        State {
            name: "deletionQuery"
            PropertyChanges {
                target: swipablePart
                anchors.leftMargin: -deleteButtonBlock.width
            }
        }
    ]


}
