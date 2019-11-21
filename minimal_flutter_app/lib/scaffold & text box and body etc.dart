import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    home: TutorialHome(),
  ));
}

class TutorialHome extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Context Menu',
          onPressed: null,
        ),
        title: Text("Example Title"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: null,
            tooltip: 'Search',
          )
        ],
      ),

      body: Column(
        children: <Widget>[
          TextField(
            autocorrect: true,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
        tooltip: 'Add Note',
      ),
    );
  }
}