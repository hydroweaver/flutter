import 'dart:typed_data' show Float32List, Uint8List;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImageProcess;
import 'package:tflite/tflite.dart';

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
  var result;
  CameraController _cameraController;
  Map<PermissionGroup, PermissionStatus> permissions;
  
  Widget _cameraPreviewWidget() {
    if (!_cameraController.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio: _cameraController.value.aspectRatio,
        child: CameraPreview(_cameraController));
  }

  void getPermission() async {
    await PermissionHandler().requestPermissions([PermissionGroup.storage, PermissionGroup.camera]);
  }


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

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text("Camera Preview"),
        ),
        body: Column(
          children: <Widget>[
            _cameraPreviewWidget(),
            Padding(
              padding: EdgeInsets.all(18),
            ),
            Text('$result')
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {

            var filePath = await saveFileAndGetPath();
            //await classifyImage(filePath);
            await runModel(filePath);
            
            /*//Take Image & Save as JPG in Temporary Directory
            final imageName = "RawImage_${DateTime.now()}.jpg";
            final path = join((await getApplicationDocumentsDirectory()).path, "$imageName");
            await _cameraController.takePicture(path);

            //Get image from temp directory and load as byte buffer
            var pickOriginalImage = io.File(path).readAsBytesSync().buffer;
            
            //Decode image from JPG to uint8List
            ImageProcess.Image decodedImage = ImageProcess.decodeJpg(pickOriginalImage.asUint8List());

            //Operations on decodedImage to make it passable for MNIST model
            //var grayScaleImage = ImageProcess.grayscale(decodedImage);
            //var brightImage = ImageProcess.brightness(grayScaleImage, 100);
            //var quantizeImage = ImageProcess.quantize(brightImage, numberOfColors: 2);
            //var normalizeImage = ImageProcess.normalize(quantizeImage, 0, 255);
            //var cropImage = ImageProcess.copyCrop(normalizeImage, 300, 90, 250, 250);
            ImageProcess.Image resizedImage = ImageProcess.copyResize(decodedImage, height: 28, width: 28);

            //io.File('/storage/emulated/0/Download/prediction.jpg').writeAsBytesSync(ImageProcess.encodeJpg(resizedImage));

            //Predict on convertedArray

            await runModel(resizedImage);
            
            setState(() {
              //placeHolderImage = Image.memory(normalizeImage.getBytes());
            });*/
            
          },
          child: Icon(Icons.camera),
          tooltip: "Predict Image",
        ),
      );
  }

  Future<String> saveFileAndGetPath() async{

  final imageName = "RawImage_${DateTime.now()}.jpg";
  final path = join((await getApplicationDocumentsDirectory()).path, "$imageName");
  await _cameraController.takePicture(path);
  return path;

}

Future runModel(String imgFile) async{

  //load model and handle error, no explicit error handler inside then, not used try/catch
  await Tflite.loadModel(model: 'model/mnist.tflite', labels: 'model/labels.txt').then((onValue){
    print("Model loaded successfully");
  }).catchError((onError){
    print("Error, Could not load model");
  });

  var imageBytes = io.File(imgFile).readAsBytesSync().buffer;

  ImageProcess.Image oriImage = ImageProcess.decodeJpg(imageBytes.asUint8List());
  ImageProcess.Image resizedImage = ImageProcess.copyResize(oriImage, height: 28, width: 28);

  //create 28x28 empty array (784 length = 784*4 = 3136 Bytes)
  var opsArray = Float32List(28*28);
  //almost everyone has created a buffer VIEW, but we can work without it as well, so skipping that.
  var buffer = Float32List.view(opsArray.buffer);
  //Loop through each pixel in resizedImage and get average and divide by 255
  int pixelIndex = 0;
  for(var x = 0; x < 28; x++){
    for(var y = 0; y < 28; y++){
      //get Pixel value from resizedImage
      var currentPixel = resizedImage.getPixel(x, y);
      //put values in opsArray by taking average of red. blue and green pixel values and then go to next pixel, since resizedImage is also 28x28
      buffer[pixelIndex++] = 
      (ImageProcess.getRed(currentPixel) + ImageProcess.getGreen(currentPixel) + ImageProcess.getBlue(currentPixel)) / 3 / 255.0;
    }
  }

  //convert opsArray to Uint8List, this can be used to run in the tflite model
  var x = buffer.buffer.asUint8List();

  List result = await Tflite.runModelOnBinary(binary: x);
            
  print(result);

  Tflite.close();

}

/*Future classifyImage(String imgFile) async {

  await Tflite.loadModel(model: 'model/mnist.tflite', labels: 'model/labels.txt');

  var imageBytes = io.File(imgFile).readAsBytesSync().buffer;

  ImageProcess.Image oriImage = ImageProcess.decodeJpg(imageBytes.asUint8List());
  ImageProcess.Image resizedImage = ImageProcess.copyResize(oriImage, height: 28, width: 28);

  var convertedBytes = Float32List(28 * 28);
  var buffer = Float32List.view(convertedBytes.buffer);
  int pixelIndex = 0;
  for (var i = 0; i < 28; i++) {
    for (var j = 0; j < 28; j++) {
      var pixel = resizedImage.getPixel(i, j);
      buffer[pixelIndex++] =
          (ImageProcess.getRed(pixel) + ImageProcess.getGreen(pixel) + ImageProcess.getBlue(pixel)) / 3 / 255.0;
    }
  }

  var x = convertedBytes.buffer.asUint8List();

  List recognitions = await Tflite.runModelOnBinary(binary: x);

  print(recognitions);

  Tflite.close(); 
}*/



}

