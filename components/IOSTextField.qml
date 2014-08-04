import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

/**
 * @TODO Cannot position text inisde the rectangle using style
 */
Rectangle {
    id: textFieldWrapper
//    color: "green"
//    opacity: 0.4

    property alias placeholderText: fakePlaceholderTextComponent.text
    property alias showUnderline: underline.visible
    property alias inputMethodHints: innerTextField.inputMethodHints

    // easiest way to notify about it that I found..
    signal lostActiveFocus

    onFocusChanged: {
        if(focus) {
            innerTextField.focus = true
            innerTextField.forceActiveFocus()
        } else {
            innerTextField.focus = false
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("ITF: clicked")
        }
    }

    width: 208
    height: 44
    color: "white"

//    Rectangle   {
//        anchors.fill: parent
//        color: "lightyellow"
//        opacity: 0.2
//    }

    TextField {

//        Rectangle {
//            anchors.fill: parent
//            color: "blue"
//            opacity: 0.4
//        }

        id: innerTextField
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        width: 204
        style: TextFieldStyle {
            font.family: "Helvetica Neue"
            font.pixelSize: 17

            background: Rectangle {
                color: "transparent"
            }
        }

        // workaround for the bug that sometimes positions cursor vertically a little wrong until first char input
        onFocusChanged: {
            if(focus) {
                var origText = text
                text = origText + " "
                text = origText
            }
        }
        onActiveFocusChanged: {
            if(!activeFocus) {
                lostActiveFocus()
            }
        }

        // To fight against disappearing placeholder
        Text {

//            Rectangle {
//                anchors.fill: parent
//                color: "lightblue"
//                opacity: 0.2
//            }

            id: fakePlaceholderTextComponent
            anchors.fill: parent
            anchors.leftMargin: 7
            anchors.bottomMargin:6
            font: parent.font
            horizontalAlignment: parent.horizontalAlignment
            verticalAlignment: parent.verticalAlignment
            opacity: !parent.text.length ? 1 : 0
            color: "darkgray"
            clip: contentWidth > width;
            elide: Text.ElideRight
            renderType: Text.NativeRendering
            Behavior on opacity { NumberAnimation { duration: 90 } }
        }

        Image {
            id: xbutton
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            width: sourceSize.width / 2
            height: sourceSize.height / 2
            source: "qrc:///images/text-edit-x.png"
            visible: parent.text.length > 0 && parent.activeFocus === true

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    parent.parent.text = ""
                }
            }
        }
    }

    Rectangle {
        id: underline
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 1
        color: "#c9c9ce"
    }
}
