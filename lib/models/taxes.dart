import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Taxes extends ChangeNotifier {
  double _above;
  double _below;
  double _priceThreshold;

  void setTaxRate(rate) {
    _above = rate['taxRate']['above'].toDouble();
    _below = rate['taxRate']['below'].toDouble();
    _priceThreshold = rate['taxRate']['price'].toDouble();
  }

  double applyTax(subtotal) {
    if (subtotal < _priceThreshold) {
      subtotal = subtotal * _below;
    } else {
      subtotal = subtotal * _above;
    }
    return subtotal;
  }

  double getTotal(subtotal) {
    if (subtotal < _priceThreshold) {
      subtotal = subtotal + subtotal * _below;
    } else {
      subtotal = subtotal + subtotal * _above;
    }
    return subtotal;
  }
}
