pragma Singleton
import QtQuick 2.0

QtObject {
    property string ipAddress: "192.168.54.1"
    property var statusLabel: null
    property bool running: false

    function _success()
    {
        statusLabel.text = qsTr("Succeeded")
        statusLabel.good = true
    }

    function _error(message)
    {
        statusLabel.text = message
        statusLabel.good = false
    }

    function _camcmd(commands)
    {
        running = true
        var command = commands.shift()
        var doc = new XMLHttpRequest();
        doc.onerror = function() {
            _error(qsTr("Network error"))
            running = false
        }

        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status === 200) {
                    var camrply = doc.responseXML.documentElement;
                    if (camrply.nodeName !== "camrply") {
                        _error(qsTr("Protocol error"))
                        console.error("Unexpected response: Expected 'camrply' element, got: " + camrply.nodeName)
                        running = false
                        return
                    }
                    var result = camrply.firstChild
                    if (result.nodeName !== "result") {
                        _error(qsTr("Protocol error"))
                        console.error("Unexpected response: Expected 'result' element, got: " + result.nodeName)
                        running = false
                        return
                    }
                    var result_code = result.firstChild.data
                    if (result_code === "ok") {
                        _success()
                        if (commands.length !== 0)
                            _camcmd(commands)
                        else
                            running = false
                    } else {
                        _error(qsTr("Command failed (code: %1)").arg(result_code))
                        running = false
                    }
                } else {
                    _error(qsTr("HTTP error %1: %2").arg(doc.status).arg(doc.statusText))
                    running = false
                }
            }
        }

        doc.open("GET", "http://" + ipAddress + "/cam.cgi?mode=camcmd&value=" + command);
        doc.send();
    }

    function capture()
    {
        _camcmd(["recmode", "capture"])
    }
}
