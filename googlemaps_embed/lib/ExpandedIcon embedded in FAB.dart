import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


//google maps SHOWS with both stateless and stateful widget, only when you need to re-animate of put in
//new stuff you need to use the stateful widgets


/*void main(){
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

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Maps Test"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: ExpandIcon(
          onPressed: (bool){
            setState(() {
              if(!expanded){
                expanded = true;
              }
              else{
                expanded = false;
              }
            });
          },
          isExpanded: expanded,
        ),
      ),
    );
  }
}*/