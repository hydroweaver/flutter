import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(){
  runApp(MaterialApp(
    title: "draggable",
    home: App(),
  ));
}

class CustomWidget extends StatelessWidget{
  final String CustomWidgetString;

  CustomWidget(this.CustomWidgetString);

  Widget _widget(){
    return Card(
      child: Text(CustomWidgetString, style: TextStyle(fontSize: 22.0),textAlign: TextAlign.center,),
      margin: EdgeInsets.all(10.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _widget();
  }
}

class App extends StatelessWidget{

  final List<String> k = ["karan", "Kunal", "James"];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Drag it"),
      ),
      body: ListView.builder(
        itemCount: k.length,
        itemBuilder: (context, itemCount){
          return Draggable(
            key: Key("$itemCount"),
            maxSimultaneousDrags: 1,
            dragAnchor: DragAnchor.pointer,
            child: CustomWidget(k[itemCount].toString()),
            feedback: CustomWidget(k[itemCount].toString()),
            childWhenDragging: Card(
              child: Text("", style: TextStyle(fontSize: 22.0),),
              margin: EdgeInsets.all(10.0),
            ),
            onDragStarted: (){
              Fluttertoast.showToast(
                msg: "Moved something"
              );
            },
          );
        },
      )
    );
  }
}

//IN A LISTBUILDER, ONLY ONE THING WOULD HAVE ON START ON END AS +1 AND -1...
// ONLY CREATE ONE CARD TO DRAG FROM TO