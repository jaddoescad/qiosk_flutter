

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class User extends ChangeNotifier{
   String name ;
   String email;
   String uid;
   String stripeId;

  User({this.email, this.name, this.uid, this.stripeId});


  void changeUID(String _uid, String _name, String _email, String _stripeId) {
    uid = _uid;
    email = _email;
    name = _name;
    stripeId = _stripeId;
    notifyListeners();
  }
}