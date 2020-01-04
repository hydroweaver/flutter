import 'package:combine/todo.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Master App",
    routes: {
      '/' : (context) => Master(),
      '/todo' : (context) => App()
    },
  ));
}

class Master extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Gallery"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.amber,
              child: Icon(Icons.note_add),
              onPressed: (){
                Navigator.pushNamed(context, '/todo');
              },
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            Text("Todo App")
          ],
        ),
      ),
    );
  }
}

