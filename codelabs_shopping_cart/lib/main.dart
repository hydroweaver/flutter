import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: ShoppingListWidget(
      Product("ss"),
      false,
      cartChane
    ),
  )); 
}

class Product{
  String name;
  Product(this.name);
}

typedef onCartChangeCallback = void Function(Product product, bool inCart);

class ShoppingListWidget extends StatelessWidget{
  
  final Product product;
  final bool inCart;
  final onCartChangeCallback cartChange;
  
  ShoppingListWidget(this.product, this.inCart, this.cartChange);

  TextStyle _textStyle(){
    if(!inCart){
      return TextStyle(
        color: Colors.green
      );
    }
    else{
      return TextStyle(
        color: Colors.red
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return ListTile(
      leading: CircleAvatar(
        child: Text(product.name),
      ),
    );
  }

}