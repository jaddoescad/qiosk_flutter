import 'package:flutter/material.dart';
import 'package:iamrich/models/cart.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';
import '../widgets/addCart.dart';
import '../widgets/itemList.dart';
import '../widgets/header.dart';
import '../widgets/navbar.dart';
import '../screens/cartPage.dart';


class Menu extends StatefulWidget {
  static const routeName = '/Menu';

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

  void viewYourCart() {
    Navigator.of(context).push(
      MaterialPageRoute(
         builder: (ctx) => CartPage()
        ),
    );
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
        bottomNavigationBar: CartButton(title: "View Your Cart", func: viewYourCart),
        body:NestedScrollView(
          physics: ClampingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              Header(restaurant: restaurant),
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
