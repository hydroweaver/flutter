import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/strike%20and%20toggle%20with%20stateful.dart';

void main(){
  runApp(MaterialApp(
    title: "Infinite Scrollable List",
    home: InfiniteList(),
  ));
}

class InfiniteList extends StatelessWidget{
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("This is an infinite list"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
          if(index % 2 == 0){
            return ListTile(
              title: Text(
                //index.toString(),
                "She Loves Me",
                style: TextStyle(color: Colors.blue[300]),
                ),
            );
          }
          else{
            return ListTile(
              title: Text(
                //"Odd $index",
                "She Loves Me Not",
                style: TextStyle(color: Colors.green[500]),
              ),
            );
          }
        }
      ),
    );
  }
}