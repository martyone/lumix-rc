import QtQuick 2.0
import Sailfish.Silica 1.0
import ".."

CoverBackground {
    Label {
        id: label
        anchors.centerIn: parent
        text: qsTr("Lumix Control")
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-m-dot"
            onTriggered: Controller.capture()
        }
    }
}
