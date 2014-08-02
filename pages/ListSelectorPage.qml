import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

import "../components"


Item {
    property alias title: titleBar.title
    property alias leftButtonText: titleBar.leftButtonText
    property alias rightButtonText: titleBar.rightButtonText

    // List of strings to display
    property var items: []

    TitleBar {
        id: titleBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        color: "#f6f5f1"

        title: "New Contact"

        leftButtonText: "Cancel"
        onLeftButtonClicked: pageStack.pop()

        rightButtonText: "Done"
        onRightButtonClicked: console.log("NCP: Done button clicked")

    }

    ListModel {
        id: itemsModel
        ListElement {
            text: "home"
        }
        ListElement {
            text: "home2"
        }
        ListElement {
            text: "home3"
        }
    }

    ListView {
        anchors.top: titleBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        model: itemsModel
        header: Item {
            width: parent.width
            height: 36
//            color: "#efeff4"
        }
        footer: Item {
            width: parent.width
            height: 36
//            color: "#efeff4"
        }

        delegate: Rectangle {
            width: parent.width
            height: 43

            Text {
                id: itemText
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10
                font.pixelSize: 16
                text: model.text
            }
            Rectangle {
                id: underline
                visible: (index+1 !== parent.ListView.view.count)
                anchors.left: itemText.left
                anchors.right: parent.right
                anchors.top: parent.bottom
                anchors.topMargin: -1
                height: 1
                color: "#cccccc"
            }

            Image {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 10
                width: sourceSize.width / 2
                height: sourceSize.height / 2
                visible: parent.ListView.isCurrentItem

                source: "../images/blue-checkmark.png"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    parent.ListView.view.currentIndex = index
                }
            }
        }

        onCurrentIndexChanged: {
            console.log("currentIndex changed to " + currentIndex)
        }
    }

    Component.onCompleted: {
        itemsModel.clear()
        for(var i=0; i < items.length; i++) {
            itemsModel.append({text: items[i]})
        }
    }
}
