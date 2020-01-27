import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as Imageprocess;
import 'package:path/path.dart' as pt;
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tflite/tflite.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  //I/flutter (22836): [CameraDescription(0, CameraLensDirection.back, 90), CameraDescription(1, CameraLensDirection.front, 270)]
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
  CameraController _cameraController;
  Map<PermissionGroup, PermissionStatus> permissions;

    void getPermission() async {
    permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  Future load_image_model_predict() async{
    
  var img = await rootBundle.load('images/predict1.jpg');
   var x = Imageprocess.decodeJpg(img.buffer.asUint8List());

    //print(x.height); //220
    //print(x.width); //440

    var new_image = Uint8List(x.height*x.width);
    var x_buffer = Uint8List.view(img.buffer);
 
    var g = Imageprocess.grayscale(x);
    var g3 = Imageprocess.brightness(g, 100);
    //var g3 = Imageprocess.vignette(g2, start: 0.9, end: 2.0);
    var g4 = Imageprocess.quantize(g3, numberOfColors: 2);
    var g5 = Imageprocess.normalize(g4, 0, 255);
    var g6 = Imageprocess.copyCrop(g5, 300, 90, 250, 250);
    var g7 = Imageprocess.copyResize(g6, height: 28, width: 28);
    var prediction_val = g7.getBytes().buffer.asUint8List();
    //, dstX: 5, dstY: 3

    /*//create a copy of image
    var blank_canvas = Imageprocess.normalize(g4, 255, 255);
    blank_canvas = Imageprocess.copyResize(blank_canvas, height: 28, width: 28);

    //paste g7 onto blank canvas in the center
    var resized = Imageprocess.copyInto(blank_canvas, g7, blend: false, );*/

    await io.File('/storage/emulated/0/Download/img.jpg').writeAsBytes(Imageprocess.encodeJpg(g7)).then((onValue) async{
      print(await onValue.exists());
    });

    print(prediction_val);

    var model_load = await Tflite.loadModel(model: 'model/mnist.tflite', labels: 'model/labels.txt');
    print(model_load);

    var r = await Tflite.runModelOnBinary(binary: prediction_val);

    print(r);
    Tflite.close();


  }

  @override
  void initState() { 
    super.initState();
    getPermission();

    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    _cameraController.initialize()..then((_){
      if(!mounted){
        return;
      }
      setState(() {});
    });

    load_image_model_predict();
  }

  @override
  void dispose(){
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    if(!_cameraController.value.isInitialized){
      return Container(
      );
    }
    return 
  }
}