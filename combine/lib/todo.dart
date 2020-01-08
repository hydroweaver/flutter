import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/*void main(){
  runApp(MaterialApp(
    title: "Todo App with Re-orderable Lists & Swipe Cards",
    home: App(),
  ));
}*/

class ListItem{
  String todoText;
  bool todoCheck;
  ListItem(this.todoText, this.todoCheck); 
}

class _strikeThrough extends StatelessWidget{

  final String todoText;
  final bool todoCheck;
  _strikeThrough(this.todoText, this.todoCheck) : super();

  Widget _widget(){
    if(todoCheck){
      return Text(
        todoText,
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
          fontStyle: FontStyle.italic,
          fontSize: 22.0,
          color: Colors.red[200],
        ),
      );
    }
    else{
      return Text(
        todoText,
        style: TextStyle(
          fontSize: 22.0
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return _widget();
  }
}

class App extends StatefulWidget{

  @override
  AppState createState(){
    return AppState();
  }
}

class AppState extends State<App>{

  var counter = 0;

  var textController = TextEditingController();
  var popUpTextController = TextEditingController();

  List<ListItem> WidgetList = [];

  /*void _saveData() async{
    //print("Data would be synched at this point");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("widget length", WidgetList.length);
    print(prefs.getInt("widget length"));
  }*/ //Initial Implementation where only the list length is saved.


  void _saveData() async{
    //print("Data would be synched at this point");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("last widget", WidgetList[WidgetList.length - 1].todoText);
    print(prefs.getString("last widget"));
  } //Initial Implementation where only the list length is saved.

  //Implementation of writing whole list every time to memory instead of changing prefs - expensive but lets keep it simple

  /*void _saveData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    //Create a string list from Widget List
    

  }*/

  @override
  void dispose(){
    textController.dispose();
    popUpTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Todo List"),
        //backgroundColor: Colors.orange[500],
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter Todo Text Here"
              ),
              style: TextStyle(
                fontSize: 22.0,
                //color: Theme.of(context).accentColor,
              ),
              controller: textController,
              cursorWidth: 5.0,
              autocorrect: true,
              autofocus: true,
              //onSubmitted: ,
            ),
          ),
          RaisedButton(
            child: Text("Add Todo"),
            onPressed: (){
              if(textController.text.isNotEmpty){
                WidgetList.add(new ListItem(textController.text, false));
                _saveData();//SAVE DATA
                setState(() {
                  textController.clear();
                });
              }
            },
          ),
          Expanded(
            child: ReorderableListView(
              children: <Widget>[
                for(final widget in WidgetList)        
                  GestureDetector(
                  key: Key(widget.todoText),
                  child: Dismissible(
                    key: Key(widget.todoText),
                    child: CheckboxListTile(
                      //key: ValueKey("Checkboxtile $widget"),
                      value: widget.todoCheck,
                      title: _strikeThrough(widget.todoText, widget.todoCheck),
                      onChanged: (checkValue){
                        //_strikethrough toggle
                        setState(() {
                          if(!checkValue){
                            widget.todoCheck = false;
                            _saveData();//SAVE DATA
                          }
                          else{
                            widget.todoCheck = true;
                            _saveData();//SAVE DATA
                          }
                        });
                      },
                    ),
                    background: Container(
                      child: Icon(Icons.delete),
                      alignment: Alignment.centerRight,
                      color: Colors.orange[300],
                      ),
                    confirmDismiss: (dismissDirection){
                      return showDialog(//On Dismissing
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Delete Todo?"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("OK"),
                                onPressed: (){
                                  Navigator.of(context).pop(true);
                                },
                              ),//OK Button
                              FlatButton(
                                child: Text("Cancel"),
                                onPressed: (){
                                  Navigator.of(context).pop(false);
                                },
                              ),//Cancel Button
                            ],
                          );
                        }
                      );
                    },
                    direction: DismissDirection.endToStart,
                    movementDuration: const Duration(milliseconds: 200),
                    onDismissed: (dismissDirection){//Delete Todo
                        WidgetList.remove(widget);
                        _saveData();//SAVE DATA
                      Fluttertoast.showToast(
                        msg: "Todo Deleted!"
                      );
                    },
                    ),
            onDoubleTap: (){
              popUpTextController.text = widget.todoText;
              //For Editing Todo
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Edit Todo"),
                    content: TextFormField(
                      controller: popUpTextController,
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("OK"),
                        onPressed: (){
                          setState(() {
                            widget.todoText = popUpTextController.text;
                            _saveData();//SAVE DATA
                          });
                          Navigator.of(context).pop(true);
                        },
                      ),//OK Button
                      FlatButton(
                        child: Text("Cancel"),
                        onPressed: (){
                          Navigator.of(context).pop(false);
                        },
                      ),//Cancel Button
                    ],
                  );
                }
              );
            },
          )
      ],
      onReorder: (oldIndex, newIndex){
        setState(() {
          if(oldIndex < newIndex){
            newIndex -= 1;
            }
          var replaceWiget = WidgetList.removeAt(oldIndex);
          WidgetList.insert(newIndex, replaceWiget);
          _saveData();//SAVE DATA
          });
      },
    ),
  )
],
),
);
}
}