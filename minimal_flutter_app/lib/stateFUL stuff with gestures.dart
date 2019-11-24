import 'package:flutter/material.dart';


// STATEFUL WIDGET - WITH GESTURE DETECTOR

/*void main(){
  runApp(MaterialApp(
    title: 'Increment',
    home: Counter(),
  ));
}

class Counter extends StatefulWidget{  
  @override
  _CounterState createState() => _CounterState();

}

class _CounterState extends State<Counter>{
  int _ctr = 0;
  
  void _increment(){
    setState(() {
      _ctr += 1;

    });
  }

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: _increment,
      child: FloatingActionButton(
              onPressed: _increment,
              child: Icon(Icons.add),
            ),
    );
  }
}*/


//STATEFUL WIDGET - REGULAR INCREMENT BUTTON

/*class Counter extends StatefulWidget{  
  @override
  _CounterState createState() => _CounterState();

}

class _CounterState extends State<Counter>{
  int _ctr = 0;
  
  void _increment(){
    setState(() {
      _ctr += 1;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Increment a Value"),
      ),
      body: Center(
            child: Text(
              _ctr.toString(),
              ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        child: Icon(Icons.add),
      ),
    );
  }
}

//stateless counter which is not updated on the screen using gesture detector

/*void main(){
  runApp(GestureApp());
}

class GestureApp extends StatelessWidget{

  int ctr = 0;

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        Fluttertoast.showToast(
          msg: "Somthing was pressed",
        );
        ctr += 1;
      },
      child: Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500]
        ),
        child: Center(
          child: Text(
            'Count: $ctr',
            textDirection: TextDirection.ltr,
            ),
        ),
      ),
    );
  }
}*/

*/