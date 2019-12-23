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

class AppState extends State<App>{

  List<String> WidgetList = ["Karan", "Sree", "Zonu"];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Reorderable List"),
      ),
      body: ReorderableListView(
        scrollDirection: Axis.vertical,
        children: [
          for(final widgets in WidgetList)
            ListTile(
              title: Text(widgets.toString()),
              key: ValueKey("$widgets"),
            )
        ],
        onReorder: (oldIndex, newIndex){
          setState(() {
            if(oldIndex < newIndex){
              newIndex -= 1;
            }
          var replaceWidget = WidgetList.removeAt(oldIndex);
          WidgetList.insert(newIndex, replaceWidget);
          });
        },
      ),
    );
  }
}