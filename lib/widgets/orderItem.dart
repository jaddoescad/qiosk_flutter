import 'package:flutter/material.dart';
import 'package:iamrich/constants.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:flutter/cupertino.dart';
import '../models/restaurant.dart';

class OrderItemCard extends StatelessWidget {
  OrderItemCard({this.order});
  final order;

  @override
  Widget build(BuildContext context) {
    final restaurant = Provider.of<Restaurant>(context);
    debugPrint(order.orderItems.values.toString());
    return Container(
      color: Color(0xFFEAEAEA),
      child: Container(
       margin: EdgeInsets.only(top: 15.0,),
       color: Colors.white,
       child: Column(
         children: <Widget>[
       order.status == "preparing" ? Container(
       padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
         child: Column(children: <Widget>[
           Text("Preparing Order ...", overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 14, color: kMainColor, fontWeight: FontWeight.bold)),
           Text(" "),
           Container(
           decoration: BoxDecoration(
           border: Border(top: BorderSide(color: kMainColor, width: 1), bottom: BorderSide(color: kMainColor, width: 1))
           ),
           width: double.infinity,
           child: LinearProgressIndicator(
           backgroundColor: Colors.white,
           valueColor: AlwaysStoppedAnimation<Color>(kMainColor),
           ),
           ),
         ],),
       ) : Container(),
       order.status == "complete" ? Container(
       margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
         child: Row(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
         Icon(Icons.check_circle_outline, color: Colors.green, size: 30,),
         Text("  "),
         Text("Order Complete", overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 14, color: kMainColor, fontWeight: FontWeight.bold)),
         Text("  "),
         Icon(Icons.check_circle_outline, color: Colors.white, size: 30,),
         ],),
       ) : Container(),  
       Container(
       decoration: BoxDecoration(
       border: Border(
       top: BorderSide(color: Colors.grey, width: 0.2),
       bottom: BorderSide(color: Colors.grey, width: 0.2)
       )
       ),
       padding: EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 10),
       margin: EdgeInsets.only(left: 15, right: 15),
       child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget>[
       Text("Order #" + order.orderId, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 12, color: Colors.grey),),
       Text(order.orderItems.keys.toString().substring(1, 11), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
       Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: <Widget>[
       Text(restaurant.title, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 17, color: kMainColor)),
       Text('\$ ${order.amount.toStringAsFixed(2)}', overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 17, color: kMainColor))
       ],)
       ],),
       ),  
       Container(
       decoration: BoxDecoration(
       border: Border(
       top: BorderSide(color: Colors.grey, width: 0.2),
       bottom: BorderSide(color: Colors.grey, width: 0.2)
       )
       ),
       width: double.infinity,
       padding: EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 10),
       margin: EdgeInsets.only(left: 15, right: 15),
       child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget>[
       Text("Items", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
       ...order.orderItems.values.map((selection) => Text(" " + selection.quantity.toString() + "  " + selection.title, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 12, color: Colors.grey),),)
       ],),
       ),
       GestureDetector(
       onTap: () {
       showDialog(
       context: context,
       builder: (_) => SimpleDialog(
       title: Container(
         decoration: BoxDecoration(
           border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))
         ),
         child: Text("Receipt", textAlign: TextAlign.center,),),
       children: <Widget>[
       CustomScrollView(
       slivers: <Widget>[
         SliverToBoxAdapter(
           child: Container(),
           ),
         SliverToBoxAdapter(
           child: Container(),
           ),
         SliverToBoxAdapter(
           child: Container(),
           )
       ],

       )
       ],
       ),
       );
       },
       child: Container(
       decoration: BoxDecoration(
       border: Border(
       top: BorderSide(color: Colors.grey, width: 0.2),
       )
       ),
       width: double.infinity,
       padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
       margin: EdgeInsets.only(left: 15, right: 15),
       child: Text("View Order Summary", textAlign: TextAlign.right,style: TextStyle(fontSize: 15, color: Colors.green))
       ),
       ),
         ],
       ),
      ),
      );
    }
  }


/*
       Container(
        padding: EdgeInsets.only(top: 25.0, bottom: 25.0, left: 10.0, right: 10.0),
        margin: EdgeInsets.only(left: 15.0,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(order.amount.toString(), textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, color: kMainColor),),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
<<<<<<< HEAD
                        Text(order.orderId, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, color: kMainColor)),
                        ...order.orderItems.map((selection) => Text(selection.title, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 12, color: kMainColor),),
=======
                        Text(order.orderId, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, color: Color(0xFF365e7a))),
                        ...order.orderItems.values.map((selection) => Text(selection.title, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 12, color: Color(0xFF365e7a)),),
>>>>>>> abf34bc089b72cfa2af3ca7ee7ee3edef09cbd69
                        ),
                      ],
                     ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('\$ ${order.amount.toStringAsFixed(2)}', textAlign: TextAlign.right, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, color: kMainColor),),
                  ),
                ],
              ),
          ],
        ),
<<<<<<< HEAD
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: kMainColor,
              width: 0.5,
            ),
          ),
        ),
=======
>>>>>>> abf34bc089b72cfa2af3ca7ee7ee3edef09cbd69
      ),
*/