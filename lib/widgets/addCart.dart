import 'package:flutter/material.dart';
import 'package:iamrich/models/cart.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'package:iamrich/constants.dart';
import '../models/taxes.dart';

class CartButton extends StatelessWidget {
  CartButton({this.title, this.func});
  final title;
  final func;

  @override

  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final user = Provider.of<User>(context);

    return Container(
      height: 75,
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(
            color: Colors.grey,
            // blurRadius: 1.0,
          ),
          ]
      ),
      child: RaisedButton(
        elevation: 0,
        child: new CartButtonChildren(title: title, price: Taxes().getTotal(cart.totalAmount).toStringAsFixed(2)),
        color: kMainColor,
        onPressed:  () {func(context, user, cart);},
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
          child: Text('$title', style: TextStyle(fontSize: 15, color: color, fontWeight: FontWeight.w600),))),

    Positioned(child: Align(
      
      alignment: Alignment.centerRight,
      child: Text('\$$price', style: TextStyle(fontSize: 15, color: color, fontWeight: FontWeight.w600),)))
    
    
    ],);
  }
}
