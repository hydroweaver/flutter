import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImageProcess;

List<CameraDescription> cameras;

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
  int recognizedImage = 0;

  CameraController _cameraController;
  Map<PermissionGroup, PermissionStatus> permissions;

  void getPermission() async {
    permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  @override
  void initState(){
    getPermission();
    io.Directory("/storage/emulated/").exists()..then((onvalue){
      print(onvalue);
    });
    super.initState();
    _cameraController = CameraController(cameras[1], ResolutionPreset.medium);
    _cameraController.initialize()..then((_){
      if(!mounted){
        return;
      }
      setState(() {});
    });
  }

  //@override
  void changeCam(CameraDescription cameraDescription){
    _cameraController = CameraController(cameraDescription, ResolutionPreset.medium);
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
            });
            

          },
          child: Icon(Icons.camera),
          tooltip: "Take a Picture",
        ),
      )
    );
  }
}