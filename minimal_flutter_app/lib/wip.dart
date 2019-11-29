/*import 'package:flutter/material.dart';
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
            itemCount: todoList.length,
            itemBuilder: (context, index){
              final todo = todoList[index];
              return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        todo,
                        style: TextStyle(color: Colors.green[500], fontSize: 22.0),
                      ),
                    ),
                    color: Colors.blue[100],
              );
            }
          ),
          )
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////


/*import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(){
  runApp(MaterialApp(
    title: "Add User Text to List",
    home: _MyCustomForm(),
  ));
}

//put gesture builder in list item, every list item would be gesture builder and todo note

class _MyCustomForm extends StatefulWidget{
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

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
    return GestureDetector(
      onTap: (){
        Fluttertoast.showToast(
          msg: "Card was pressed",
        );
      },
    );
}
}*/

*/