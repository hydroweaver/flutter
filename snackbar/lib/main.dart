import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "2 Ways of Showing the Snack Bar on Two Screen using Navigation :)",
    initialRoute: '/',
    routes: {
      '/' : (context) => SnackBarTest1(),
      '/next' : (context) => SnackBarTest2()
    },
  ));
}

class SnackBarTest1 extends StatefulWidget{
  @override
  SnackBarTestState1 createState() => SnackBarTestState1();
}

class SnackBarTestState1 extends State<SnackBarTest1>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Snackbar with builder"),
      ),
      body: Builder(
        builder: (BuildContext context){
          return ListTile(
            title: Text("Tap Me"),
            subtitle: Text("Press Book Icon to go to next Page"),
            leading: Icon(Icons.blur_circular),
            onTap: (){
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("SnackBar 1"),
                backgroundColor: Colors.amber,
              ));
            },
            trailing: IconButton(
              icon: Icon(Icons.book),
              onPressed: (){
                Navigator.pushNamed(context, '/next');
              },
            ),
          );
        },
      ),
    );
  }
}

class SnackBarTest2Widget extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ListTile(
      title: Text("Tap Me"),
      subtitle: Text("Press Book icon to go to previous page"),
      leading: Icon(Icons.blur_linear),
      onTap: (){
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("SnackBar 2"),
          backgroundColor: Colors.lightGreen,
        ));
      },
      trailing: IconButton(
        icon: Icon(Icons.cloud),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
    );
  }
}

class SnackBarTest2 extends StatefulWidget{
  @override
  SnackBarTestState2 createState() => SnackBarTestState2();
}

class SnackBarTestState2 extends State<SnackBarTest2>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Snackbar with stateless widget"),
      ),
      body: SnackBarTest2Widget(),
    );
  }

}