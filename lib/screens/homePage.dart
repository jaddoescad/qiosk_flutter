import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iamrich/Networking/Auth.dart';
import 'package:provider/provider.dart';
import '../screens/menu.dart';
import '../screens/ProfileNotLoggedIn.dart';
import '../screens/Orders.dart';
import '../models/user.dart';
import '../screens/ProfileLoggedIn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  static const routeName = '/HomePage';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;




  changeMyTab(){
    setState(() {
      tabController.index = 2;
    });
  }


  @override
  void initState() {
    super.initState();
    Auth().checkIfUserExists(context);
    tabController = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Scaffold(
          bottomNavigationBar: Container(
            decoration: new BoxDecoration(color: Color(0xFF365e7a), boxShadow: [
              new BoxShadow(
                color: Colors.grey,
                blurRadius: 4.0,
              ),
            ]),
            height: 49,
            child: TabBar(
              controller: tabController,
              indicatorColor: Colors.transparent,
              tabs: <Widget>[
                Tab(
                    icon: ImageIcon(
                  AssetImage("assets/images/home.png"),
                  size: 25,
                )),
                Tab(
                    icon: ImageIcon(
                  AssetImage("assets/images/invoice.png"),
                  size: 25,
                )),
                Tab(
                    icon: ImageIcon(
                  AssetImage("assets/images/user.png"),
                  size: 25,
                )),
              ],
            ),
          ),
          body: TabBarView(controller: tabController, children: <Widget>[
            
            Tab(child: Menu()),
            Tab(child: OrderPage()),
            Tab(
                child: (user.uid == null)
                    ? ProfileNotLoggedIn()
                    : ProfileLoggedIn())
          ])
        ),
      ),
    );
  }
}
