import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "2 Ways of Showing the Snack Bar on Two Screen using Navigation :)",
    home: SnackBarTest(),
  ));
}

class SnackBarTest extends StatefulWidget{
  @override
  SnackBarTestState createState() => SnackBarTestState();
}

class SnackBarTestState extends State<SnackBarTest>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context){
          return ListTile(
            onTap: (){
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("hi"),
                backgroundColor: Colors.amber,
              ));
            },
          );
        },
      )
    );
  }
}