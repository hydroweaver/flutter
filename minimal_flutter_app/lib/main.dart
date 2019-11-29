import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(){
  runApp(MaterialApp(
    title: "Simple ToDo",
    home: TodoListApp(),
  ));
}

class ListTodo{
  String todoText;
  bool todoToggle;
  ListTodo(this.todoText, this.todoToggle);
}

/*class todoWidget extends StatelessWidget{

}*/

class TodoListApp extends StatefulWidget{
  @override
  _TodoListAppState createState() => _TodoListAppState();
}

class _TodoListAppState extends State<TodoListApp>{
  
  List<ListTodo> todoList = new List<ListTodo>();
  //List<ListTodo> todoList = [];
  //final todoList = [];
  final myTextController = TextEditingController();

  @override
  void dispose(){
    myTextController.dispose();
    super.dispose();
  }

  //using this instead of anon function inside gesture detector
  @override
  void changeToggle(){

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todos"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: myTextController,
          ),
          RaisedButton(
            onPressed: (){setState(() {
              todoList.add(new ListTodo(myTextController.text, false));
              myTextController.clear();
            });
            },
            child: Text(
              "Add Todo",
              style: TextStyle(color: Colors.blue[500], fontSize: 16.0,),
              ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        todoList[index].todoText,
                        style: TextStyle(fontSize: 22.0, color: Colors.blue[500])
                        ),
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      if(todoList[index].todoToggle == false){
                        todoList[index].todoToggle = true;
                        Fluttertoast.showToast(
                          msg: "Toggle for ${todoList[index].todoText} set to ${todoList[index].todoToggle}"
                        );
                      }
                      else{
                        todoList[index].todoToggle = false;
                        Fluttertoast.showToast(
                          msg: "Toggle for ${todoList[index].todoText} set to ${todoList[index].todoToggle}"
                        );
                      }
                    });
                  },
                );
              },
            ),
          )
        ],
      )
    );
  }
}