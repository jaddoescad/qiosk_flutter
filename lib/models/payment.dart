
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaymentModel extends ChangeNotifier {
  String _token;

  String get token {
    return _token;
  }

  void setToken(token) {
    _token = token;
  }

  void clear() {
    _token = null;
  }

}

