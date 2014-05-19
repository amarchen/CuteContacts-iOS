import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

import "../components"

/**
 * @TODO report that it'd be nice to set iOS style even when running on desktop
 * @TODO scrollbars on desktop eat space from ScrollView.
 * @TODO Default scrollbar style on iOS looks not like iOS standard bars (too long, too thick) and you can't customize it easily
 * @TODO Position of cursor bar is to be controlled
 */

Item {
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
    ScrollView {
        id: mainScrollView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.bottom: parent.bottom

//        style: ScrollViewStyle {
//            transientScrollBars: true
//        }

        Rectangle {
            id: flickableBackground
            width: mainScrollView.width
            height: 1000
            color: "white"

            /**
             * @TODO Cannot position text inisde the rectangle using style
             */
            IOSTextField {
                id: firstNameField
                anchors.top: parent.top
                anchors.right: parent.right
                placeholderText: "First"
            }
            IOSTextField {
                id: lastNameField
                anchors.top: firstNameField.bottom
                anchors.right: parent.right
                placeholderText: "Last"
            }
            IOSTextField {
                id: companyField
                anchors.top: lastNameField.bottom
                anchors.right: parent.right
                placeholderText: "Company"
            }

        }

    }

}
