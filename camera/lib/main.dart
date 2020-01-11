import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';

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

  CameraController _cameraController;


  @override
  void initState(){
    io.Directory("/storage/emulateds").exists()..then((onvalue){
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
      return Container();
    }
    return AspectRatio(
      aspectRatio: _cameraController.value.aspectRatio,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Camera Preview"),
        ),
        body: CameraPreview(_cameraController),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final image_name = "${DateTime.now()}.jpg";
            final path = join((await getTemporaryDirectory()).path, "$image_name");
              await _cameraController.takePicture(path).then((_){
                print("Picture is at $path");
                print(image_name);
              });
            final phone_path = "/storage/emulated/0/Download/$image_name";
            await io.File(path).copy(phone_path).then((_){
              print("File has been saved");
            });
          },
          child: Icon(Icons.switch_camera),
          tooltip: "Flip Camera",
        ),
      )
    );
  }
}