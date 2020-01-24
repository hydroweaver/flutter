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

  Future<ByteData> imgLoad(String path) async{
    var x = await rootBundle.load(path);
    print(x.buffer);
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
      body: Image(
        image: Image.asset('images/predict1.jpg').image,
      )
    );
  }
}