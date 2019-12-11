import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/orders.dart';


class Orders extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final orders = Provider.of<RestaurantOrders>(context);
    var orderKeys = orders.orders.keys.toList();

    
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
                    Text("No Orders", style: TextStyle(color: Color(0xFF365e7a).withOpacity(0.4), fontSize: 20),),
                    IconButton(icon: Icon(Icons.camera), onPressed: () {
                      // print(orders.orders);



               




                    },),
                    // orders.orders.forEach((f,r) {
                    //   return Container();
                    // })
                    ...orderKeys.map((order) {
                      return Text(orders.orders[order].date.toString());
                    })


                  ],
                ),
                ),
     );
  }
}
