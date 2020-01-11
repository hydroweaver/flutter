import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' as io;


void main() async{

  runApp(MyApp());

}

class MyApp extends StatefulWidget{
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  Map<PermissionGroup, PermissionStatus> permissions;

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  void getPermission() async {
    permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]).then((_){
      //var pic = io.File("/storage/emulated/0/Download/").openRead();
      print("Permissions Granted");
      print(permissions.values);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Permissions App"),
        ),
      ),
    );
  }
}