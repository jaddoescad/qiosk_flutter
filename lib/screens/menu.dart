import 'package:flutter/material.dart';
import 'package:iamrich/models/cart.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';
import '../widgets/itemList.dart';
import '../widgets/header.dart';
import '../widgets/navbar.dart';

class Menu extends StatefulWidget {

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Future<Restaurant> restaurant;

  @override
  void initState() {
    super.initState();
    restaurant = fetchRestaurant();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant>(
        future: restaurant,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return menuPage(snapshot.data, context);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        }
    );}

  DefaultTabController menuPage(Restaurant restaurant, context) {
    final cart = Provider.of<Cart>(context);

    return DefaultTabController(
      length: restaurant.sections.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        body:NestedScrollView(
          physics: ClampingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              Header(restaurant: restaurant, items: cart.items),
              NavBar(sections: restaurant.sections),
            ];
          },
          body: TabBarView(
            children: restaurant.sections.map((section) {
              return ItemContainerList(section: section);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
