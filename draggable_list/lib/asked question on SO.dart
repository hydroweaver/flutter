/*https://stackoverflow.com/questions/58209066/flutter-listview-of-custom-widget-including-listview-gives-errors//

import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Reorderable List View",
    home: App(),
  ));
}

class App extends StatefulWidget{
  @override
  AppState createState(){
    return AppState();
  }
}

class CustomWidget extends StatelessWidget{

  String CustomWidgetString;
  String WidgetKey;
  
  CustomWidget({this.CustomWidgetString, this.WidgetKey});

  Widget _widget(){
    return Text(
      CustomWidgetString,
      key: Key(WidgetKey),
    );
  }

  @override
  Widget build(BuildContext context){
    return _widget();
  }
}

class AppState extends State<App>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Reorderable List"),
      ),
      body: ReorderableListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          CustomWidget(
            CustomWidgetString: "Custom Widget",
            WidgetKey: "value",
          )
        ],
        onReorder: (a, b){
        },
      ),
    );
  }
}

*/