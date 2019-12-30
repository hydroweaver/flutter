import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: AppState(),
));

class AppState extends StatelessWidget{

  final bool dismiss = false;
  final double _threshold = 0.4;
  String cardText;
  var textEditController = TextEditingController();
  String initText = "Dismissible";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing Swipe for Action"),
      ),
      body: GestureDetector(
        child: Dismissible(
          child: CheckboxListTile(
            onChanged: (bool){},
            value: false,
            checkColor: Colors.green,
            title: Text(initText),
            ),
          key: Key("Key"),
          dismissThresholds: {
            DismissDirection.endToStart: _threshold
            },
          confirmDismiss: (dismisscheck) {
            return showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text("Delete Todo?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        },
                      ),
                    FlatButton(
                      child: Text("Cancel"),
                      onPressed: (){
                        Navigator.of(context).pop(false);
                        },
                      )
                  ],
                  );
                }
              );
            },
          movementDuration: const Duration(milliseconds: 200),
          direction: DismissDirection.endToStart,
          onDismissed: (dismissed){
            print("Card has been dismissed, this is where you remove it from the list as well");
            },
          background: Container(
            color: Colors.red[300],
            ),
          ),
        onLongPress: (){
          showDialog(
            context: context,
            builder: (BuildContext context){
              textEditController.text = initText;
              return AlertDialog(
                content: TextFormField(
                  controller: textEditController,
                  //initialValue: initText.toString(),
                ),
                title: Text("Edit Todo"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: (){
                      var new_text = textEditController.text;
                      print(new_text);
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            }
          );
        },
      )
    );
  }
}