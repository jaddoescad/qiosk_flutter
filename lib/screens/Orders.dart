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
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../widgets/Loader.dart';
import '../widgets/errorMessage.dart';

class OrderPage extends StatefulWidget {
  const OrderPage(
      {Key key, this.showBackButton = false, this.loadOrders = false})
      : super(key: key);
  final showBackButton;
  final bool loadOrders;
  @override
  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage>
    with WidgetsBindingObserver, RouteAware {
  Future ordersFuture;
  ScrollController _scrollController;
  bool loader = false;
  String loaderText = "Loading Orders...";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Future.delayed(Duration.zero, () async {
      final user = Provider.of<User>(context);
      if (widget.loadOrders && user.uid != null) {
        setState(() {
          loader = true;
        });
        final restaurant = Provider.of<Restaurant>(context);
        final restaurantOrders = Provider.of<RestaurantOrders>(context);
        Auth()
            .getOrders(context, user, restaurant, restaurantOrders)
            .then((onValue) {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              loader = false;
            });
          });
        }).catchError((onError) async {
          await showErrorDialog(context, 'There was an Error Loading Orders');
          Navigator.of(context).pop();
        });
      }
    }).catchError((onError) async {
      print(onError);
      await showErrorDialog(context, 'There was an Error Loading Orders');
      Navigator.of(context).pop();
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
    return ModalProgressHUD(
      progressIndicator: Loader(context: context, loaderText: loaderText),
      inAsyncCall: loader,
      child: Scaffold(
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
                    return ordersView(orders);
                  })),
    );
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
            style: TextStyle(color: kMainColor.withOpacity(0.4), fontSize: 20),
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
