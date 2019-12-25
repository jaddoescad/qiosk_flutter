import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/orders.dart';
import '../widgets/orderItem.dart';
import '../constants.dart';
import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Networking/Auth.dart';
import '../models/restaurant.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key key, this.showBackButton = false, this.loadOrders = false}) : super(key: key);
  final showBackButton;
  final bool loadOrders;
  @override
  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage>
    with WidgetsBindingObserver, RouteAware {
  Future ordersFuture;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

     Future.delayed(Duration.zero, () {

    final user = Provider.of<User>(context);
    final restaurant = Provider.of<Restaurant>(context);
    final restaurantOrders = Provider.of<RestaurantOrders>(context);
    Auth().getOrders(context, user, restaurant, restaurantOrders).then((onValue) {
      print('done');
    });
     });

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<RestaurantOrders>(context);
    final user = Provider.of<User>(context);
    return Scaffold(
        backgroundColor: kBodyBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: AppBar(
            iconTheme: IconThemeData(color: kMainColor),
            brightness: Brightness.light,
            elevation: 1,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: widget.showBackButton,
            leading: widget.showBackButton
                ? IconButton(
                    splashColor: Colors.transparent,
                    highlightColor:
                        Colors.transparent, // makes highlight invisible too
                    icon: Icon(
                      Icons.close,
                      size: 20,
                    ),
                    onPressed: () {
                      //add to cart
                      Navigator.of(context).pop();
                    },
                  )
                : null,
            title: Text(
              "Orders",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: kMainColor,
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('Orders')
                    .where("userId", isEqualTo: user.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print(snapshot.connectionState);
                  }
                  orders.updateFirebaseData(snapshot);
                  return ordersView(orders);
                }));
  }

  Container noOrders() {
    return Container(
              color: Colors.white,
              constraints: BoxConstraints.expand(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "No Orders",
                    style: TextStyle(
                        color: kMainColor.withOpacity(0.4), fontSize: 20),
                  ),
                ],
              ),
            );
  }

  CustomScrollView ordersView(RestaurantOrders orders) {
    return CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    SliverList(
                        delegate: SliverChildListDelegate([
                      ...orders.orders
                          .asMap()
                          .values
                          .toList()
                          .map((order) => OrderItemCard(order: order))
                    ]))
                  ],
                );
  }
}
