import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

class CartItemCard extends StatelessWidget {
  CartItemCard({this.item});
  final item;
  final SlidableController slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Slidable(
      controller: slidableController,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
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
                    child: Text(item.quantity.toString(), textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, color: Color(0xFF365e7a)),),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(item.title, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, color: Color(0xFF365e7a))),
                        ...item.selectionTitles.map((selection) => Text(selection.title, textAlign: TextAlign.left, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 12, color: Color(0xFF365e7a)),),
                        ),
                      ],
                     ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('\$ ${item.price.toStringAsFixed(2)}', textAlign: TextAlign.right, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, color: Color(0xFF365e7a)),),
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
              width: 0.5,
            ),
          ),
        ),
      ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {Scaffold.of(context)
                    .showSnackBar(SnackBar(
                      duration: Duration(
                        seconds: 2,
                      ),
                      backgroundColor: Color(0xFF365e7a),
                      content: Text("Item Deleted", textAlign: TextAlign.center,)));

                    cart.removeItem(item.generatedId);
          }
        ),
      ],
    );
  }
}
