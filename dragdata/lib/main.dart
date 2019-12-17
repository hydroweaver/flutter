import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "draggable",
    home: App(),
  ));
}

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Drag it"),
      ),
      body: Column(
        children: <Widget>[
          Draggable(
            child: Text("Drag this text"),
            feedback: Text("pipipipip"),
          ),
        ],
      )
    );
  }
}