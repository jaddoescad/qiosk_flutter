import 'package:flutter/material.dart';
import 'package:iamrich/models/cart.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../constants.dart';
import '../constants.dart';
import '../constants.dart';
import '../models/restaurant.dart';
import '../widgets/itemList.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:iamrich/screens/cartPage.dart';

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
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.transparent,
            border: Border.all(
                color: kMainColor,
                width: 1,
            ),
          ),          
          child: Align(
            alignment: Alignment.center,
            child: Text(section.title),
          ),
        ),
      ));
    });

  return DefaultTabController(
      length: restaurant.sections.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: kMainColor,
        centerTitle: true,
        leading: IconButton(icon: ImageIcon(AssetImage("assets/images/photo-camera.png"), size: 25, color: Colors.white,), onPressed: () {
                Navigator.of(context).pop();
              }                   
            ),
        actions: <Widget>[
          Stack(
          children: <Widget>[
          IconButton(icon: ImageIcon(AssetImage("assets/images/cart.png"), size: 25, color: Colors.white,), onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(builder: (ctx) => CartPage()),
                          );
                        }),
          cart.items.values.length > 0 ? Positioned(
            right: 7,
            top: 3,
            child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
                ),
            constraints: BoxConstraints(
            minWidth: 15,
            minHeight: 15,
            ),
            child: Text(cart.items.values.length.toString(), style: TextStyle(color: Colors.white, fontSize: 12,), textAlign: TextAlign.center,),
            ),
            ) : Container()
          ],
        ),
        ],
        title: Text(restaurant.title, overflow: TextOverflow.ellipsis, maxLines: 1, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18, color: Colors.white,),),
        ),
        body: Column(children: <Widget>[
          Container(
          color: Colors.white,
          width: double.infinity,
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: kMainColor,
            tabs: myTabs,
            indicator: BubbleTabIndicator(
              indicatorRadius: 20.0,
              // insets: EdgeInsets.symmetric(horizontal: 15.0),
              indicatorHeight: 27.0,
              // padding: EdgeInsets.all(100),
              indicatorColor: kMainColor,
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),

            
          ),
          ),
          Expanded(
            flex: 1,
            child: TabBarView(
            children: restaurant.sections.map((section) {
              return ItemContainerList(section: section);
            }).toList(),
          ),
          ),
        ],)
        ),
      );
}