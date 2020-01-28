import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as Imageprocess;
import 'package:path/path.dart' as pt;
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tflite/tflite.dart';

void main()async{
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget{
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp>{

  var im = Image.asset('images/predict1.jpg');
  Map<PermissionGroup, PermissionStatus> permissions;

  void getPermission() async {
    permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

Uint8List imageToByteListFloat32(Imageprocess.Image image, int inputSize, double mean, double std) {
  var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
  var buffer = Float32List.view(convertedBytes.buffer);
  int pixelIndex = 0;
  for (var i = 0; i < inputSize; i++) {
    for (var j = 0; j < inputSize; j++) {
      var pixel = image.getPixel(j, i);
      buffer[pixelIndex++] = (Imageprocess.getRed(pixel) - mean) / std;
      buffer[pixelIndex++] = (Imageprocess.getGreen(pixel) - mean) / std;
      buffer[pixelIndex++] = (Imageprocess.getBlue(pixel) - mean) / std;
    }
  }
  return convertedBytes.buffer.asUint8List();
}



  Future load_image_model_predict() async{
    
  var img = await rootBundle.load('images/predict1.jpg');
   var x = Imageprocess.decodeJpg(img.buffer.asUint8List());

    //print(x.height); //220
    //print(x.width); //440

    //var new_image = Uint8List(x.height*x.width);
    //var x_buffer = Uint8List.view(img.buffer);
 
    var g = Imageprocess.grayscale(x);
    var g3 = Imageprocess.brightness(g, 100);
    //var g3 = Imageprocess.vignette(g2, start: 0.9, end: 2.0);
    var g4 = Imageprocess.quantize(g3, numberOfColors: 2);
    var g5 = Imageprocess.normalize(g4, 0, 255);
    var g6 = Imageprocess.copyCrop(g5, 300, 90, 250, 250);
    var g7 = Imageprocess.copyResize(g6, height: 28, width: 28);


    //var prediction_val = imageToByteListUint8(g7, 28);
     //var prediction_val = g7.getBytes().buffer.asUint8List();
    //, dstX: 5, dstY: 3

    /*//create a copy of image
    var blank_canvas = Imageprocess.normalize(g4, 255, 255);
    blank_canvas = Imageprocess.copyResize(blank_canvas, height: 28, width: 28);

    //paste g7 onto blank canvas in the center
    var resized = Imageprocess.copyInto(blank_canvas, g7, blend: false, );*/

    await io.File('/storage/emulated/0/Download/img.jpg').writeAsBytes(Imageprocess.encodeJpg(g7)).then((onValue) async{
      print(await onValue.exists());
    });

    var model_load = await Tflite.loadModel(model: 'model/karan_mnist.tflite', labels: 'model/labels.txt');
    print(model_load);
    var r = await Tflite.runModelOnBinary(binary: g7.getBytes().buffer.asUint8List());

    print(r);
    await Tflite.close();

  }

  @override
  void initState() { 
    super.initState();
    getPermission();
    load_image_model_predict();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Predict Image"),
      ),
      body: Image(
        image: im.image,
        height: 200,
        width: 200,
        fit: BoxFit.contain,
      ),
    );
  }
}