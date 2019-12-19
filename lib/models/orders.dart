import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../screens/QRScanner.dart';
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
  int date;

  Map<String, OrderItem> _orderItems = {};

  Order({this.orderId, this.status, this.amount, this.date});




  void addOrderItem(item) {
    final orderItem = OrderItem(
        generatedId: item['generatedId'],
        itemId: item['itemId'],
        title: item['title'],
        quantity: item['quantity'],
        price: item['price'].toDouble(),
        selectionTitles: item['selections']);
    _orderItems[item['generatedId']] = orderItem;
  }
}

class RestaurantOrders with ChangeNotifier {
  List<Order> _orders = [];

  List< Order> get orders {
    return [..._orders];
  }

  clear() {
    _orders = [];
  }

  void addOrders(orders) {
    _orders = [];
    orders.forEach((id, order) {
      addOrder(order['orderId'], order, order['status'], order['amount'].toDouble(), order['date'], false);
    });
  }

  void addOrder(String orderId, orderJson, status, amount, date, dismiss) {
    final order = Order(orderId: orderId, status: status, amount: amount, date: date);

    orderJson['items'].forEach((final key, final orderItem) {
      order.addOrderItem(orderItem);
    });

    // _orders[orderId.toString()] = order;
    _orders.add(order);
    //sort orders here
    if (dismiss == true) {
    QRViewExampleState.myTabbedPageKey.currentState.tabController.animateTo(1, duration: Duration(milliseconds: 0),  );
    }
    notifyListeners();
  }
}
