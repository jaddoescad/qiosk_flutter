import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/orders.dart';

class OrdersNetworking {

Future CreateOrder(orderId, cart, amount, uid, restaurantid, context) async {

  final _items = {};
  final status = 'preparing';
  final date = DateTime.now().toUtc().millisecondsSinceEpoch;

  cart.items.forEach((final String key, final cartItem) {
    final _selections = {};

    cartItem.selectionTitles.map((final selection) {
      _selections[selection.id.toString()] = {
        'price': selection.price,
        'title': selection.title,
      };
    }).toList();
 

    
    _items[cartItem.generatedId.toString()] = {
      'generatedId': cartItem.generatedId,
      'itemId': cartItem.itemId,
      'title': cartItem.title,
      'price': cartItem.price,
      'quantity': cartItem.quantity,
      'selections': _selections,
    };
  }); 


  Map<String, dynamic> order =
  {
    'userId': uid,
    'orderId': orderId,
    'amount': amount,
    'r_id': restaurantid,
    'items' : _items,
    'date': date,
    'status': status
  };


try {
    await Firestore.instance
        .collection('Orders')
        .document(orderId)
        .setData(order).catchError((error) {
      print(error);
      throw (error.toString());
    });

    final orderModel = Provider.of<RestaurantOrders>(context);

    orderModel.addOrder(orderId, order, status, amount, date);
    Future.delayed(const Duration(milliseconds: 1000), () {
          Navigator.of(context).pop();

});

} catch(e) {
  throw(e);
} finally {
  print('success');
}
}
}
