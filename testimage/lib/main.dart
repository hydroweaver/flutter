import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Image & Hero",
    routes: {
      '/' : (context) => testimage(),
      '/onclick' : (context) => testimage2()
    },
  ));
}

class testimage extends StatelessWidget{
  var img = Image.asset('images/flutter.png');
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Showing Imported Image"),
      ),
      body: Hero(
        child: Image(
          image: img.image,
        ),
        tag: "heroboi",
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.flight),
        onPressed: (){
          Navigator.pushNamed(context, '/onclick');
        },
      ),
    );
  }
}

class testimage2 extends StatelessWidget{
  var img = Image.asset('images/flutter.png');
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero screen transition"),
      ),
      body: ListTile(
        leading: Hero(
          child: Image(
            image: img.image,
          ),
          tag: "heroboi",
        ),
        onTap: (){
          Navigator.pop(context);
        },
      ),
    );
  }
}

