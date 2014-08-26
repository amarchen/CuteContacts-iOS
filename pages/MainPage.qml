import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtGraphicalEffects 1.0

import "../components"
import "../settings.js" as Settings

IOSPage {
    id: wholePage

    MouseArea {
        id: pageArea
        anchors.fill: parent
        onClicked: {
            pageArea.focus = true
        }

        TitleBar {
            id: titleBar
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            color: "#f6f5f1"

            title: "All Contacts"

            leftButtonText: "Groups"

            // just as a tmp trial for now
            onLeftButtonClicked: showMenu()
            rightButtonIconSource: "qrc:///images/plus.png"
            onRightButtonClicked: pageStack.push("qrc:///pages/NewContactPage.qml")
        }
        Rectangle {
            id: searchBar
            property alias text: searchField.text

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: titleBar.bottom
            height: 43
            color: "#c9c9ce"

            Rectangle {
                id: searchFieldWrapper
                anchors.left: parent.left
                anchors.right: cancelLabel.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 8
                anchors.rightMargin: 10
                anchors.topMargin: 6
                anchors.bottomMargin: 8
                radius: 6
                color: "white"

                TextField {
                    id: searchField
                    anchors.fill: parent
                    anchors.leftMargin: 24

                    horizontalAlignment: Text.AlignLeft

                    style: TextFieldStyle {
                        background: Rectangle {
                            radius: 6
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
                        visible: searchField.text.length > 0

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                searchField.text = ""
                            }
                        }
                    }

                }

                Item {
                    id: searchTextPlaceholder
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.leftMargin: 8
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
                        visible: searchField.text.trim().length === 0
                    }
                }

            }

            onTextChanged: {
                updateFilteredModel(text)
            }

            DimmableTextButton {
                id: cancelLabel

                anchors.left: parent.right
                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                clip: true
                font.family: "Helvetica Neue"
                font.pointSize: 18
                color: Settings.colorActiveBlue
                dimmingColor: "#c9c9ce"
                text: "Cancel"
                onClicked: {
                    // better than changing state as clicked will care about everything related to focus change
                    pageArea.clicked(null)
                }
            }

            Rectangle {
                id: underline
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 1
                color: "#bfbfc1"
            }


        }

        SampleContacts {
            id: contactsModel
        }

        ListModel {
            id: filteredContactsModel
        }

        ListView {
            id: contactList
            model: filteredContactsModel
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: searchBar.bottom
            anchors.bottom: parent.bottom

            section.property: "firstName"
            section.criteria: ViewSection.FirstCharacter
            section.labelPositioning: ViewSection.InlineLabels | ViewSection.CurrentLabelAtStart
            clip: true

            delegate: Rectangle {
                width: parent.width
                height: 40
                Text {
                    id: contactNameLabel
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 5
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 14
                    text: "<b>" + firstName + "</b> " + lastName
                }
                Rectangle {
                    id: underliner

                    // next section is undefined for the very first element and.. somehow for the very first delegate
                    // but for the prototyping purposes we just make sure there's more than one element in first section
                    anchors.left: isLastElementInSection(index, parent.ListView.section, parent.ListView.nextSection) ?
                                  parent.left : contactNameLabel.left

//                    anchors.left: contactNameLabel.left
                    anchors.right: contactNameLabel.right
                    anchors.top: contactNameLabel.bottom
                    anchors.topMargin: -1
                    height: 1

//                    visible: (!parent.ListView.nextSection) || parent.ListView.section == parent.ListView.nextSection

                    color: "#cccccc"

                    function isLastElementInSection(index, currSection, nextSection) {
                        // next section is undefined for the very last element and.. somehow for the very first delegate
                        // but for the prototyping purposes we just make sure there's more than one element in first section
                        if(index === 0) return false
                        if(typeof(nextSection) == "undefined") return true

                        return currSection != nextSection
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: pageStack.push("qrc:///pages/ContactViewPage.qml",
                                              {firstName: firstName, lastName: lastName, mobileNumber: mobileNumber,
                                               pushTransition: pageStack.transitionSlideFromRight,
                                               popTransition: pageStack.transitionSlideToRight})
                }
            }

            section.delegate: Rectangle {
                id: sectionDelegate
                width: parent.width
                height: 18
                color: "#eeeeee"
                Text {
                    id: sectionLabel
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 5
                    anchors.topMargin: 2
                    font.bold: true
                    font.pixelSize: 14
                    verticalAlignment: Text.AlignVCenter
                    text: section
                }
            }

            footer: Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                height:40

                Text {
                    anchors.centerIn: parent
                    text: contactsModel.count + " Contacts"
                    color: "#aaaaaa"
                }

            }

            // or ignore if such section is not found
            // real app would position to the closest present section probably
            function scrollToSection(section) {
                for(var i=0; i < contactsModel.count; i++) {
                    if(contactsModel.get(i).firstName.substr(0, 1).toUpperCase() == section) {
                        positionViewAtIndex(i, ListView.Beginning)
                        break
                    }
                }
            }
        }

        // Touch area is wider than image
        Item {
            id: listScrollerHolder
            anchors.top: contactList.top
            anchors.bottom: contactList.bottom
            anchors.right: contactList.right
            width: 24

            Image {
                id: listScroller
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                fillMode: Image.PreserveAspectFit

                source: "../images/alphabet-scroller-labels.png"
            }
            MouseArea {
                anchors.fill: parent
                onPositionChanged: {
                    contactList.scrollToSection(sectionForMouseY(mouse.y))
                }

                onPressed: {
                    contactList.scrollToSection(sectionForMouseY(mouse.y))
                }

                function sectionForMouseY(mouseY) {
                    // empty areas at top and bottom should be treated as first/last letters
                    var alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
                                    "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
                    var topBlancHeight = 10
                    var bottomBlancHeight = 20

                    if(mouseY < topBlancHeight) return alphabet[0]
                    if(mouseY > height - bottomBlancHeight) return alphabet[alphabet.length-1]

                    var letterIdx = Math.floor((mouseY-topBlancHeight) / (height / 26))
                    return alphabet[letterIdx]
                }
            }
        }

        states: [
            State {
                name: "searchBarActive"
                when: searchField.activeFocus
                AnchorChanges {
                    target: titleBar
                    anchors.top: pageArea.top
                    anchors.bottom: pageArea.top
                }
                AnchorChanges {
                    target: searchTextPlaceholder
                    anchors.horizontalCenter: undefined
                    anchors.left: searchFieldWrapper.left
                }
                AnchorChanges {
                    target: cancelLabel
                    anchors.left: undefined
                }
                PropertyChanges {
                    target: cancelLabel
                    width: cancelLabel.implicitWidth
                }
            },
            State {
                name: ""
                StateChangeScript {
                    script: {
                        Qt.inputMethod.hide()
                    }
                }
                PropertyChanges {
                    target: searchField
                    text: ""
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

    // @param filterText can be null or undefined as well
    function updateFilteredModel(filterText) {
        if(!filterText) filterText = ""
        filterText = filterText.toLowerCase()

        filteredContactsModel.clear()
        for(var i=0; i < contactsModel.count; i++ ) {
            var curr = contactsModel.get(i)
            if(curr.firstName.toLowerCase().indexOf(filterText) !== -1 ||
               curr.lastName.toLowerCase().indexOf(filterText) !== -1) {
                filteredContactsModel.append(curr)
            }
        }
    }

    Component.onCompleted: {
        console.log("MainPage completed. Platform OS is " + Qt.platform.os)
        updateFilteredModel(null)
    }

}
