import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//fetch all orders
//create order
//listen to change in orders

class OrderItem {
  String generatedId;
  String itemId;
  String title;
  int quantity;
  double price;
  Map selectionTitles;

  OrderItem({
    this.generatedId,
    this.itemId,
    this.title,
    this.quantity,
    this.price,
    this.selectionTitles,
  });
}

class Order {
  String orderId;
  String status;
  double amount;

  Map<String, OrderItem> _orderItems = {};

  Order({this.orderId, this.status, this.amount});

  void addOrderItem(item) {
    final orderItem = OrderItem(
        generatedId: item['generatedId'],
        itemId: item['itemId'],
        title: item['title'],
        quantity: item['quantity'],
        price: item['price'],
        selectionTitles: item['selections']);
    _orderItems[item['generatedId']] = orderItem;
  }
}

class RestaurantOrders with ChangeNotifier {
  Map<String, Order> _orders = {};

  Map<String, Order> get orders {
    return {..._orders};
  }

  void addOrder(String orderId, orderJson, status, amount) {
    final order = Order(orderId: orderId, status: status, amount: amount);

    orderJson['items'].forEach((final key, final orderItem) {
      order.addOrderItem(orderItem);
    });

    _orders[orderId.toString()] = order;

    notifyListeners();
  }
}
