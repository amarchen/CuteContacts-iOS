import QtQuick 2.0
import QtQuick.Controls 1.1

/**
 * buttonIconSoure and buttonText properties are mutually exclusive. Ideally setting one should clear another one.
 * Right now just don't set both
 * @param color Background color
 *
 * @TODO: setting one of the variants for right button, should clear or make invisible the other one. Same for the left button
 */
Rectangle {
    id: titleBar

    property alias title: mainLabel.text
    property alias rightButtonIconSource: rightIconButton.source
    property string rightButtonText: ""
    property alias leftButtonIconSource: leftIconButton.source
    property string leftButtonText: ""
    signal leftButtonClicked
    signal rightButtonClicked


    signal leftControlClicked
    signal rightControlClicked

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    height: 49
    color: "#f6f5f1"

    Label {
        id: mainLabel
        anchors.centerIn: parent
        font.family: "Helvetica Neue"
        font.bold: true
        font.pointSize: 17
    }

    DimmableIconButton {
        id: leftIconButton
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.verticalCenter: parent.verticalCenter

        width: 18
        height: 18
        onClicked: titleBar.leftButtonClicked()
    }


    DimmableIconButton {
        id: rightIconButton
        anchors.right: parent.right
        anchors.rightMargin: 18
        anchors.verticalCenter: parent.verticalCenter

        width: 18
        height: 18
        onClicked: titleBar.rightButtonClicked()
    }

}
