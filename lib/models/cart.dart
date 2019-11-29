import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartItem {
  String itemId;
  String title;
  int quantity;
  double price;
  List selectionTitles;

  CartItem({
    @required this.itemId,
    this.title,
    this.quantity,
    this.price,
    this.selectionTitles,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }



  // int get itemCount {
  //   return _items.length;
  // }
    double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

    void addItem(
    String itemId,
    double price,
    String title,
    int quantity,
    List selectionTitles
  ) {
      _items[DateTime.now().toString()] = CartItem(
              itemId: itemId,
              title: title,
              price: price,
              quantity: quantity,
              selectionTitles: selectionTitles
            );
      notifyListeners();
    }
  //   void removeItem(String productId) {
  //   _items.remove(productId);
  //   notifyListeners();
  // }
  //   void clear() {
  //   _items = {};
  //   notifyListeners();
  // }
}