import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

/**
 * @TODO Cannot position text inisde the rectangle using style
 */
Rectangle {
    id: textFieldWrapper

    property alias placeholderText: innerTextField.placeholderText

    width: 208
    height: 44
    color: "white"

    TextField {
        id: innerTextField
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        width: 204
        placeholderText: "First"
        style: TextFieldStyle {
            font.family: "Helvetica Neue"
            font.pixelSize: 17

            background: Rectangle {
                color: "transparent"
            }
        }

        Image {
            id: xbutton
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            width: sourceSize.width / 2
            height: sourceSize.height / 2
            source: "qrc:///images/text-edit-x.png"
            visible: parent.text.length > 0

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
