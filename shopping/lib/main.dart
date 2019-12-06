import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(){
  runApp(MaterialApp(
    title: "Shopping List - Copy of google codelabs exmaple without the mess! simpler, but inCart outside the drawing cart",
    home: ShoppingList(),
  ));
}

class Product{
  String productname;
  Product({this.productname});
}

typedef void ButtonFunction(Product product, bool inCart);

class ShoppingListWidget extends StatelessWidget{
  final Product product;
  final bool inCart;
  final ButtonFunction button;
  
  ShoppingListWidget({this.product, this.inCart, this.button});

  TextStyle _textStyle(BuildContext context){
    if(!inCart){
      return TextStyle(
        color: Theme.of(context).primaryColor);
    }
    else{
      return TextStyle(
        color: Colors.red,
        decoration: TextDecoration.lineThrough,
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return ListTile(
      onTap: (){
        button(product, inCart);
      },
      contentPadding: const EdgeInsets.all(16.0),
      leading: CircleAvatar(
        child: Text(
          product.productname[0],
          style: _textStyle(context),
        ),
      ),
      title: Text(
        product.productname,
        style: _textStyle(context)),
    );
  }
}


class ShoppingList extends StatefulWidget{
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList>{

  final mycontroller = TextEditingController();

  @override
  void dispose(){
    mycontroller.dispose();
    super.dispose();
  }

  Set<Product> _shoppingCart = Set<Product>();
  List<Product> _shoppingListing = List<Product>();

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
        title: Text("Shopping List Toggle"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: mycontroller,
          ),
          RaisedButton(

            onPressed: (){
              if(mycontroller.text != ""){
              setState(() {
                _shoppingListing.add(new Product(productname: mycontroller.text));
                _shoppingCart.add(new Product(productname: mycontroller.text));
                mycontroller.clear();
              });
            }
              },
            child: Text("Add Todo"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _shoppingListing.length,
              itemBuilder: (context, index){
                Fluttertoast.showToast(
                  msg: index.toString()
                );
                return ShoppingListWidget(
                  product: _shoppingListing[index],
                  inCart: _shoppingCart.contains(_shoppingListing[index]),
                  button: _handler,
                  );
            },
          ),  
          )
        ],
      )
    );
  }

}