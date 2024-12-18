import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iamrich/constants.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
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
      actionPane: SlidableDrawerDismissal(),
      actionExtentRatio: 0.25,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.only(top: 25, bottom: 25),
              margin: EdgeInsets.only(left: 20.0, right: 20),
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
                        child: Text(
                          item.quantity.toString(),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(item.title,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: kMainColor,
                                    fontWeight: FontWeight.bold)),
                            ...item.selectionTitles.map(
                              (selection) => Text(
                                selection.title,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '\$ ${item.price.toStringAsFixed(2)}',
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    // color: kMainColor,
                    color: kMainColor.withOpacity(0.2),
                    width: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              Scaffold.of(context).showSnackBar(SnackBar(
                  duration: Duration(
                    seconds: 2,
                  ),
                  backgroundColor: kMainColor,
                  content: Text(
                    "Item Deleted",
                    textAlign: TextAlign.center,
                  )));

              cart.removeItem(item.generatedId);
            }),
      ],
    );
  }
}
