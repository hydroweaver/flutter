import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(){
  runApp(MaterialApp(
    title: "Add User Text to List",
    home: _MyCustomForm(),
  ));
}

class ListViewWidget extends StatelessWidget{
  
  ListViewWidget({this.listText});
  final String listText;
  
  @override
  Widget build(BuildContext context){
    return Text(listText);
  }
}

class _MyCustomForm extends StatefulWidget{
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

//LISTVIEW CHILDREN ARE STATELESS WIDGETS BEING CALLED FROM STATEFUL WIDGET - ALL OF THEM WOULD HAVE WORKED! I DIDNT USE THE 
//SETSTATE VARIABLE ! :|
class _MyCustomFormState extends State<_MyCustomForm>{
  final myController = TextEditingController();

  final List todoList = [];

  void addTodo(){
    setState(() {
      todoList.add(myController.text);
      Fluttertoast.showToast(
      msg: "${todoList[todoList.length-1]}"
      );
      myController.clear();
    });
  }

  @override
  void dispose(){
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
        return Scaffold(
      appBar: AppBar(
        title: Text("Write Something"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: myController,
            enabled: true,
            autofocus: true,
          ),
          RaisedButton(
            onPressed: addTodo,
            child: Text("Add Todo"),
            textColor: Colors.blue[300],
            elevation: 10,
          ),
          Expanded(
            child: ListView.builder(
            shrinkWrap: true,
            itemCount: todoList.length,
            itemBuilder: (context, index){
              final todo = todoList[index];
              return ListTile(
                title: ListViewWidget(listText: todo),
              );
            }
          ),
          )
        ],
      ),
    );
  }
}

//LISTVIEW WITHIN EXPANDED CHILD OF COLMN SINCE IT FILLS ALL THE SPACE
/*class _MyCustomFormState extends State<_MyCustomForm>{
  final myController = TextEditingController();

  final List todoList = [];

  void addTodo(){
    todoList.add(myController.text);
    Fluttertoast.showToast(
      msg: "${todoList[todoList.length-1]}"
    );
    myController.clear();
  }

  @override
  void dispose(){
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
        return Scaffold(
      appBar: AppBar(
        title: Text("Write Something"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: myController,
            enabled: true,
            autofocus: true,
          ),
          RaisedButton(
            onPressed: addTodo,
            child: Text("Add Todo"),
            textColor: Colors.blue[300],
            elevation: 10,
          ),
          Expanded(
            child: ListView.builder(
            shrinkWrap: true,
            itemCount: todoList.length,
            itemBuilder: (context, index){
              final todo = todoList[index];
              return ListTile(
                title: Text(todo),
              );
            }
          ),
          )
        ],
      ),
    );
  }
}*/

//LISTVIEW IN COL WITH SHRINKWRAP = TRUE
/*class _MyCustomFormState extends State<_MyCustomForm>{
  final myController = TextEditingController();

  final List todoList = [];

  void addTodo(){
    todoList.add(myController.text);
    Fluttertoast.showToast(
      msg: "${todoList[todoList.length-1]}"
    );
    myController.clear();
  }

  @override
  void dispose(){
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
        return Scaffold(
      appBar: AppBar(
        title: Text("Write Something"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: myController,
          ),
          RaisedButton(
            onPressed: addTodo,
            child: Text("Add Todo"),
            textColor: Colors.blue[300],
            elevation: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: todoList.length,
            itemBuilder: (context, index){
              final todo = todoList[index];
              return ListTile(
                title: Text(todo),
              );
            }
          )
        ],
      ),
    );
  }
}*/