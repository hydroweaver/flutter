import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Test Icon Button & snackbar",
    home: IconApp(),
  ));
}

class IconApp extends StatefulWidget{
  @override
  IconAppState createState() => IconAppState();
}

class IconAppState extends State<IconApp>{
  List testVals = ["Karan", "Sree"];
  bool pressed = false;

  Icon _icon(pressed){
    if(!pressed){
      return Icon(
        Icons.headset,
        color: Colors.green[200],
      );
    }
    else{
      return Icon(
        Icons.headset_off,
        color: Colors.red[200],
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.blur_on,
          color: Colors.amber,
          ),
        title: Text("Test App"),
      ),
      body: Center(
        child: IconButton(
          icon: _icon(pressed),
          onPressed: (){
            setState(() {
              if(!pressed){
                pressed = true;
                }
            else{
              pressed = false;
            }
            });
          },
          iconSize: 96.0,
        ),
      ),
    );
  }

}