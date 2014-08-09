import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

import "../components"
import "../settings.js" as Settings

/**
 * @TODO report that it'd be nice to set iOS style even when running on desktop
 * @TODO scrollbars on desktop eat space from ScrollView.
 * @TODO Default scrollbar style on iOS looks not like iOS standard bars (too long, too thick) and you can't customize it easily
 * @TODO Position of cursor bar is to be controlled
 */

Item {
    id: wholePage
    focus: true

    // when not empty, clicks are blocked for everything except the controls inside
    property var exclusiveControls: []

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

        Rectangle {
            id: flickableBackground
            width: mainScrollView.width
            height: 1000
            color: "white"

            /** Eats mouse events for the **/
            Rectangle {
                id: excluder
                anchors.fill: parent
                color: "transparent"
                z: 1000
                visible: exclusiveControls && exclusiveControls.length > 0
                MouseArea {
                    id: excluderArea
                    anchors.fill: parent
                    onPressed: {
                        if(withinTheControls(excluderArea, mouse.x, mouse.y, exclusiveControls)) {
                            mouse.accepted = false
                        }
                    }

                    onClicked: {
                        // okay, not so good binding. Just go over all controls willing to be exclusive and
                        // cancel this wish of theirs
                        if(!exclusiveControls) return;
                        while(exclusiveControls.length) {
                            exclusiveControls.pop().state = ""
                        }
                    }

                    /**
                     * @return true if x,y are within one of the controls. False otherwise
                     * @param x,y coords in the coord system of eventOriginControl
                     * @param controls List if Items to check if coordinates re within them or not
                     */
                    function withinTheControls(eventOriginControl, x, y, controls) {
                        for(var i=0; i < controls.length; i++) {
                            var translatedCoords = eventOriginControl.mapToItem(controls[i], x, y)
                            if(controls[i].contains(Qt.point(translatedCoords.x, translatedCoords.y))) {
                                return true
                            }
                        }
                        return false;
                    }

                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("NCP: background clicked")
                    parent.focus = true
                    Qt.inputMethod.hide()
                }
            }

            Rectangle {
                id: addPhotoCircle
                width: 60
                height: width
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.left: parent.left
                anchors.leftMargin: 35
                radius: width / 2
                color: "transparent"
                border.width: 1
                border.color: "#c9c9ce"

                Label {
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "add\nphoto"
                    color: Settings.colorActiveBlue
                    font.pixelSize: 12
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: pageStack.push("qrc:///pages/NotYetImplemented.qml")
                }
            }

            /**
             * @TODO Cannot position text inside the rectangle using style
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

            PhonesBlock {
                id: phonesBlock
                anchors.top: companyField.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: 56

                onStartedControlEditing: {
                    // trick to emit property signal
                    var tmpArray = exclusiveControls
                    if(!tmpArray) tmpArray = []
                    exclusiveControls = null

                    tmpArray.push(control)
                    exclusiveControls = tmpArray
                }

               onFinishedControlEditing: {
                   // trick to emit property signal
                   var tmpArray = exclusiveControls
                   if(!tmpArray) tmpArray = []
                   exclusiveControls = null

                   for(var i=0; i<tmpArray.length; i++) {
                       if(tmpArray[i] === control) {
                           tmpArray.splice(i, 1)
                           i = i - 1
                       }
                   }
                   exclusiveControls = tmpArray
               }
            }

        }

    }

}
