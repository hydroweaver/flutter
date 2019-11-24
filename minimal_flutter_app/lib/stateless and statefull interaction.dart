/*import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: 'Stateless & Stateful Widgets Interaction Detail',
    home: Counter(),
  ));
}

class CounterText extends StatelessWidget{
  CounterText({this.count});

  final int count;

  @override
  Widget build(BuildContext context){
    return Text('Value is $count');
  }
}

class CounterIncrement extends StatelessWidget{
  CounterIncrement({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context){
    return RaisedButton(
      onPressed: onPressed,
      child: Text("Increment"),
    );
  }
}

class Counter extends StatefulWidget{
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter>{
  
  int ctr = 0;

  void _increment(){
    setState(() {
      ctr +=1 ;
    });
  }

  @override
  Widget build(BuildContext context){
    return Row(
      children: <Widget>[
        CounterIncrement(onPressed: _increment),
        CounterText(count: ctr,)
      ],
    );
  }
}*/