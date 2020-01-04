import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iamrich/screens/homePage.dart';
import '../screens/QRScanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  double subtotal;
  double taxes;
  double total;
  String rname;
  int date;

  Map<String, OrderItem> _orderItems = {};
  Map<String, OrderItem> get orderItems {
    return {..._orderItems};
  }

  Order({this.orderId, this.status, this.subtotal, this.taxes, this.total, this.date, this.rname});

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

  List<Order> get orders {
    return [..._orders];
  }

  clear() {
    _orders = [];
  }

  void addOrders(orders) {
    _orders = [];
    orders.forEach((id, order) {
      addOrder(order['orderId'], order['r_name'],order, order['status'],
          order['subtotal'].toDouble(), order['taxes'].toDouble(), order['total'].toDouble(), order['date'], false);
    });
    _orders.sort((a, b) {
      return b.date.compareTo(a.date);
    });
  }

  void addOrder(String orderId, rname, orderJson, status, subtotal, taxes, total, date, dismiss) {
    final order =
        Order(orderId: orderId, status: status, subtotal: subtotal, taxes: taxes, total: total, date: date, rname: rname);

    orderJson['items'].forEach((final key, final orderItem) {
      order.addOrderItem(orderItem);
    });

    // _orders[orderId.toString()] = order;
    // _orders.add(order);
    _orders.insert(0, order);
    //sort orders here
    if (dismiss == true) {
      QRViewExampleState.myTabbedPageKey.currentState.changeMyTab();
      if (HomePageState.scrollToTopKey.currentState != null) {
      HomePageState.scrollToTopKey.currentState.scrollToTop();
      }
    }
    notifyListeners();
  }

  void updateFirebaseData(AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.data != null) {
      snapshot.data.documentChanges.forEach((diff) {
        if (diff.type == DocumentChangeType.modified) {
          print(diff.document.documentID);
            final orderToUpdateIndex = _orders
                .indexWhere((i) => i.orderId == diff.document.documentID.toString());
             print(orderToUpdateIndex);
            
            if (orderToUpdateIndex != null && orderToUpdateIndex >=  0) {
              _orders[orderToUpdateIndex].status = diff.document.data['status'];
              // notifyListeners();r
            }
        }
      });
    }
  }
}
