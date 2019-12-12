import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Pill Selector Menu",
    home: PillSelector(),
  ));
}

class PillSelector extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text("Pill Selector Test"),
        actions: <Widget>[
          Icon(Icons.search)
        ],
      ),
      body: PillSelector(
      ),
    );
  }
}