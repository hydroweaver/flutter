import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
      title: 'Test App for Crap',
      home: ListApp(),
    )
  );
}



class ListApp extends StatefulWidget{
  @override
  _ListAppState createState() => _ListAppState();
}

class _ListAppState extends State<ListApp>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Column(
        verticalDirection: VerticalDirection.up,
        children: <Widget>[
          Text("1"),
          Text("2"),
          Text("3")
        ],
      ),
    );
  }
}