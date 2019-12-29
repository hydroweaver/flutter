import 'dart:io';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: AppState(),
));

class AppState extends StatelessWidget{
  
  var assetfile = Image.file(File("C:/Users/hydro/Desktop/Capture.JPG"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing Swipe for Action"),
      ),
      body: /*Dismissible(
        key: Key("zonu"),
        child: CheckboxListTile(
          onChanged: (bool){},
          value: false,
          title: Text("data"),
        ),
        direction: DismissDirection.horizontal,
        background: Image(
          image: assetfile.image,
        )
    )*/  Image(
      image: assetfile.image,
    )  );
  }
}