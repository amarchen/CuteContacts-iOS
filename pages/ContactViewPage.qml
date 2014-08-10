import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

import "../components"
import "../settings.js" as Settings

Item {
    id: wholePage
    focus: true

    property string firstName: "John"
    property string lastName: "Smith"
    property string mobileNumber: "+333-455-3221"

    TitleBar {
        id: titleBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        color: "#f6f5f1"

        title: ""

        // @TODO: Do proper shevron
        leftButtonText: "All Contacts"
        onLeftButtonClicked: pageStack.pop()

        backChevron: true

        rightButtonText: "Edit"
        onRightButtonClicked: pageStack.push("qrc:///pages/NotYetImplemented.qml")

    }
    ScrollView {
        id: mainScrollView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.bottom: parent.bottom

        Rectangle {
            id: flickableBackground
            width: mainScrollView.width
            height: 1000
            color: "white"

            Text {
                id: name
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 30
                anchors.leftMargin: 38
                height: implicitHeight

                font.bold: true
                font.pixelSize: 16
                text: firstName + " " + lastName
            }

            Rectangle {
                id: phoneBlock
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: name.top
                anchors.topMargin: 80
                height: 50

                Text {
                    id: phoneTypeLabel
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 38
                    anchors.topMargin: 8
                    height: implicitHeight
                    color: Settings.colorActiveBlue

                    text: "mobile"
                }

                Text {
                    id: phoneNumberText
                    anchors.left: parent.left
                    anchors.leftMargin: 38
                    anchors.top: phoneTypeLabel.bottom
                    anchors.topMargin: 4
                    height: implicitHeight

                    text: mobileNumber
                }

                Image {
                    id: phoneHandleIcon
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 10
                    width: 30
                    height: width
                    source: "../images/blue-handle.png"
                }

                Image {
                    anchors.right: phoneHandleIcon.left
                    anchors.verticalCenter: phoneHandleIcon.verticalCenter
                    anchors.rightMargin: 10
                    width: phoneHandleIcon.width
                    height: phoneHandleIcon.height
                    source: "../images/blue-bubble.png"
                }

                Rectangle {
                    id: underliner
                    anchors.left: phoneTypeLabel.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    height: 1
                    color: "#cccccc"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: pageStack.push("qrc:///pages/NotYetImplemented.qml")
                }
            }

            Item {
                id: notesBlock
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: phoneBlock.bottom
                height: childrenRect.height

                Text {
                    id: notesFieldTitle
                    anchors.left: parent.left
                    anchors.top: parent.top
                    height: implicitHeight
                    anchors.leftMargin: 38
                    anchors.topMargin: 10

                    color: "#cccccc"
                    text: "Notes"
                }



                TextArea {
                    id: notesField
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: notesFieldTitle.bottom
                    anchors.leftMargin: 34
                    anchors.rightMargin: 18
                    anchors.topMargin: 6
                    property int lineHeight: 14

                    height: lineHeight * (lineCount+1)

                    frameVisible: false

                    text: "hello"
                }
                Rectangle {
                    id: notesUnderliner
                    anchors.left: notesField.left
                    anchors.right: parent.right
                    anchors.top: notesField.bottom
                    anchors.topMargin: 48
                    height: 1
                    color: "#cccccc"
                }
            }
        }
    }
}
