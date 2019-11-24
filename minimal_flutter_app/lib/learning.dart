import 'package:flutter/material.dart';

/*void main(){
  runApp(MyScaffold());
}*/

/* for explanation - 

1. The following 2 programs will have the same output:

import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Center(
      child : Text(
        "data",
        textDirection: TextDirection.ltr,
        )
    );
  }
}

----------------------------------------------------Versus----------------------------------------------------------------------------

import 'package:flutter/material.dart';

void main(){
  runApp(
    Center(
      child : Text(
      "data",
      textDirection: TextDirection.ltr,
    );
  );
}

2. All widget build should have a return function, like return scaffold or return container etc. Otherwise it's KAPOOT! By the way,
the error message on the emulator is very helpful.

3. THink of it this way : Widget has child, child can have children, and so on recursively.

4. Which ever class() is called in main would run as the app :)

5. Scaffold does not work, if not called inside MaterialApp()

6. Expanded FLex allows you to choose how much each child will take, for example if one expanded flex = 1 and other is flex = 2, then
it means one child is taking 1/(1+2) space, while other is taking 2/(1+2)! 

7. In a main widget, any type, you can use the extend function to add more children!

8. Stateless widgets can be called inside stateful widgets, to redraw the UI and make the implementation more cleaner. Like children
of row, cols etc.

*/