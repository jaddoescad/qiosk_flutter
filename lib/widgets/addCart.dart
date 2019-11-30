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
      height: 65,
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(
            color: Colors.grey,
            blurRadius: 6.0,
          ),
          ]
      ),
      child: RaisedButton(
        elevation: 10,
        child: Text('$title \$ ${cart.totalAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 15, color: Colors.white),),
        color: Color(0xFF365e7a),
        onPressed:  () {func();},
      ),
    );
  }
}
