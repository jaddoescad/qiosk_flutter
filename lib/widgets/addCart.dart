import 'package:flutter/material.dart';
import '../screens/CartPage.dart';

class Cart extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
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
        child: Text('View Your Cart', style: TextStyle(fontSize: 15, color: Colors.white),),
        color: Color(0xFF365e7a),
        onPressed:  () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (ctx) => CartPage()
            ),
          );
        },
      ),
    );
  }
}
