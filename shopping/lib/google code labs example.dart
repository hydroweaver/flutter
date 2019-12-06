import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Shopping List with State Control Upper in Heirarchy",
    home: ShoppingList(
      products: <Product>[
        Product(name: 'karan'),
        Product(name: 'karan'),
        Product(name: 'karan'),
      ],
    ),
  ));
}

class Product{
  String name;
  Product({this.name});
}

typedef OnCartChangeCallback = void Function(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget{
  final Product product;
  final bool inCart;
  final OnCartChangeCallback cartChangeCallback;

  ShoppingListItem({this.product, this.inCart, this.cartChangeCallback});

  Color _color(){
    if(!inCart){
      return Colors.amber;
    }
    else{
      return Colors.green;
    }
  }

  TextStyle _textstyle(){
    if(!inCart){
      return TextStyle(
        decoration: TextDecoration.lineThrough
      );
    }
    else{
      return TextStyle(
        decoration: TextDecoration.underline
      );
    }
  }
  
  @override
  Widget build(BuildContext context){
    return ListTile(
      onTap: (){
        cartChangeCallback(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _color(),
        child: Text(
          product.name[0],
      ),
    ),
    title: Text(product.name, style: _textstyle()),
    );
  }

}

class ShoppingList extends StatefulWidget{
  ShoppingList({this.products});
  final List<Product> products;

  @override
  _ShoppingListState createState() => _ShoppingListState();

}

class _ShoppingListState extends State<ShoppingList>{
  Set<Product> _shoppingCart = Set<Product>();

  void _handler(Product product, bool inCart){
    setState(() {
      if(!inCart){
        _shoppingCart.add(product);
        }
    else{
      _shoppingCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping List"),
      ),
      body: ListView(
        children: widget.products.map((Product product){
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            cartChangeCallback: _handler,
          );
        }).toList(),
      ),
    );
  }

}