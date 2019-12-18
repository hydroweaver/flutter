import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "draggable",
    home: App(),
  ));
}

class CustomWidget extends StatelessWidget{
  String CustomWidgetString;

  CustomWidget(this.CustomWidgetString);

  Widget _widget(){
    return Card(
      child: Text(CustomWidgetString, style: TextStyle(fontSize: 22.0),),
      margin: EdgeInsets.all(10.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _widget();
  }
}

class App extends StatelessWidget{

  List<String> k = ["karan", "Kunal", "James"];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Drag it"),
      ),
      body: ListView(
        children: <Widget>[
          Draggable(
            child: CustomWidget(k[0]),
            feedback: CustomWidget(k[0]),
            childWhenDragging: Card(),
          ),
          Draggable(
            child: CustomWidget(k[1]),
            feedback: CustomWidget(k[1]),
            childWhenDragging: Card(),
          ),
        ],
      )
    );
  }
}

//IN A LISTBUILDER, ONLY ONE THING WOULD HAVE ON START ON END AS +1 AND -1...