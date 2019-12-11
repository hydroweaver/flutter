import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission/permission.dart';


//google maps SHOWS with both stateless and stateful widget, only when you need to re-animate of put in
//new stuff you need to use the stateful widgets

//taken a lot of help from : https://www.youtube.com/watch?v=G-JTpowQfdU !! Flutter docs dont do nothing ! :|

//Sometimes, and I don't know why, some classes like PopupMenuButton dont infer the type correctly, even though somewhere else
//it works without any problem, and I compared it line by line, so added <T> wherever the error was shown.
// Was able to see this error only when in the tooltip for the class the <String> or <Maps> type was shown...so changed it.

//NEED TO WORK ON https://pub.dev/packages/permission_handler

void main(){
  runApp(MaterialApp(
    title: "Embed Google Maps",
    home: MapsWidget(),
  ));
}

class Maps{
  String maptype;
  IconData icon;
  Maps({this.maptype, this.icon});
}

List<Maps> mapList = <Maps>[
  Maps(maptype: "Normal", icon: Icons.map),
  Maps(maptype: "Satellite", icon: Icons.satellite)
];

class MapsWidget extends StatefulWidget{
  @override
  MapsWidgetState createState() => MapsWidgetState();
}

class MapsWidgetState extends State<MapsWidget>{
  
  var location_persmission = Permission.getPermissionsStatus([PermissionName.Location]);
  var location_permission_name = Permission.requestPermissions([PermissionName.Location]);

  

  Maps _maps = mapList[0];
  bool getUserLocationPermission = false;
  GoogleMapController mapcontroller;
  MapType _maptype;

  void _selectMapType(Maps maps){
    setState(() {
      _maps = maps;
      if(maps.maptype == "Normal"){
        _maptype = MapType.normal;
      }
      else{
        _maptype = MapType.satellite;
      }
    });
    Fluttertoast.showToast(
      msg: "Selected $_maptype"
    );
  }


  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Popup Menu Test"),
        actions: <Widget>[
          PopupMenuButton<Maps>(
            itemBuilder: (BuildContext context){
              return mapList.map((Maps maps){
                return PopupMenuItem<Maps>(
                  child: ListTile(
                    leading: Icon(maps.icon),
                    title: Text(maps.maptype),
                  ),
                  value: maps,
                );
              }).toList();
            },
            onSelected: _selectMapType,
          )
        ],
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.43296265331129, -100.08832357078792),
        ),
        onMapCreated: (GoogleMapController controller){
          mapcontroller = controller;
        },
        onTap: (LatLng latLng){
          /*mapcontroller.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(90, 30)
              )
            )
          );*/
          Fluttertoast.showToast(
            msg: "Tapped Location is $latLng"
          );
        },
        onCameraMove: (CameraPosition cameraPosition){
          var x = cameraPosition.target;
          print("Camera is pointing at $x");
        },
        /*onCameraMove: (CameraPosition cameraPosition){
          var x = mapcontroller.getLatLng(ScreenCoordinate(x: 200, y: 300));
          mapcontroller.animateCamera(
            CameraUpdate.newLatLng(x)
          );
          I HAVE NO FRIGGIN CLUE HOW TO USE AND IT AND MOREOVER NO NEED AS OF NOW, AFTER USING ON CAMERA MORE,
          IT HAS SOMETHING TO DO WITH ASYNC BECAUSE OF FUTURE VALUES AND I'M PISSED AND NOT INTELLIGENT ENOUGH TO USE IT
          SO I'M JUST GOING TO DO THE FOLLOWING:
          1. POPMENU WUTH 2 MAP TYPES
          2. FAB TO GO TO MAIN LOCATION
          3. TRY TO GET USER LOCATION....TRY....NOT BANG MY HEAD !!
          3. BE DONE ! BYE
        },*/
        mapType: _maptype,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Take me home!"),
        icon: Icon(Icons.refresh),
        onPressed: (){
          mapcontroller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(12.988946, 77.731143),
                zoom: 5.0
              )
            ),
          );
          Fluttertoast.showToast(
              msg: "Back Home!"
            );
        },
      ),
    );
  }
}