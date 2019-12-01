import 'package:flutter/material.dart';
import 'package:iamrich/models/cart.dart';
import 'package:provider/provider.dart';
import '../screens/CartPage.dart';


class CartButton extends StatelessWidget {
  CartButton({this.title, this.func});
  final title;
  final func;

  @override

  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Container(
      height: 70,
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(
            color: Colors.grey,
            blurRadius: 6.0,
          ),
          ]
      ),
      child: RaisedButton(
        elevation: 0,
        child: new CartButtonChildren(title: title, price: cart.totalAmount.toStringAsFixed(2)),
        color: Color(0xFF365e7a),
        onPressed:  () {func();},
      ),
    );
  }
}

class CartButtonChildren extends StatelessWidget {
  const CartButtonChildren({
    Key key,
    @required this.title,
    @required this.price,
    this.color = Colors.white
  }) : super(key: key);

  final title;
  final price;
  final color;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      
    Positioned(
        
        child: Align(
          alignment: Alignment.center,
          child: Text('$title', style: TextStyle(fontSize: 15, color: color),))),

    Positioned(child: Align(
      
      alignment: Alignment.centerRight,
      child: Text('\$ $price', style: TextStyle(fontSize: 15, color: color),)))
    
    
    ],);
  }
}
