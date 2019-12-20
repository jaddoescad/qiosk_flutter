import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/orders.dart';
import '../widgets/orderItem.dart';
import '../constants.dart';

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
  final orders = Provider.of<RestaurantOrders>(context).orders.asMap();


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
      body: orders.length < 1 ? Container(
        color: Colors.white,
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageIcon(
              AssetImage("assets/images/invoice.png"),
              size: 110,
              color: Color(0xFF365e7a).withOpacity(0.4),
            ),
            Text(
              "",
              style: TextStyle(fontSize: 10),
            ),
            Text(
              "No Orders",
              style: TextStyle(
                  color: Color(0xFF365e7a).withOpacity(0.4), fontSize: 20),
            ),
          ],
        ),
      ) : CustomScrollView(slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            ...orders.values.toList().map((order) => OrderItemCard(order: order))
          ]))
      ],)
    );
  }
}
