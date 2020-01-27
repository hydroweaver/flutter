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
  Uint8List img;

Future imgLoad(String path) async{
    var x = await rootBundle.load(path);

    // x.buffer.asFloat32List is same as Float32List.view(x.buffer)

    //Let's create an empty buffer to draw on from X flloat 32 list

    var empty_float = Float32List(x.buffer.asFloat32List().length);
    var x_flat = Uint8List.view(x.buffer);

    //so x_flat is a float32 buffer of X having values from x, which will now be converted and put into empty_float and then
    //empty_float will be used to display an image, lets see how....

    //MAP MODIFIED VALUES FORM x_flat to empty_float

    var counter = 0;
    for(var i =0; i < empty_float.length; i++){
      empty_float[i] = (x_flat[counter] + x_flat[counter+1] + x_flat[counter+2]) / 3.0;
      counter += 4;
    }

    img = empty_float.buffer.asUint8List();
    
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
            image: Image.memory(img).image,
            height: 200,
            width: 200,
            fit: BoxFit.contain,
          )
        ],
      )
    );
  }
}