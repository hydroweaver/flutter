import 'dart:convert' as conv;
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as ImageProcess;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


void main(){
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget{
  @override
  MyAppState createState(){
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{

  var asset_path = 'images/GatewayBridge800.jpg';
  var save_from_path = '/data/user/0/com.example.import_and_resize_image/cache/';
  var save_to_path = '/storage/emulated/0/Download';

  var img = Image.asset('images/GatewayBridge800.jpg');
  var showImg = Image.asset('images/avatar.jpg');
  var compressedPlaceholder = Image.asset('images/avatar.jpg');

  Map<PermissionGroup, PermissionStatus> permissions;
  ImageCache cache;

  @override
  void initState(){
    super.initState();
    getPermission();
  }

  void getPermission() async{
    permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resize Image on Tap"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: img.image, 
          ),
          Image(
            key: Key("cached"),
            //Display image read in Onpressed Definition
            image: showImg.image
          ),
          Image(
            image: compressedPlaceholder.image,
          ),
          RaisedButton(
            child: Text("Save Image"),
            onPressed: () async {

            //CASE 1 : GET IMAGE FROM ASSET AND SAVE IT IN FILE AND DISPLAY IT/////////////////////////////////////////

            //Only get temp path from path_provider plugin and put file there, instead of directly giving path or using none
            var tempDir = await getTemporaryDirectory();

            //create a jpg file in the temp dir
            var imageFilePath = join(tempDir.path, 'image.jpg');
            var imageFile = new io.File(imageFilePath);

            //Get Byte Data from asset
            var imageContents = await rootBundle.load(asset_path);

            //convert ImageContents Byte Data to Unit 8 Byte data list stream whatever, so it can be written to image.jpg
            var convertedImageContents = imageContents.buffer.asUint8List();
            print(convertedImageContents);

            //Write this buffer to image.jpg
            await imageFile.writeAsBytes(convertedImageContents);
            
            //Print this on UI by referring freshly written image.png in Widget Tree
            showImg = Image.memory(convertedImageContents);
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            //CASE 2 : WRITE STRING VALUE TO FILE CODE BELOW TILL ------ WORKS LIKE A CHARM !//////////////////////
            /*var filePath = join(tempDir.path, 'karan.txt'); // files are made in the cache folder.
            var file = new io.File(filePath);
            var contents = 'Writing Something to File is such a nuisance!';
            
            await file.writeAsString((contents)).then((_){
              print("Done Writing");
            });
            
            await file.readAsString().then((contents){
              print(contents);
            });

            var x = await  tempDir.list().toList(); //THis has to be converted to a list! Why did I not think of that.

            //The stream has to be converted to a list and then looped through.

            for(var value in x)
              print(value);
            ---------------------------------------------------------
              */
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            // CASE 3 : RESIZE IMAGE, PASS IT TO IMAGE WIDGET TO DISPLAY, SAVE RESIZED in a file.

            /////make a variable that can hold resized image
            var resizedImage = ResizeImage(img.image, height: 28, width: 28);
            compressedPlaceholder = Image(image: resizedImage);

            //convert compressedPlaceholder to bytedata which can be converted to byte List
            Uint8List bytes;

            var codec = await ui.instantiateImageCodec(bytes);
            var frame = await codec.getNextFrame();
            var x = frame.image;

            ui.Image i;
            
            var i2 = i.toByteData();
            i2.whenComplete(action)

            

            //create a file for saving this resized image.
            var resizedImageFilePath = join((await getTemporaryDirectory()).path, 'resizedImage.jpg');
            var resizedImageFile = io.File(resizedImageFilePath);
                 
            setState(() {
              
            });            

            }
          ),
        ],
      )
    );
  }
}