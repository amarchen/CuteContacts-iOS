import QtQuick 2.0


Item {
    height: childrenRect.height

    property var _possibleTypes: ["home", "work", "mobile", "company main", "work fax",
        "home fax", "assistant", "pager", "car", "radio"]


    ListModel {
        id: phonesModel
    }

    Column {
        width: parent.width

        Repeater {
            id: phonesRepeater
            model: phonesModel

            PhoneNumberEditor {
                width: parent.width
                type: text
            }
        }

        AddPhoneLine {
            width: parent.width
            visible: phonesRepeater.count !== _possibleTypes.length
            onClicked: {
                if(phonesRepeater.count < _possibleTypes.length) {
                    phonesModel.append({text: _possibleTypes[phonesRepeater.count]})
                }
            }
        }

    }
}
