import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(){
  runApp(MaterialApp(
    home: App(),
  ));
}

class EmptyDragWidget extends StatelessWidget{
  
  Widget _widget(){
    return Card(
      color: Colors.grey[300],
    );
  }

  @override
  Widget build(BuildContext context){
    return _widget();
  }
}

class CustomWidget extends StatelessWidget{
  String WidgetString;
  CustomWidget(this.WidgetString);

  Widget _widget(){
    return Card(
      child: Text(
        WidgetString,
        style: TextStyle(
          fontSize: 22.0,
        ),
        ),
    );
  }

  @override
  Widget build(BuildContext context){
    return _widget();
  }
}

class App extends StatefulWidget{
    @override
    AppState createState() => AppState();
}

class AppState extends State<App>{

  Widget grabbedItem;
  Widget grabbable = CustomWidget("Drag This");

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Drag App"),
      ),
      body: Column(
        children: <Widget>[
          Draggable<Widget>(
            data: grabbable,
            child: grabbable,
            feedback: grabbable,
            childWhenDragging: EmptyDragWidget(),
            onDragCompleted: (){
              if(mounted){
                setState(() {
                  grabbable = EmptyDragWidget();
                });
              }
            },
            ),
          DragTarget(
            builder: (BuildContext context, List<Widget> candidateData, List rejectedData){
              return Container(
                width: 150,
                height: 150,
                color: Colors.purple,
                padding: EdgeInsets.all(20.0),
                child: grabbedItem,
              );
            },
            onWillAccept: (Widget data){
              if(data.runtimeType == CustomWidget){
                Fluttertoast.showToast(
                  msg: "Accepted"
                );
                return true;
              }
              else{
                Fluttertoast.showToast(
                  msg: "Rejected"
                );
                return false;
              }
            },
            onAccept: (Widget data){
              setState(() {
                grabbedItem = data;
              });
              Fluttertoast.showToast(
                msg: "Dropped"
              );
            },
            onLeave: (Widget data){
              Fluttertoast.showToast(
                msg: "Not Dropped"
              );
            },
          )
        ],
      ),
    );
  }
}