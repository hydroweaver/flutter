import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: AppState(),
));

class AppState extends StatelessWidget{

  final bool dismiss = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing Swipe for Action"),
      ),
      body: Dismissible(
        child: CheckboxListTile(
          onChanged: (bool){},
          value: false,
          checkColor: Colors.green,
          title: Text("Dismissible"),
        ),
        key: Key("Key"),
        confirmDismiss: (dismisscheck){
          print(dismisscheck);
          if(dismisscheck == DismissDirection.endToStart){
            print("I will delete this");
          }
        },
        movementDuration: const Duration(milliseconds: 1000),
        direction: DismissDirection.endToStart,
        onDismissed: (x){},
        background: Container(
          color: Colors.red[300],
        ),
      ),
    );
  }
}