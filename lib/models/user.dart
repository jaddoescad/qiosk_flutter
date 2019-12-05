

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class User extends ChangeNotifier{
   String name ;
   String email;
   String uid;

  User({this.email, this.name, this.uid});


  void changeUID(String _uid) {
    uid = _uid;
    notifyListeners();
  }
}