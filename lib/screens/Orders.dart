import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/orders.dart';
import '../Networking/Restaurant.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../models/user.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with WidgetsBindingObserver, RouteAware {
  Future ordersFuture;
  final restaurantNetworking = RestaurantNetworking();

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
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF365e7a),
          title: Text(
            "Orders",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
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
            IconButton(
              icon: Icon(Icons.camera),
              onPressed: () async {
                // print(orders.orders);
                try {
                  final data = await restaurantNetworking.fetchMenuandOrders(
                      "effeef", user.uid);
                  final restaurantOrders =
                      Provider.of<RestaurantOrders>(context);

                  final menu = data[0];
                  final _orders = data[1];

                  restaurantOrders.addOrders(_orders);

                  // //create orders
                  // print(data[0]);
                  // print(data[1]); //
                } on CloudFunctionsException catch (e) {
                  print("error");
                  print(e.message);
                } catch (e) {
                  print("error");
                  print(e);
                }
              },
            ),
            // orders.orders.forEach((f,r) {
            //   return Container();
            // })
            // ...orderKeys.map((i, order) {
            //   return Text(orders.orders[order].date.toString());
            // })

            ...orders
                .map((i, order) => MapEntry(i, Text(
                    order.date.toString()
                    )))
                .values
                .toList()
            // ...orders.map((i, order) {
            //   return Container();
            // }).toList()
          ],
        ),
      ),
    );
  }
}
