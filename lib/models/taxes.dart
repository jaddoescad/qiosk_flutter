import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Taxes extends ChangeNotifier {
  double _taxRate;


  void setTaxRate(rate) {
    _taxRate = rate['taxRate'];
    print(_taxRate);
  }

  double applyTax(subtotal) {
    subtotal = subtotal*_taxRate;
    return subtotal;
  }

  double getTotal(subtotal) {
    subtotal = subtotal + subtotal*_taxRate;
    return subtotal;
  }
}