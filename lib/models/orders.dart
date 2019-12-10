import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future fetchOrders() async {
    final response = await rootBundle.loadString('assets/mock/Test.json').then((itemData) {
    return itemData;
  });

  return Order.fromOrderJson(json.decode(response));
  }


class Order extends ChangeNotifier {
  String id;
  String userId;
  String restaurantId;
  String date;
  double totalPrice;
  List<OrderItem> orderItems;

  Order({this.id, this.userId, this.restaurantId, this.date, this.totalPrice, this.orderItems});

  factory Order.fromOrderJson(Map<String,dynamic> json) {
    final String _id = json.keys.toList()[0].toString();

    return Order(
        id: _id,
        userId: json[_id]['userId'],
        restaurantId: json[_id]['restaurantId'],        
        date: json[_id]['date'],
        totalPrice: json[_id]['totalPrice'].toDouble(),
        orderItems: getOrderItems(json[_id]['orderItems'])
    );
  }

  static List<OrderItem> getOrderItems(Map<dynamic, dynamic> sectionsJson) {
    List<OrderItem> orderItemArray = [];
    sectionsJson.forEach((final id, final section) {
      orderItemArray.add(OrderItem(
          title: section['title'],
          price: section['price'].toDouble(),
          itemSelections: getItemSelection(section['selections'])
      ));
    });
    // orderItemArray = sortArray(orderItemArray);
    return orderItemArray;
  }

  static List<ItemSelection> getItemSelection(Map<dynamic, dynamic> itemsJson) {
    List<ItemSelection> itemSelectionArray = [];
    itemsJson.forEach((final id, final item) {
      itemSelectionArray.add(ItemSelection(
          title: item['title'],
      ));
    });
    // itemSelectionArray = sortArray(itemSelectionArray);
    return itemSelectionArray;
  }

  static List sortArray(map) {
    map.sort((a, b) {
      return a.order
          .toString()
          .toLowerCase()
          .compareTo(b.order.toString().toLowerCase());
    });
    return map;
  }

}

class OrderItem {
  final String title;
  final double price;
  final List<ItemSelection> itemSelections;

  OrderItem({this.title, this.price, this.itemSelections});
}

class ItemSelection {
  final String title;

  ItemSelection({this.title});
}