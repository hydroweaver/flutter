/*import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras;
CameraDescription camera_used;

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
          onPressed: (){
            camera_used??=cameras[1];
            setState(() {
              if(camera_used == cameras[1]){
                camera_used = cameras[0];
                changeCam(camera_used);
                print("Switch to Rear Cam");
                //initState();
              }
              else{
                camera_used = cameras[1];
                changeCam(camera_used);
                print("Switch to Front Cam");
                //initState();
              }
            });
          },
          child: Icon(Icons.switch_camera),
          tooltip: "Flip Camera",
        ),
      )
    );
  }
}*/