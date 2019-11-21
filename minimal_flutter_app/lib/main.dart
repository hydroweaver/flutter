import 'package:flutter/material.dart';

void main(){
  runApp(MyScaffold());
}

/* for explanation - 

1. The following 2 programs will have the same output:

import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Center(
      child : Text(
        "data",
        textDirection: TextDirection.ltr,
        )
    );
  }
}

----------------------------------------------------Versus----------------------------------------------------------------------------

import 'package:flutter/material.dart';

void main(){
  runApp(
    Center(
      child : Text(
      "data",
      textDirection: TextDirection.ltr,
    );
  );
}

2. All widget build should have a return function, like return scaffold or return container etc. Otherwise it's KAPOOT! By the way,
the error message on the emulator is very helpful.

3. THink of it this way : Widget has child, child can have children, and so on recursively.

*/


class MyAppBar extends StatelessWidget{
  MyAppBar({this.title});

  final Widget title;

  @override
  Widget build(BuildContext context){
    return Container(
      height: 56.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation Menu',
            onPressed: null,
          ),
          Expanded(
            child: title,
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          )
        ],
      )
    );
  }
}

class MyScaffold extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("data",
          textDirection: TextDirection.ltr,
          )
        ],
      ),
    );
  }
}


