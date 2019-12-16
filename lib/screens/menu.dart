import 'package:flutter/material.dart';
import 'package:iamrich/models/cart.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';
import '../widgets/itemList.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import '../widgets/header.dart';
import '../widgets/navbar.dart';

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
        text: section.title
      ));
    });

  return DefaultTabController(
      length: restaurant.sections.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
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
            unselectedLabelColor: Colors.black,
            tabs: myTabs,
            indicator: BubbleTabIndicator(
              indicatorHeight: 25.0,
              indicatorColor: Colors.black,
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

     //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
     //       return <Widget>[
      //        Header(restaurant: restaurant, items: cart.items),
    //          NavBar(sections: restaurant.sections),
    //        ];
    //      },