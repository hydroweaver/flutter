import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as pt;
import 'dart:io' as io;

import 'package:flutter/services.dart';

void main(){
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget{
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp>{
  
  
  //var predict_image_ByteData = io.File('/storage/emulated/0/Download/try.jpg').readAsBytesSync().buffer.asByteData();
  var im = rootBundle.load('images/predict1.jpg');
  Uint8List img_uint8;

imgLoad(String path) async{
    var x = await rootBundle.load(path);
    img_uint8 = x.buffer.asUint8List();
    var im2 = x.buffer.asByteData();
    for(var i =0; i < im2.lengthInBytes; i++){
      print(im2.getFloat32(i));
    }
  }

  void initState(){
    super.initState();
    imgLoad('images/predict1.jpg');
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Image"),
      ),
      body: Row(
        children: <Widget>[
          Image(
            image: Image.asset('images/predict1.jpg').image,
            height: 200,
            width: 200,
            fit: BoxFit.contain,
          ),
          Image(
            image: Image.memory(img_uint8).image,
            height: 200,
            width: 200,
            fit: BoxFit.contain,
          )
        ],
      )
    );
  }
}