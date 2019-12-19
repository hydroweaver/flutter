import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: App(),
  ));
}

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Drag Simple"),
      ),
      body: Positioned(
        child: Card(
          child: Text("data"),
        ),
        top: 10,
        bottom: 10,
        left: 10,
        right: 10,
        height: 5,
        width: 5,
      ),
    );
  }
}