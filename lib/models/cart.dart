import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartItem {
  String id;
  String itemId;
  String title;
  int quantity;
  double price;
  List<String> selectionTitles;

  CartItem({
    @required this.id,
    @required this.itemId,
    @required this.title,
    @required this.quantity,
    @required this.price,
    this.selectionTitles,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> items = {};
}