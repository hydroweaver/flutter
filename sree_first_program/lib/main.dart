import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Sree(),
  ));
}

class Sree extends StatelessWidget{

  var sree_image = Image.asset('image/sree.jpg');

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Golu just wants to make programs!"),
      ),
      body: Center(
        child: Image(
          image: sree_image.image,
        ),
      ),
    );
  }
}