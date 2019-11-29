import 'package:flutter/material.dart';
import 'package:iamrich/models/cart.dart';
import 'package:provider/provider.dart';


class CartItemCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
        margin: EdgeInsets.only(left: 15.0, right: 15.0,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text("dafa", overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 13, color: Color(0xFF365e7a), fontWeight: FontWeight.bold),),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("dafda", overflow: TextOverflow.ellipsis, maxLines: 3, style: TextStyle(fontSize: 12, color: Color(0xFF365e7a),),),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text("hharea", overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 13, color: Color(0xFF365e7a), fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25.0),
              height: 95,
              width: 95,
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
