import QtQuick 2.0
import QtQuick.Controls 1.1

import "../settings.js" as Settings

Item {
    height: childrenRect.height

    property var _possibleTypes: ["home", "work", "mobile", "company main", "work fax",
        "home fax", "assistant", "pager", "car", "radio"]

    // Are signal when exclusive editing requested/released for a particular control
    // I.e. when clicks elsewhere should only cancel editing, but be ignored otherwise
    signal startedControlEditing(var control)
    signal finishedControlEditing(var control)

    ListModel {
        id: phonesModel
    }

    ListView {
        id: listView
        width: parent.width
        height: (count )*Settings.pne_height - (addTransition.running ? heightOfElementShown(
                                                           addTransition.ViewTransition.targetIndexes[0],
                                                           addTransition.ViewTransition.targetItems[0]) : 0)
        clip: true

        model: phonesModel

        interactive: false

        // @return pixels
        function heightOfElementShown(index, item) {
            return - (item.y - index*Settings.pne_height)
        }

        delegate: PhoneNumberEditor {
            id: editorDelegate
            width: parent.width
            z: -index
            type: text

            Component.onCompleted: {
                editorDelegate.focus = true
            }

            onStateChanged: {
                if(state == "deletionQuery") {
                    startedControlEditing(editorDelegate)
                } else {
                    finishedControlEditing(editorDelegate)
                }
            }
        }

        add: Transition {
            id: addTransition
            NumberAnimation {
                properties: "y";
                from: (addTransition.ViewTransition.targetIndexes[0] -1 )*Settings.pne_height
                to: addTransition.ViewTransition.targetIndexes[0]*Settings.pne_height
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

    }

    AddPhoneLine {
        anchors.top: listView.bottom
        width: parent.width
        visible: listView.count !== _possibleTypes.length
        onClicked: {
            if(listView.count < _possibleTypes.length) {
                phonesModel.append({text: _possibleTypes[listView.count]})
            }
        }
    }
}
