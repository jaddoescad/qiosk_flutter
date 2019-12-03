import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartItem {
  String generatedId;
  String itemId;
  String title;
  int quantity;
  double price;
  List selectionTitles;

  CartItem({
    @required this.generatedId,
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
   final generatedID = DateTime.now().toString();
      _items[generatedID] = CartItem(
              generatedId: generatedID,
              itemId: itemId,
              title: title,
              price: price,
              quantity: quantity,
              selectionTitles: selectionTitles
            );
      notifyListeners();
    }
    void removeItem(String generatedID) {
    _items.remove(generatedID);
    notifyListeners();
  }
    void clear() {
    _items = {};
    notifyListeners();
  }
}