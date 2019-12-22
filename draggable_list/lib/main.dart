import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Reorderable List View",
    home: App(),
  ));
}

class App extends StatefulWidget{
  @override
  AppState createState(){
    return AppState();
  }
}

class CustomWidget extends StatelessWidget{

  String CustomWidgetString;
  String _key;
  CustomWidget(this.CustomWidgetString, this._key);

  Widget _widget(){
    return Card(
      key: Key(_key),
      child: Text(CustomWidgetString),
    );
  }
  @override
  Widget build(BuildContext context){
    return _widget();
  }

}

class AppState extends State<App>{
  //final List<CustomWidget> items = [, ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Reorderable List"),
      ),
      body: ReorderableListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          //CustomWidget("Chimp", "value1"),
          //CustomWidget("dodo", "value2")
          Card(
            child: Text("data1"),
            key: Key("value1"),
          ),
          Card(
            child: Text("data2"),
            key: Key("value2"),
          )
        ],
        onReorder: (a, b){
          var swap;
          swap = a;
          a = b;
          b = swap;
        },
      ),
    );
  }
}