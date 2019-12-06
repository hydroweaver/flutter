//NAMED ROUTES
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Transition to Next Screen",
    initialRoute: '/',
    routes: {
      '/' : (context) => LandingPage(),
      '/second' : (context) => NavigateToPage()
    },
  ));
}

class LandingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Screen Transitions"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: (){
            Navigator.pushNamed(context, '/second');
          },
          child: Text("Navigate"),
        ),
      )
    );   
  }
}

class NavigateToPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 2"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text("Go Back"),
        ),
      ),
    );
  }
}


// DONE WITH NAVIGATOR PUSH AND POP, NO NAMED ROUTES....Navigator


/*import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Transition to Next Screen",
    home: LandingPage()
  ));
}

class LandingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Screen Transitions"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: (){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => NavigateToPage())
            );
          },
          child: Text("Navigate"),
        ),
      )
    );   
  }
}

class NavigateToPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 2"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text("Go Back"),
        ),
      ),
    );
  }
}*/

