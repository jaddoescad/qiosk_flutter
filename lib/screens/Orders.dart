import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iamrich/models/orders.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with WidgetsBindingObserver, RouteAware{
  Future ordersFuture;

  @override
  void initState() {
    super.initState();
    ordersFuture = fetchOrders();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return orderPage(snapshot.data, context);
          } else if (snapshot.hasError) {
            return orderPageError(context);
          }
          return CircularProgressIndicator();
        }
    );
  }

Scaffold orderPage(Order order, context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF365e7a),
          title: Text("Orders", overflow: TextOverflow.ellipsis, maxLines: 1, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18, color: Colors.white,),),
          centerTitle: true,
         ),
       ),
       body: CustomScrollView(
         slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [   
                   ...order.orderItems.map((orderItem) => Text(orderItem.title)),
                  ]
                ),
              )
           ]
         ),
     );
  }

Scaffold orderPageError(context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF365e7a),
          title: Text("Orders", overflow: TextOverflow.ellipsis, maxLines: 1, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18, color: Colors.white,),),
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
                    ImageIcon(AssetImage("assets/images/invoice.png"), size: 110, color: Color(0xFF365e7a).withOpacity(0.4),),
                    Text("", style: TextStyle(fontSize: 10),),
                    Text("No Orders", style: TextStyle(color: Color(0xFF365e7a).withOpacity(0.4), fontSize: 20),)
                  ],
                ),
                ),
     );
  }
}
