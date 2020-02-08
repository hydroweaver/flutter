import 'package:torch/torch.dart';
import 'package:flutter/material.dart';

bool torchStatus = false;

void main(){
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Torch"),
      ),
      body: RaisedButton(
        child: Text("Press"),
        onPressed: ()async{
          if(!torchStatus){
            torchStatus = true;
            await Torch.turnOn();
          }
          else{
            torchStatus = false;
            await Torch.turnOff();
          }
          
        },
      ),
    );
  }
}