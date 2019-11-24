import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:fluttertoast/fluttertoast.dart';

void main(){
  runApp(MaterialApp(
      title: 'Test App for Crap',
      home: ListApp(),
    )
  );
}

class TextWidget extends StatelessWidget{
  
  final String text;
  final bool strike;

  TextWidget({this.text, this.strike});

  Widget _TextStyle(){
    if(!strike){
      return Text(
        text,
        style: TextStyle(
          color: Colors.green[500],
          decoration: TextDecoration.lineThrough,
          fontSize: 25,
        ),
      );
    }
    else{
      return Text(
        text,
        style: TextStyle(
          color: Colors.green[500],
          fontSize: 25,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return new Container(child: _TextStyle());
  }
}

class ListApp extends StatefulWidget{
  @override
  _ListAppState createState() => _ListAppState();
}

class _ListAppState extends State<ListApp>{

  int ctr = 0;
  bool strike = false;

  void _Counter(){
    setState(() {
      ctr += 1;
    });
  }

  bool _StrikeThroughAll(){
    if(!strike){
      strike = false;
      return strike;
    }
    else{
      strike = true;
      return strike;
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Statelful Calling Stateless Widgets"),
      ),
      body: Column(
        children: <Widget>[
          TextWidget(text: 'Value of this Widget is $ctr', strike: strike,),
          TextWidget(text: 'Value of this Widget is ${ctr+1}', strike: strike,),
          RaisedButton(
            onPressed: _Counter,
            child: Text("Increment"),
            textColor: Colors.green[500],
            elevation: 10,
          ),
          RaisedButton(
            onPressed: _StrikeThroughAll,
            child: Text("Strike Toggle"),
            textColor: Colors.green[500],
            elevation: 10,
          ),
        ],
      ),
    );
  }
}