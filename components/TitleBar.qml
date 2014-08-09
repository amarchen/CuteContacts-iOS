import QtQuick 2.0
import QtQuick.Controls 1.1

import "../settings.js" as Settings

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

    property bool backChevron: false

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

    // @TODO: dim on the whole action level, not on the label/icon level. At the moment chevron isn't dimmed at all
    Item {
        id: leftActionBlock
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: childrenRect.width

        // Capturing not handled by individual areas
        MouseArea {
            anchors.fill: parent
            onClicked: titleBar.leftButtonClicked()
        }

        Image {
            id: backChevronIcon
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 4
            visible: backChevron
            width: sourceSize.width / 2
            height: sourceSize.height / 2

            source: "../images/back-chevron.png"
        }

        DimmableIconButton {
            id: leftIconButton
            visible: source.toString().length > 0

            anchors.left: backChevronIcon.right
            anchors.leftMargin: 16
            anchors.verticalCenter: parent.verticalCenter

            width: height
            height: parent.height
            imageWidth: 18
            imageHeight: 18
            onClicked: titleBar.leftButtonClicked()
        }

        DimmableTextButton {
            id: leftTextButton
            visible: text.length > 0

            anchors.left: backChevron ? backChevronIcon.right : parent.left
            anchors.leftMargin: 6
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            verticalAlignment: Text.AlignVCenter

            clip: true
            font.family: "Helvetica Neue"
            font.pointSize: 18
            color: Settings.colorActiveBlue
            onClicked: titleBar.leftButtonClicked()
        }

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

    // @TODO: make areas close to title bar area right edge clickable too (under margin right now)


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
        color: Settings.colorActiveBlue
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
