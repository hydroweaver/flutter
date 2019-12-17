import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "draggable",
    home: App(),
  ));
}

class App extends StatefulWidget{
  @override
  AppState createState() => AppState();
}

class AppState extends State<App>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Drag it"),
      ),
      body: Draggable(
        child: Card(
          child: Row(
            children: <Widget>[
              Icon(Icons.drag_handle),
              Text("Items1"),
              Checkbox(
                onChanged: null,
                value: false,
              )
            ],
          ),
        ),
        feedback: Card(
          child: Row(
            children: <Widget>[
              Icon(Icons.drag_handle),
              Text("Item1"),
              Checkbox(
                onChanged: null,
                value: false,
              )
            ],
          ),
        ),
        childWhenDragging: Text("I'm getting dragged"),
      ),
    );
  }
}