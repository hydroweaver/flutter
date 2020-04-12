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

  var placeholderImage = Image.asset('images/placeholder.jpg');

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
 
    var g = Imageprocess.grayscale(x);
    var g3 = Imageprocess.brightness(g, 100);
    //var g3 = Imageprocess.vignette(g2, start: 0.9, end: 2.0);
    var g4 = Imageprocess.quantize(g3, numberOfColors: 2);
    var g5 = Imageprocess.normalize(g4, 0, 255);
    var g6 = Imageprocess.copyCrop(g5, 300, 90, 250, 250);
    var g7 = Imageprocess.copyResize(g6, height: 28, width: 28);

    setState(() {
      placeholderImage = Image.memory(g7.getBytes());
    });

    var convertedBytes = Float32List(28*28);
    print(convertedBytes.length);
    print(convertedBytes.lengthInBytes);

    var buffer = Float32List.view(convertedBytes.buffer);
    print(buffer.length);
    print(buffer.lengthInBytes);

    int pixIndex = 0;
    for(var i = 0; i < 28; i++){
      for(var j = 0;j< 28;j++){
        var pixel = g7.getPixel(i, j);
        //buffer[pixIndex++] = (Imageprocess.getRed(pixel) + Imageprocess.getGreen(pixel) + Imageprocess.getBlue(pixel)) / 3 / 255.0;
        convertedBytes[pixIndex++] = (Imageprocess.getRed(pixel) + Imageprocess.getGreen(pixel) + Imageprocess.getBlue(pixel)) / 3 / 255.0;
      }
    }

    var inferbytes = convertedBytes.buffer.asUint8List();

    await Tflite.loadModel(model: 'model/karan_mnist.tflite', labels: 'model/labels.txt').then((onValue){
      print(onValue);
    });
    List result = await Tflite.runModelOnBinary(binary: inferbytes);

    print(result);
    Tflite.close();

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: im.image,
            fit: BoxFit.contain,
            height: 200,
            width: 200,
          ),
          Image(image: placeholderImage.image)
        ],
      )
    );
  }
}