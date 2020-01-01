/*import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Reorderable List View",
    home: App(),
  ));
}



class _WidgetList{
  final String value;
  bool checkState;
  _WidgetList(this.value, this.checkState);
}

/*List<Widget> s = WidgetListfromStrings.map<Widget>(( _WidgetList value){
  return ListTile(
    key: Key("${value.value}"),
    title: Text(value.value),
  );
}).toList();*/

class App extends StatefulWidget{
  @override
  AppState createState(){
    return AppState();
  }
}

class _strikethrough extends StatelessWidget{
  final bool checked;
  final String text;
  _strikethrough(this.checked, this.text);

  Widget _widget(){
    if(checked){
      return Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
          fontStyle: FontStyle.italic
        ),
      );
    }
    else{
      return Text(
        text,
        style: TextStyle(
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return _widget();
  }

}



class AppState extends State<App>{

  List<String> items = [];
   
  List<_WidgetList> WidgetListfromStrings = [];
  
 _updateWidgetList(){
     WidgetListfromStrings = items.map<_WidgetList>((String value){
  return _WidgetList(value, false);
}).toList();
 }

  var textFieldController =  TextEditingController();

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
  void dispose(){
    textFieldController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Re Orderable List"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: textFieldController,
          ),
          RaisedButton(
            child: Text("Add Todo"),
            onPressed: (){
              setState(() {
                items.add(textFieldController.text);
                //_makeWidgetList();
                _updateWidgetList();
              textFieldController.clear();
              print(items);
              print(WidgetListfromStrings);
              });
            },
          ),
          Expanded(
            child: ReorderableListView(
        children: <Widget>[
          for(final x in WidgetListfromStrings)
            CheckboxListTile(
              key: Key(x.value),
              value: x.checkState ?? false,
              title: _strikethrough(x.checkState, x.value),
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
      ),
          )
        ],
      )
    );
  }
}*/