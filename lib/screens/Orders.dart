import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/orders.dart';
import '../widgets/orderItem.dart';
import '../constants.dart';
import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key key}) : super(key: key);
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
    // ordersFuture = fetchOrders();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  scrollToTop() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
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
        body: orders.orders.asMap().length < 1 || user.uid == null
            ? Container(
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
              )
            : StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('Orders')
                    .where("userId", isEqualTo: user.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {

                  orders.updateFirebaseData(snapshot);

                  return CustomScrollView(
                    controller: _scrollController,
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
