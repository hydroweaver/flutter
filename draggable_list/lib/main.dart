//https://stackoverflow.com/questions/58209066/flutter-listview-of-custom-widget-including-listview-gives-errors//

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

class CustomWidget{
  String CustomWidgetString;
  bool checked;
  CustomWidget({this.CustomWidgetString, this.checked});
}

class AppState extends State<App>{

  //List<String> WidgetList = ["Task", "Todo", "Task Todo"];
  //bool checkBoxValue = false;

  List<CustomWidget> WidgetList = [
    CustomWidget(CustomWidgetString: "Zonu", checked: false),
    CustomWidget(CustomWidgetString: "Sree", checked: true),
    CustomWidget(CustomWidgetString: "Kunal", checked: false),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Reorderable List"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(),
          Expanded(
            child: ReorderableListView(
              scrollDirection: Axis.vertical,
            children: <Widget>[
              for(final widget in WidgetList)
                ListTile(
                  key: Key("$widget"),
                  leading: Icon(Icons.menu),
                  title: Text(widget.CustomWidgetString),
                  trailing: Checkbox(
                    value: widget.checked,
                    onChanged: (val){
                      setState(() {
                        if(!val){
                          widget.checked = false;
                        }
                        else{
                          widget.checked = true;
                        }
                      });
                    },
                  ),
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
          )
          ],
        )
      );
    }
}
