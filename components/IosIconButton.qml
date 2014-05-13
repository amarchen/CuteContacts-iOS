import QtQuick 2.0

Image {
    id: wholeImage
    property alias iconSource: wholeImage.source
    signal clicked
    sourceSize.width: width
    sourceSize.height: height
    Rectangle {
        id: softener
        anchors.fill: parent
        color: "white"
        opacity: 0.5
        visible: wholeImageArea.pressed
    }

    MouseArea {
        id: wholeImageArea
        anchors.fill: parent
        onClicked: wholeImage.clicked()
    }
}
