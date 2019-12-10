void main(){
  List<int> x = [1, 2, 3];
  var x_sqr;

  x_sqr = x.map((value){
    return value*2;
  });

  x.forEach((z){
    print(z);
  });
  
  print('\n');
  
  x_sqr.forEach((value) {
    print(value);
  });
  
  print('\n');
  
  print(x_sqr.runtimeType);


}