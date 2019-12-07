import 'package:flutter/material.dart';

class GoToCheckout extends ChangeNotifier{
  bool goToCheckout = false;

  void setGoToCheckout(bool state) {
    goToCheckout = state;
  }
}