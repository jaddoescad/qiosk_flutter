import 'package:flutter/material.dart';
import 'package:iamrich/models/cart.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../constants.dart';
import '../constants.dart';
import '../constants.dart';
import '../models/restaurant.dart';
import '../widgets/itemList.dart';
import 'package:flutter/cupertino.dart';
import 'package:iamrich/screens/cartPage.dart';
import 'package:flutter/services.dart';

class Menu extends StatefulWidget {

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with WidgetsBindingObserver, RouteAware{

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = Provider.of<Restaurant>(context);

            return menuPage(restaurant, context);
        }
  }


DefaultTabController menuPage(Restaurant restaurant, context) {
  final cart = Provider.of<Cart>(context);  
  final List<Tab> myTabs = <Tab>[];

  restaurant.sections.forEach((final section) {
    myTabs.add(Tab(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(color: kMainColor, width: 1),
          ),          
          child: Align(
            alignment: Alignment.center,
            child: Text(section.title, style: TextStyle(fontWeight: FontWeight.w400),),
          ),
        ),
      ));
    });

return DefaultTabController(
      length: restaurant.sections.length,
      child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(icon: ImageIcon(AssetImage("assets/images/camera.png"), size: 30, color: kMainColor,), onPressed: () {
                Navigator.of(context).pop();
              }                   
            ),
        actions: <Widget>[
          Stack(
          children: <Widget>[
          IconButton(icon: ImageIcon(AssetImage("assets/images/cart.png"), size: 30, color: kMainColor,), onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(builder: (ctx) => CartPage()),
                          );
                        }),
          cart.items.values.length > 0 ? Positioned(
            left: 4,
            top: 4,
            child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(4),
                ),
            constraints: BoxConstraints(
            minWidth: 17,
            minHeight: 17,
            ),
            child: Text(cart.items.values.length.toString(), style: TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Roboto',fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
            ),
            ) : Container()
          ],
        ),
        ],
        title: Text(restaurant.title, overflow: TextOverflow.ellipsis, maxLines: 1, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18, color: kMainColor),),
        bottom: ColoredTabBar(Colors.white, TabBar(
          labelPadding: EdgeInsets.only(left: 10, right: 10),
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              labelColor: Colors.white,
              unselectedLabelColor: kMainColor,
              tabs: myTabs,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: kMainColor,
              ),
            ),
            ),
        ),
      body: TabBarView(
            children: restaurant.sections.map((section) {
              return ItemContainerList(section: section);
            }).toList(),
          ),
      ),
  );
}

class ColoredTabBar extends Container implements PreferredSizeWidget {
  ColoredTabBar(this.color, this.tabBar);

  final Color color;
  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Material(
    elevation: 0,
    child: Container(
    height: 60,
    padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
    color: color,
    width: double.infinity,
    child: tabBar,
    ),
  );
}