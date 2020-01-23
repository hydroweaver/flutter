import 'dart:ffi';
import 'dart:typed_data' show Float32List, Uint8List;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'dart:ui' as ui;

import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImageProcess;
import 'package:tflite/tflite.dart' as tf;

List<CameraDescription> cameras;
String tflitemodel;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  //I/flutter (22836): [CameraDescription(0, CameraLensDirection.back, 90), CameraDescription(1, CameraLensDirection.front, 270)]
  //print(cameras);
  runApp(
    MaterialApp(
      home: MyApp(),
    )
  );
} 

class MyApp extends StatefulWidget{
  @override
  MyAppState createState(){
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{


  var placeHolderImage = Image.asset('images/placeholder.jpg');
  //var placeHolderImage = ImageProcess.decodeImage(io.File('storage/emulated/0/Download/predict.jpg').readAsBytesSync());
  int recognizedImage = 0;

  CameraController _cameraController;
  Map<PermissionGroup, PermissionStatus> permissions;

  void getPermission() async {
    permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage, PermissionGroup.camera]);
  }

  Future load_model() async {
    await tf.Tflite.loadModel(model : 'model/karan_mnist.tflite', labels: 'model/labels.txt');
    var predict_image_ByteData = io.File('/storage/emulated/0/Download/try.jpg').readAsBytesSync().buffer.asByteData();
    

    
    var resultBytes = Float32List(28*28);
    var buffer = Float32List.view(resultBytes.buffer);
    var resultBytes_byte = 0;
    for(var i = 0; i < buffer.lengthInBytes; i += 4){
        //get first 3 pixel values and combine them to get value for buffer, so (28, 28, 3) [RGB] to (28, 28), RGB combined
      var r_channel_value = predict_image_ByteData.getUint8(i);
      var g_channel_value = predict_image_ByteData.getUint8(i+1);
      var b_channel_value = predict_image_ByteData.getUint8(i+2);
      buffer[resultBytes_byte] = ((r_channel_value + g_channel_value + b_channel_value) / 3.0 / 255.0); //https://github.com/xinthink/flttf/blob/master/lib/recognizer.dart
      resultBytes_byte += 1;
    }

    print(resultBytes);
    print(resultBytes.buffer.asUint8List().length);
    var result = resultBytes.buffer.asUint8List();
    Future _predict(Uint8List bytes) => tf.Tflite.runModelOnBinary(binary: bytes).catchError((e, s) => debugPrint("prediction failure: $e $s"));
    var x = await _predict(result);

    print(x);

    /*Future _predict(Uint8List bytes) => tf.Tflite.runModelOnBinary(
    binary: resultBytes.buffer.asUint8List(),
  ).catchError((e, s) => debugPrint("prediction failure: $e $s"));

  _predict(buffer);*/
    //var result = await tf.Tflite.runModelOnImage(path: '/storage/emulated/0/Download/predict.jpg');

    //print(result);
    /*await io.File('/storage/emulated/0/Download/kiran.png').writeAsBytes(bytedata.toList()).then((onValue)async{
      print(await onValue.exists());
    });*/

  }

  @override
  void initState(){
    getPermission();
    load_model();
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    _cameraController.initialize()..then((_){
      if(!mounted){
        return;
      }
      setState(() {});
    });
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
    return AspectRatio(
      aspectRatio: _cameraController.value.aspectRatio,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Camera Preview"),
        ),
        body: Center(child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: CameraPreview(_cameraController),
              height: 300,
              width: 200,
            ),
            Expanded(
              child: Image(
                image: placeHolderImage.image,
                fit: BoxFit.contain,
                height: 300,
                width: 100,
              ),
            ),
            Expanded(
              child: Text("Value is $recognizedImage"),
            )
          ],
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final imageName = "${DateTime.now()}.jpg";
            final path = join((await getTemporaryDirectory()).path, "$imageName");
              await _cameraController.takePicture(path).then((_){
                print("Picture is at $path");
                print(imageName);
              });
            final phonePath = "/storage/emulated/0/Download/$imageName";
            await io.File(path).copy(phonePath).then((_){
              print("File has been saved");
            });

            var pickOriginalImage = ImageProcess.decodeImage(await io.File(phonePath).readAsBytes());
            var resizedImage = ImageProcess.copyResizeCropSquare(pickOriginalImage, 28);
            
            
            //var loadresizedImageBytes = resizedImage.getBytes();
            //print(loadresizedImageBytes.length);
            //LOADING FROM MEMORY DOESNT WORK AFTER USING IMAGE LIB !!! :|
            //placeHolderImage = Image.memory(loadresizedImageBytes);
            // so saving first and then loading...even lonnger! 

            
            var resizedImagePath = join('/storage/emulated/0/Download', 'Resized ${imageName}.jpg');
            await io.File(resizedImagePath).writeAsBytes(ImageProcess.encodeJpg(resizedImage));
            var pickResizedImageBytes = await io.File(resizedImagePath).readAsBytes();


            setState(() {
              placeHolderImage = Image.memory(pickResizedImageBytes);
              //placeHolderImage = ImageProcess.decodeImage(pickResizedImageBytes);
            });
            

          },
          child: Icon(Icons.camera),
          tooltip: "Take a Picture",
        ),
      )
    );
  }
}