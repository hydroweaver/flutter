import 'dart:convert';
import 'dart:ffi';

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

  var source_path = 'images/GatewayBridge800.jpg';
  var img = Image.asset('images/GatewayBridge800.jpg');
  var save_path = '/storage/emulated/0/Download';
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
          Padding(
            padding: const EdgeInsets.all(16.0),
          ),
          Image(
            key: Key("cached"),
            image: ResizeImage(
              img.image,
              height: 28,
              width: 28,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
          ),
          RaisedButton(
            child: Text("Save Image"),
            onPressed: () async {
              var file = await DefaultCacheManager().getFilePath();
              print(file);
              var x = Image.file(io.File(source_path));
              var y = ResizeImage(x.image, height: 28,  width: 28);
              print(x.runtimeType);
              print(y.runtimeType);
              print(await getTemporaryDirectory());
              var dir = '/data/user/0/com.example.import_and_resize_image/cache/libCachedImageData/';
              var z = io.Directory(dir).listSync();
              print(z);
            }
          ),
        ],
      )
    );
  }
}