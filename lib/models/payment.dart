
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaymentModel extends ChangeNotifier {
  String _token;
  String _lastFour;
  String _cardType;
  

  String get token {
    return _token;
  }

  String get lastFour {
    return _lastFour;
  }

  String get cardType {
    return _cardType;
  }

  void setToken(token) {
    _token = token;
  }

  void setCard(token, lastFour, cardType) {
    _token = token;
    _lastFour = lastFour;
    _cardType = cardType;
  }

  void clear() {
    _token = null;
    _lastFour = null;
    _cardType = null;
  }

}

