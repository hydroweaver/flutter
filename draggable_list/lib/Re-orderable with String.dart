import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Reorderable List View",
    home: App(),
  ));
}

class CustomWidget{
  String CustomWidgetString;
  bool checked;
  CustomWidget({this.CustomWidgetString, this.checked});
}

class App extends StatefulWidget{
  const App({Key key}) : super(key : key);
  @override 
  AppState createState(){
    return AppState();
  }
}

class AppState extends State<App>{

  List<CustomWidget> WidgetList = <CustomWidget>[
    CustomWidget(CustomWidgetString: "Task 1", checked: false),
    CustomWidget(CustomWidgetString: "Task 2", checked: true),
    CustomWidget(CustomWidgetString: "Task 3", checked: false),
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
                final CustomWidget replaceWidget = WidgetList.removeAt(oldIndex);
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