import 'package:flutter/material.dart';
import 'package:iamrich/models/cart.dart';
import 'package:provider/provider.dart';


class CartItemCard extends StatelessWidget {
  CartItemCard({this.item});
  final item;

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
        margin: EdgeInsets.only(left: 15.0, right: 15.0,),
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
                    child: Text(item.quantity.toString(), textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, color: Color(0xFF365e7a), fontWeight: FontWeight.bold),),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(item.title, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, color: Color(0xFF365e7a), fontWeight: FontWeight.bold)),
                        Text(""),
                        ...item.selectionTitles.map((selection) => Text(selection.title, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 12, color: Color(0xFF365e7a)),),
                        ),
                      ],
                     ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(item.price.toString(), textAlign: TextAlign.right, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, color: Color(0xFF365e7a), fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Color(0xFF365e7a),
              width: 1,
            ),
          ),
        ),
      ),
      );
  }
}
