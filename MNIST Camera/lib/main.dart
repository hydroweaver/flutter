import 'dart:ffi';
import 'dart:typed_data' show Float32List, Uint8List;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  var placeHolderImage2 = Image.asset('images/placeholder.jpg');
  var recognizedImage;
  var prediction_image_path;

  CameraController _cameraController;
  Map<PermissionGroup, PermissionStatus> permissions;

  void getPermission() async {
    permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage, PermissionGroup.camera]);
  }

  Future _predict(Uint8List bytes) async{
    return await tf.Tflite.runModelOnBinary(binary: bytes);
  }

  Future load_image_and_predict(String prediction_image_path) async {
    await tf.Tflite.loadModel(model : 'model/karan_mnist.tflite', labels: 'model/labels.txt');
    var predict_image_ByteData = io.File(prediction_image_path).readAsBytesSync().buffer.asByteData();

    if(predict_image_ByteData.lengthInBytes < 3136){
      setState(() {
        recognizedImage = "Try taking another image, image size is <3136";
      });
    }
    else{
      var resultBytes = Float32List(28*28);
      var buffer = Float32List.view(resultBytes.buffer);
      var resultBytes_byte = 0;

      for(var i = 0; i < buffer.lengthInBytes; i += 4){
        var r_channel_value = predict_image_ByteData.getUint8(i);
        var g_channel_value = predict_image_ByteData.getUint8(i+1);
        var b_channel_value = predict_image_ByteData.getUint8(i+2);
        buffer[resultBytes_byte] = ((r_channel_value + g_channel_value + b_channel_value) / 3.0 / 255.0); //https://github.com/xinthink/flttf/blob/master/lib/recognizer.dart
        resultBytes_byte += 1;
      }
      
      var bytes_for_model = resultBytes.buffer.asUint8List();
      
      recognizedImage = await _predict(bytes_for_model);

        setState(() {
          placeHolderImage2 = Image.memory(bytes_for_model);
          //placeHolderImage2 = ImageProcess.decodeJpg(bytes_for_model);
        });
      }
  }


  @override
  void initState(){
    getPermission();
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: placeHolderImage.image,
                    fit: BoxFit.contain,
                    height: 300,
                    width: 100,
                  ),
                  Image(
                    image: placeHolderImage2.image,
                  )
                ],
              ),
            ),
            Expanded(
              child: Text("$recognizedImage"),
            )
          ],
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {

            final imageName = "RawImage_${DateTime.now()}.jpg";
            final path = join((await getTemporaryDirectory()).path, "$imageName");
            await _cameraController.takePicture(path);

            final phonePath = "/storage/emulated/0/Download/$imageName";
            await io.File(path).copy(phonePath);

            var pickOriginalImage = ImageProcess.decodeImage(await io.File(phonePath).readAsBytes());
            var resizedImage = ImageProcess.copyResizeCropSquare(pickOriginalImage, 28);

            var resizedImagePath = join('/storage/emulated/0/Download', 'ResizedImage_${imageName}.jpg');
            await io.File(resizedImagePath).writeAsBytes(ImageProcess.encodeJpg(resizedImage));
            var pickResizedImageBytes = await io.File(resizedImagePath).readAsBytes();

            await load_image_and_predict(resizedImagePath);

            setState(() {
              placeHolderImage = Image.memory(pickResizedImageBytes);
            });

            

          },
          child: Icon(Icons.flight_takeoff),
          tooltip: "Predict Image",
        ),
      )
    );
  }
}