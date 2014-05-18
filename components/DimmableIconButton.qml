import QtQuick 2.0

/**
 * A clickable icon button that knows how to dim itself (by overlaying rectangle of supposedly bacground color on top)
 * during a mouse press. Dimming happens with a short delay.
 *
 * It is supposed to simulate the iOS icon buttons located in the title bar. Simulation looks okay except for one detail:
 * in iOS of you drag finger out of the button while having it pressed at some distance discance goes away (and returns if you
 * drag finge closer to the button again)
 *
 * @param source icon source to be used
 * @param dimmingColor Set to the background color below the button
 * @signal clicked When clicked
 *
 * @TODO: Mention missing dimming goes away on distant dragging in the docs
 */
Image {
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
