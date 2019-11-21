class person{
  int id;
  String name;

  person.origin(){
    id = 000;
    name = "Default Name";
  }

  int setval(){
    id = 999;
  }
}

class details extends person{
  String address;

  int setval(){
    id = 990;
  }

  details.origin() : super.origin(){
    id = 000;
    name = 'Default Name';
  }

}

void main(){
  var p = person.origin();
  var d = details.origin();
  print('Name is ${d.name}');
  print('Address is ${d.address}');
  p.setval();
  d.setval();
  print(d.id);
  print(p.id);
}