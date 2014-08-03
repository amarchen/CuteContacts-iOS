import QtQuick 2.0
import QtQuick.Controls 1.1

Item {
    height: childrenRect.height

    property var _possibleTypes: ["home", "work", "mobile", "company main", "work fax",
        "home fax", "assistant", "pager", "car", "radio"]
FocusScope{
    anchors.fill: parent

    ListModel {
        id: phonesModel
    }

    ListView {
        id: listView
        width: parent.width
        height: (count )*36 - (addTransition.running ? heightOfElementShown(
                                                           addTransition.ViewTransition.targetIndexes[0],
                                                           addTransition.ViewTransition.targetItems[0]) : 0)
        clip: true

        model: phonesModel

        // @return pixels
        function heightOfElementShown(index, item) {
            return - (item.y - index*36)
        }

        delegate: PhoneNumberEditor {
            id: editorDelegate
            width: parent.width
            z: -index
            type: text

            Component.onCompleted: {
                editorDelegate.focus = true
            }
        }

        add: Transition {
            id: addTransition
            NumberAnimation {
                properties: "y";
                from: (addTransition.ViewTransition.targetIndexes[0] -1 )*36
                to: addTransition.ViewTransition.targetIndexes[0]*36
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

}
