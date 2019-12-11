import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


//google maps SHOWS with both stateless and stateful widget, only when you need to re-animate of put in
//new stuff you need to use the stateful widgets

//taken a lot of help from : https://www.youtube.com/watch?v=G-JTpowQfdU !! Flutter docs dont do nothing ! :|


void main(){
  runApp(MaterialApp(
    title: "Embed Google Maps",
    home: MapsWidget(),
  ));
}

class Photos{
  String menuItem;
  IconData icon;
  Photos({this.menuItem, this.icon});
}

List<Photos> popUpList = <Photos>[
  Photos(menuItem: "Normal", icon: Icons.map),
  Photos(menuItem: "Satellite", icon: Icons.satellite)
];

class MapsWidget extends StatefulWidget{
  @override
  MapsWidgetState createState() => MapsWidgetState();
}

class MapsWidgetState extends State<MapsWidget>{
  double lat = 37.43296265331129;
  double lon = -122.08832357078792;

  Photos _selectedMaptype = popUpList[0];
  MapType _mapType;

  GoogleMapController mapcontroller;

  void _setMapType(Photos photo){
    setState(() {
      _selectedMaptype = photo;
      if(photo.menuItem == "Normal"){
        _mapType = MapType.normal;
      }
      else{
        _mapType = MapType.satellite;
      }
    });
    Fluttertoast.showToast(
      msg: "Selected $_mapType"
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Popup Menu Test"),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return popUpList.map((Photos photo){
                return PopupMenuItem(
                  child: ListTile(
                    leading: Icon(photo.icon),
                    title: Text(photo.menuItem),
                  ),
                  value: photo,
                );
              }).toList(); 
            },
            onSelected: _setMapType,
            onCanceled: (){
              Fluttertoast.showToast(
                msg: "Select a map type"
              );
            },
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, lon),
        ),
        onMapCreated: (GoogleMapController c){
          mapcontroller = c;
        },
        mapType: _mapType,
        onTap: (LatLng latLng){
          Fluttertoast.showToast(
            msg: latLng.toString()
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Reset Position"),
        icon: Icon(Icons.refresh),
        onPressed: (){
          setState(() {
            CameraPosition(
              target: LatLng(lat, lon),
            );
          });
        },
      ),
    );
  }
}