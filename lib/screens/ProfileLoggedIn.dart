import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'package:flutter/cupertino.dart';
import '../screens/account.dart';
import '../screens/wallet.dart';
import '../screens/AboutUs.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

class ProfileLoggedIn extends StatefulWidget {
  final showBackButton;
  ProfileLoggedIn({this.showBackButton = false});
  @override
  _ProfileLoggedInState createState() => _ProfileLoggedInState();
}

class _ProfileLoggedInState extends State<ProfileLoggedIn> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle:  true,
        automaticallyImplyLeading: widget.showBackButton,
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            child: Text("Account"),
            onPressed: () {
                Navigator.of(context).push(
                 CupertinoPageRoute(
            builder: (ctx) => Account()
                
                
                )
                );
 
            },
          ),
          RaisedButton(
            child: Text("Wallet"),
            onPressed: () {
   Navigator.of(context).push(
                 CupertinoPageRoute(
            builder: (ctx) => Wallet()
                
                
                )
                );
            },
          ),
          RaisedButton(
            child: Text("About Us"),
            onPressed: () {
              Navigator.of(context).push(
                 CupertinoPageRoute(
            builder: (ctx) => AboutUs()
                )
                );
            },
          ),
        ],
      ),
    );
  }
}


