import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iamrich/Networking/Auth.dart';
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
    // Auth().checkIfUserExists(context);
    final user = Provider.of<User>(context);

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
                  Tab(icon: ImageIcon(AssetImage("assets/images/home.png"), size: 30,)),
                  Tab(icon: ImageIcon(AssetImage("assets/images/invoice.png"), size: 30,)),
                  Tab(icon: ImageIcon(AssetImage("assets/images/user.png"), size: 30,)),
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