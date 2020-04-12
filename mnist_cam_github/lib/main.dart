import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'classify.dart';
List<CameraDescription> cameras;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

    @override
    void initState(){
    //getPermission();
      super.initState();
      _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
      _cameraController.initialize().then((_){
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

  List<String> _imageFiles = new List<String>();

  CameraController _cameraController;

  Widget _cameraPreviewWidget() {
    if (!_cameraController.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio: _cameraController.value.aspectRatio,
        child: CameraPreview(_cameraController));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: _cameraPreviewWidget(),
      floatingActionButton: FloatingActionButton(
        //onPressed: _launchCamera,
        onPressed: () async {
          var filePath = await takePicture();
          classifyImage(filePath);
        },
        tooltip: 'Take a picture',
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Future<String> takePicture() async {
    
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/handwritten_digits';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${DateTime.now()}.jpg';

    await _cameraController.takePicture(filePath);
    return filePath;
  }

}

