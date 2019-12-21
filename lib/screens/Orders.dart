import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/orders.dart';
import '../widgets/orderItem.dart';
import '../constants.dart';
import '../models/user.dart';
import '../models/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with WidgetsBindingObserver, RouteAware {
  Future ordersFuture;

  @override
  void initState() {
    super.initState();
    // ordersFuture = fetchOrders();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<RestaurantOrders>(context);
    final user = Provider.of<User>(context);
    final restaurant = Provider.of<Restaurant>(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: AppBar(
            iconTheme: IconThemeData(color: kMainColor),
            brightness: Brightness.light,
            elevation: 1,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
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
        body: orders.orders.asMap().length < 1 && user.uid == null && restaurant.id == null
            ? Container(
                color: Colors.white,
                constraints: BoxConstraints.expand(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ImageIcon(
                      AssetImage("assets/images/invoice.png"),
                      size: 110,
                      color: kMainColor.withOpacity(0.4),
                    ),
                    Text(
                      "",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      "No Orders",
                      style: TextStyle(
                          color: kMainColor.withOpacity(0.4), fontSize: 20),
                    ),
                  ],
                ),
              )
            : StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('Orders')
                    .where("userId", isEqualTo: user.uid)
                    .where("r_id", isEqualTo: restaurant.id)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {

                  orders.updateFirebaseData(snapshot);

                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                          delegate: SliverChildListDelegate([
                        ...orders.orders.asMap().values
                            .toList()
                            .map((order) => OrderItemCard(order: order))
                      ]))
                    ],
                  );
                }));
  }


}

//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.hasData) {
//                     print(snapshot.data);
//                   }
