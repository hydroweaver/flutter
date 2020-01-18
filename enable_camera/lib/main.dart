

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Enable Camera with FAB",
    home: EnableCamera(),
  ));

  var camera_list = availableCameras();
  print(camera_list);

}

class EnableCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Click for a pic"),
      ),
    );
  }
}