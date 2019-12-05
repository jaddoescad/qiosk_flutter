import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/menu.dart';
import '../screens/Profile.dart';
import '../screens/Orders.dart';
import '../models/user.dart';
import '../screens/ProfileLoggedIn.dart';

class HomePage extends StatelessWidget {
static const routeName = '/HomePage';

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    print("hello");
    print(user.uid);
    print("hello");

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Scaffold(
                bottomNavigationBar: Container(
                  decoration: new BoxDecoration(
                      color: Color(0xFF365e7a),
                      boxShadow: [new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4.0,
                      ),
                      ]
                      ),
                  height: 49,
                  child: TabBar(
                  indicatorColor: Colors.transparent,
                  tabs: <Widget>[
                  Tab(icon: Icon(Icons.home, size: 30,)),
                  Tab(icon: Icon(Icons.receipt, size: 30,)),
                  Tab(icon: Icon(Icons.account_circle, size: 30,)),
                ],
                ),
                ),
                body: TabBarView(
                children: <Widget>[
                  Tab(child: Menu()),
                  Tab(child: Orders()),
                  Tab(child: (user.uid == null) ? ProfileNotLoggedIn() : ProfileLoggedIn())
                ]
          ),
        ),
        ),
    );
  }
}