import QtQuick 2.0
import QtQuick.Controls 1.1

/**
 * A clickable text button that knows how to dim itself (by overlaying rectangle of supposedly bacground color on top)
 * during a mouse press. Dimming happens with a short delay.
 *
 * It is supposed to simulate the iOS text buttonslocated in the title bar. Simulation looks okay except for one detail:
 * in iOS of you drag finger out of the button while having it pressed at some distance discance goes away (and returns if you
 * drag finge closer to the button again)
 *
 * @param dimmingColor Set to the background color below the button
 * @signal clicked When clicked
 *
 * @TODO: Mention missing dimming goes away on distant dragging in the docs
 */
Label {
    signal clicked
    property alias dimmingColor: dimmer.color

    MouseArea {
        id: buttonArea
        anchors.fill: parent
        onClicked: {
            parent.clicked()
        }
    }
    Rectangle {
        id: dimmer
        anchors.fill: parent
        color: "#f6f5f1"
        opacity: 0.0
    }

    states: [
        State {
            name: "pressed"
            when: buttonArea.pressed

            PropertyChanges {
                target: dimmer
                visible: true
                opacity: 0.8
            }
        }
    ]
    transitions: [
        Transition {
            NumberAnimation {
                target: dimmer
                properties: "opacity";
                easing.type: Easing.InOutQuad
                duration: 100
            }
        }

    ]
}
