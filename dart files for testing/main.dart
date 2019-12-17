// code from : https://medium.com/flutter-community/state-management-gymnastics-using-states-rebuilder-part-1-3ba3a6abf9c7

import 'dart:math';

class FutureCounterWithError {
  int _counter = 0;

  int get counter{
    return _counter;
  }

  void increment() async{
    await Future.delayed(Duration(seconds: 1));
    if(Random().nextBool()){
      throw CounterError("There is an error in your counter");
    }
  }

}

class CounterError extends Error{
  final message;
  CounterError(this.message);
}