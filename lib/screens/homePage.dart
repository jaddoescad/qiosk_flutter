import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iamrich/Networking/Auth.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../screens/menu.dart';
import '../screens/ProfileNotLoggedIn.dart';
import '../screens/Orders.dart';
import '../models/user.dart';
import '../screens/ProfileLoggedIn.dart';
import 'package:iamrich/constants.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  static const routeName = '/HomePage';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin , WidgetsBindingObserver{
static final scrollToTopKey = new GlobalKey<OrderPageState>();
  CupertinoTabController tabController;
  int _currentTabIndex = 0;

  changeMyTab() {
    tabController.index = 1;
  }

  @override
  void initState() {
    super.initState();
    tabController = new CupertinoTabController(initialIndex: 0);
    // OrdersNetworking
    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void dispose() {
    tabController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);


    return CupertinoTabScaffold(
      controller: tabController,
      tabBar: CupertinoTabBar(
        onTap: (index) {
          _currentTabIndex = index;
        },
        currentIndex: _currentTabIndex,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage(
                "assets/images/home.png",
              ),
              size: 27,
              color: kMainColor
            ),
            icon: ImageIcon(
              AssetImage(
                "assets/images/home.png",
              ),
              size: 27,
              color: kMainColor.withOpacity(0.4),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage(
                "assets/images/invoice.png",
              ),
              size: 27,
              color: kMainColor,
            ),
            icon: ImageIcon(
              AssetImage(
                "assets/images/invoice.png",
              ),
              size: 27,
              color: kMainColor.withOpacity(0.4),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage(
                "assets/images/user.png",
              ),
              size: 27,
              color: kMainColor,
            ),
            icon: ImageIcon(
              AssetImage(
                "assets/images/user.png",
              ),
              size: 27,
              color: kMainColor.withOpacity(0.4),
            ),
          )
        ],
      ),

      tabBuilder: (BuildContext context, int index) {
        assert(index >= 0 && index <= 2);
        switch (index) {
          case 0:
            return Menu();
            break;
          case 1:
            return OrderPage(key: scrollToTopKey);
            break;
          case 2:
            return (user.uid == null)
                ? ProfileNotLoggedIn()
                : ProfileLoggedIn();
            break;
        }
        return null;
      },
      // bottomNavigationBar: Container(
      //   decoration: new BoxDecoration(color: kMainColor, boxShadow: [
      //     new BoxShadow(
      //       color: Colors.grey,
      //       blurRadius: 4.0,
      //     ),
      //   ]),
      //   height: 49,
      //   child: TabBar(
      //     controller: tabController,
      //     indicatorColor: Colors.transparent,
      //     tabs: <Widget>[
      //       Tab(
      //           icon: ImageIcon(
      //         AssetImage("assets/images/home.png"),
      //         size: 27,
      //       )),
      //       Tab(
      //           icon: ImageIcon(
      //         AssetImage("assets/images/invoice.png"),
      //         size: 27,
      //       )),
      //       Tab(
      //           icon: ImageIcon(
      //         AssetImage("assets/images/user.png"),
      //         size: 27,
      //       )),
      //     ],
      //   ),
      // ),
      // body: TabBarView(
      //   controller: tabController, children: <Widget>[

      //   Tab(child: Menu()),
      //   Tab(child: OrderPage()),
      //   Tab(
      //       child: (user.uid == null)
      //           ? ProfileNotLoggedIn()
      //           : ProfileLoggedIn())
      // ])
    );
  }
}
