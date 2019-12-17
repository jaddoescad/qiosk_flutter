import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../Networking/Payments.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/errorMessage.dart';
import '../screens/account.dart';
import '../screens/wallet.dart';
import '../screens/AboutUs.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

class ProfileLoggedIn extends StatefulWidget {
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
        centerTitle: true,
        automaticallyImplyLeading: false,
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


