import QtQuick 2.0
import Sailfish.Silica 1.0
import ".."

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    Column {
        id: column

        width: page.width
        spacing: Theme.paddingLarge
        PageHeader {
            title: qsTr("Settings")
        }
        TextField {
            id: ipAddressField
            width: parent.width
            label: qsTr("Camera IP Address")
            text: Controller.ipAddress
            onTextChanged: Controller.ipAddress = text
        }
    }
}
