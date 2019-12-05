import 'package:flutter/material.dart';
import 'package:iamrich/models/restaurant.dart';
import '../screens/ItemOverView.dart';
import 'package:flutter/cupertino.dart';

class ItemContainer extends StatelessWidget {
  ItemContainer({this.item});
  final MenuItem item;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
                builder: (ctx) => ItemOverview(fromMenuItem: item)
            ),
          );
        },
        child: Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
        // margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
          //         Expanded(
          //           flex: 1,
          //           child: Padding(
          //             padding: const EdgeInsets.only(8.0),
          //             child: 
          Padding(
            padding: const EdgeInsets.only(top: 15.0 , bottom: 8.0),
            child: Text(item.title, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, color: Color(0xFF365e7a), fontWeight: FontWeight.w500, letterSpacing: 1),),
          ),
          //           ),
          //         ),
          //         Expanded(
          //           flex: 2,
          //           child: 
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(item.description, overflow: TextOverflow.ellipsis, maxLines: 2, style: TextStyle(fontSize: 13, color: Color(0xFF365e7a), fontWeight: FontWeight.w300, letterSpacing: 1),),
          ),
          //         ),
          //         Expanded(
          //           Rflex: 1,
          //           child: 
          Text('\$ ${item.price.toStringAsFixed(2)}', overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 13, color: Color(0xFF365e7a), fontWeight: FontWeight.w500),),
          //         ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(item.imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
              height:95,
              width: 95,
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
    );
  }
}
