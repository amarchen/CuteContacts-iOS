import QtQuick 2.0

Rectangle {
    id: wholeEditor
    height: 36
//    color: "lightblue"
//    opacity: 0.7

    Image {
        id: deleteIcon
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: 24
        height: 26

        source: "../images/red-minus.png"
    }

    Rectangle {
//        color: "lightgreen"
//        opacity: 0.8
        id: typeAndNumberBlock
        anchors.top: parent.top
        anchors.left: deleteIcon.right
        anchors.right: parent.right
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom

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
                anchors.top: parent.top
                anchors.topMargin: 6
                width: 60
                color: "#0079ff"
            }

            Image {
                id: chevronIcon
                anchors.left: phoneTypeButton.right
                anchors.verticalCenter: phoneTypeButton.verticalCenter
                anchors.leftMargin: 20
                width: 8
                height: 12

                source: "../images/chevron.png"

            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("phoneType selection start")
                    pageStack.push("qrc:///pages/ListSelectorPage.qml",
                                   {
                                       leftButtonText: "Cancel",
                                       title: "Label",
                                       items: ["home", "work", "mobile", "company main", "work fax",
                                               "home fax", "assistant", "pager", "car", "radio"]
                                   })
                }
            }
        }

        Rectangle {
            id: verticalSeparator
            anchors.left: buttonAndChevronBlock.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 4

            width: 1
            color: "#cccccc"
        }
        IOSTextField {
            anchors.left: verticalSeparator.right
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            placeholderText: "Phone"
            showUnderline: false
            inputMethodHints: Qt.ImhDialableCharactersOnly
        }

        Rectangle {
            id: underline
            anchors.top: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            height: 1
            color: "#cccccc"
        }

    }

}
