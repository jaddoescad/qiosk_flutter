import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'dart:core';
import '../screens/ProfileNotLoggedIn.dart';
import '../screens/ProfileLoggedIn.dart';
import '../models/user.dart';



class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return (user.uid == null)
        ? ProfileNotLoggedIn(
            showBackButton: true,
          )
        : ProfileLoggedIn(
            showBackButton: true,
          );
  }
}
