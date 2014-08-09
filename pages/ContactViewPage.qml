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
        leftButtonText: "< All Contacts"
        onLeftButtonClicked: pageStack.pop()

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
            }
        }
    }
}
