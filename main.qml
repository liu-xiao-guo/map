import QtQuick 2.0
import Ubuntu.Components 0.1
import "components"
import QtLocation 5.0
import QtPositioning 5.0

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "com.ubuntu.developer.liu-xiao-guo.map"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    width: units.gu(100)
    height: units.gu(75)

    Page {
        title: i18n.tr("Map")

        Rectangle {
            anchors.fill: parent
            color: "#343434"            

            PositionSource {
                id: me
                active: true
                updateInterval: 1000
                preferredPositioningMethods: PositionSource.AllPositioningMethods
                onPositionChanged: {
                    console.log("lat: " + position.coordinate.latitude + " longitude: " +
                                position.coordinate.longitude);
                    console.log(position.coordinate)
                }

                onSourceErrorChanged: {
                    console.log("Source error: " + sourceError);
                }
            }

            Map {
                id: map
                plugin : Plugin {
                    name: "osm"
                }
                anchors.fill: parent
                zoomLevel: 12
                center: me.position.coordinate
                //                center: QtPositioning.coordinate(39.9289 , 116.3883)

                MapCircle {
                    center: me.position.coordinate
                    radius: units.gu(20)
                    color: "red"
                }

                Label {
                    anchors { top: parent.top; left: parent.left; margins: units.gu(2) }
                    text: "Position is: (" + me.position.coordinate.latitude + ", " +
                          me.position.coordinate.longitude + ")";
                    fontSize: "large"
                    color: "red"
                }
            }
        }

        Button {
            anchors.left:parent.left
            anchors.verticalCenter: parent.verticalCenter;
            id: start
            text: "Start"
            onClicked: {
                console.log("start it now!");
                me.start();

                console.log("supportedPositioningMethods: " + me.supportedPositioningMethods);
            }
        }
    }

    Component.onCompleted: {
        // start the positioning
        console.log("starting....");
        me.start();
    }
}

