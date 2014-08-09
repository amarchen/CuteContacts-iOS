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
    property alias rightButtonText: rightTextButton.text
    property alias leftButtonIconSource: leftIconButton.source
    property alias leftButtonText: leftTextButton.text
    signal leftButtonClicked
    signal rightButtonClicked


    signal leftControlClicked
    signal rightControlClicked

    height: 50
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
        visible: source.toString().length > 0

        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.verticalCenter: parent.verticalCenter

        width: height
        height: parent.height
        imageWidth: 18
        imageHeight: 18
        onClicked: titleBar.leftButtonClicked()
    }


    DimmableIconButton {
        id: rightIconButton
        visible: source.toString().length > 0

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        width: height
        height: parent.height
        imageWidth: 18
        imageHeight: 18
        onClicked: titleBar.rightButtonClicked()
    }

    // @TODO: make areas close to title bar area edges clickable too (under margin right now)
    DimmableTextButton {
        id: leftTextButton
        visible: text.length > 0

        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        verticalAlignment: Text.AlignVCenter

        clip: true
        font.family: "Helvetica Neue"
        font.pointSize: 18
        color: "#0079ff"
        onClicked: titleBar.leftButtonClicked()
    }

    DimmableTextButton {
        id: rightTextButton
        visible: text.length > 0

        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        verticalAlignment: Text.AlignVCenter

        clip: true
        font.family: "Helvetica Neue"
        font.pointSize: 18
        color: "#0079ff"
        onClicked: titleBar.rightButtonClicked()
    }

    Rectangle {
        id: underline
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 1
        color: "#a3a3a6"
    }

}
