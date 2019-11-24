import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(){
  runApp(MaterialApp(
    title: "Add User Text to List",
    home: UserText(),
  ));
}

class UserText extends StatelessWidget{

  List todoList = [];

  void addTodo(){
    todoList.add("Length of the list is ${todoList.length}");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write Something"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            onTap: (){
              Fluttertoast.showToast(
                msg: "you're typing something!"
              );
            },
          ),
          RaisedButton(
            onPressed: addTodo,
            child: Text("Add Todo"),
            textColor: Colors.blue[300],
            elevation: 10,
          ),
          ListView(
            children: <Widget>[],
          )
        ],
      ),
    );
  }
}