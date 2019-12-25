import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Reorderable List View",
    home: App(),
  ));
}

List<String> items = ["Sree", "Lavu", "Karan", "Kunal"];

class _WidgetList{
  final String value;
  bool checkState;
  _WidgetList(this.value, this.checkState);
}

List<_WidgetList> WidgetListfromStrings = items.map<_WidgetList>((String value){
  return _WidgetList(value, false);
}).toList();

List<Widget> s = WidgetListfromStrings.map<Widget>(( _WidgetList value){
  return ListTile(
    key: Key("${value.value}"),
    title: Text(value.value),
  );
}).toList();

class App extends StatefulWidget{
  @override
  AppState createState(){
    return AppState();
  }
}

class AppState extends State<App>{


  void _onreoder(oldIndex, newIndex){
    setState(() {
      if(oldIndex < newIndex){
        newIndex -= 1;
      }
      final replaceWidget = WidgetListfromStrings.removeAt(oldIndex);
      WidgetListfromStrings.insert(newIndex, replaceWidget);
    });
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Re Orderable List"),
      ),
      body: ReorderableListView(
        children: <Widget>[
          for(final x in WidgetListfromStrings)
            CheckboxListTile(
              key: Key(x.value),
              value: x.checkState ?? false,
              title: Text(x.value),
              onChanged: (val){
                setState(() {
                  if(!val){
                    x.checkState = false;
                  }
                  else{
                    x.checkState = true;
                  }
                });
              },
            )
        ],
        onReorder: _onreoder,
      )
    );
  }
}