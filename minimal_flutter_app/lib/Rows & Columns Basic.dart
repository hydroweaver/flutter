import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: 'My App',
    home: MyScaffold(),
  ));
}

class MyAppBar extends StatelessWidget{
  MyAppBar({this.title});

  final Widget title;

  @override
  Widget build(BuildContext context){
    return Container(
      height: 100.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(color: Colors.purple[300]),
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
          Expanded(
            child: Text(
              "data",
              textAlign: TextAlign.center,
              ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.traffic),
            tooltip: 'This is another Icon',
            onPressed: null,
          ),
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
          MyAppBar(
            title: Text(
              'Example Title',
              textAlign: TextAlign.center,
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "HELLO",
                  softWrap: true,
                  ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  "Hello to you too!"
                ),
              ),
            )
        ],
      ),
    );
  }
}