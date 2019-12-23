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
    return Container(
      color: kBodyBackground,
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
           padding: EdgeInsets.only(left: 15, right: 15),
           width: double.infinity,
           child: LinearProgressIndicator(
           backgroundColor: Color(0xFFececec),
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
       builder: (_) => Dialog(
       child: Container(
       height: MediaQuery.of(context).size.height*0.75,
       child: Column(
       children: <Widget>[
       Container(
         decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
         height: 50,
         child: Center(
           child: Text("Receipt", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
         ),
         ),
       Expanded(
       flex: 1,
       child: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
       Container(
       padding: EdgeInsets.only(top: 15, bottom: 15),
       margin: EdgeInsets.only(left: 15, right: 15),
       child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget>[
       Text("Order #" + order.orderId, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 12, color: Colors.grey),),
       Text(order.orderItems.keys.toString().substring(1, 11), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
       Text(restaurant.title, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 17, color: kMainColor)),
       ],),
       ),  
       Divider(
         thickness: 1,
       ),
       Container(
       padding: EdgeInsets.only(top: 15, bottom: 15),
       margin: EdgeInsets.only(left: 15, right: 15),
       child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget> [
       ...order.orderItems.values.map((item) => 
       Container(
       child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget> [
       Text(" " + item.quantity.toString() + "  " + item.title, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: kMainColor),),
       ...item.selectionTitles.values.map((selection) {
         return Padding(
           padding: const EdgeInsets.only(left: 16.0),
           child: Text(selection['title'], overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 12, color: Colors.grey),),
         );
       } 
       ),
       ]
       ),
       ),
       ),
       ]
       ),
       ),
       Divider(
         thickness: 1,
       ),
       Container(
       padding: EdgeInsets.only(top: 15, bottom: 15),
       margin: EdgeInsets.only(left: 15, right: 15),
       child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: <Widget> [
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Text("Subtotal"),
           Text('\$ ${order.amount.toStringAsFixed(2)}'),
         ],
       ),

      Text(" "),

       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Text("Taxes"),
           Text('\$ ${order.amount.toStringAsFixed(2)}'),
         ],
       ),

      Text(" "),

       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Text("Total", style: TextStyle(fontWeight: FontWeight.bold),),
           Text('\$ ${order.amount.toStringAsFixed(2)}'),
         ],
       ),
       ]
       ),
       ),
            ]
          ),
        ),
       ),
       ),
        GestureDetector(
            onTap: () { Navigator.pop(context); },
            child: Container(
              decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
              height: 50,
              child: Center(
              child: Text('Close', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ),
              ),
          ),
       ]
       )
       ),
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
