import QtQuick 2.0
import Sailfish.Silica 1.0
import ".."

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    Component.onCompleted: {
        Controller.statusLabel = statusLabel
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("Camera Remote Control")
            }
            Button {
                enabled: !Controller.running
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Capture")
                height: 2*width
                onClicked: Controller.capture()
            }
            Label {
                id: statusLabel
                property bool good: true
                x: Theme.horizontalPageMargin
                color: good ? "green" : "red"
                onTextChanged: {
                    opacity = 1.0
                    hideLabelTimer.restart()
                }
                FadeAnimator {
                    id: statusLabelAnimator
                    target: statusLabel
                    from: 1.0
                    to: 0.0
                    duration: 1500
                }
                Timer {
                    id: hideLabelTimer
                    interval: 3000
                    onTriggered: statusLabelAnimator.start()
                }
            }
        }
    }
}
