/*import 'package:classtesting/classtesting.dart' as classtesting;

main(List<String> arguments) {
  print('Hello world: ${classtesting.calculate()}!');
}*/

class ListTodo{
    String todoText;
    bool todoToggle;
    ListTodo(this.todoText, this.todoToggle);
  }

void main(){ 
  List<ListTodo> todoList = [];
  todoList.add(ListTodo("karan", false));
  todoList.add(ListTodo("kunal", true));
  todoList.add(ListTodo("Sree", false));
  
  for(var i = 0; i < todoList.length ; i ++){
    print(todoList[i]);
  }

  //todoList.remove(ListTodo("karan", false));
  todoList.removeAt(0);

  print("\n");

  for(var i = 0; i < todoList.length ; i ++){
    print(todoList[i].todoText+" "+todoList[i].todoToggle.toString()+" "+todoList[i].hashCode.toString());
  }


}