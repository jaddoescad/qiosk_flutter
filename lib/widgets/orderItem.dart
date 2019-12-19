import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../constants.dart';

class OrderItemCard extends StatelessWidget {
  OrderItemCard({this.order});
  final order;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Container(
       color: Colors.white,
       child: Container(
        padding: EdgeInsets.only(top: 25.0, bottom: 25.0, left: 10.0, right: 10.0),
        margin: EdgeInsets.only(left: 15.0),
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
                        Text(order.orderId, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, color: kMainColor)),
                        ...order.orderItems.map((selection) => Text(selection.title, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 12, color: kMainColor),),
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
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: kMainColor,
              width: 0.5,
            ),
          ),
        ),
      ),
      );
    }
  }
