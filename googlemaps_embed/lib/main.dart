import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


//google maps SHOWS with both stateless and stateful widget, only when you need to re-animate of put in
//new stuff you need to use the stateful widgets


void main(){
  runApp(MaterialApp(
    title: "Embed Google Maps",
    home: MapsWidget(),
  ));
}

class MapsWidget extends StatefulWidget{
  @override
  MapsWidgetState createState() => MapsWidgetState();
}

class MapsWidgetState extends State<MapsWidget>{

  GoogleMapController mapcontroller;
  MapType mapTypeview;

  bool expanded = false;
  List<String> popUpList = ["Normal"];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Popup Menu Test"),
      ),
      body: PopupMenuButton(
        itemBuilder: (BuildContext context){
          List<PopupMenuItem<String>> x = popUpList.map((String val) {
            PopupMenuItem<String>(
              value: val,
              child: Text(val),
            );
          }
          );
          return x;
        },
        icon: Icon(Icons.map),
      ),
    );
  }
}