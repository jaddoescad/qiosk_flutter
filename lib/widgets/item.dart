import 'package:flutter/material.dart';
import '../screens/ItemOverview.dart';

class ItemContainer extends StatelessWidget {
  ItemContainer({this.item});
  final item;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (ctx) => ItemOverview()
            ),
          );
        },
        child: Container(
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
                    child: Text(item.title, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 13, color: Color(0xFF365e7a), fontWeight: FontWeight.bold),),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(item.description, overflow: TextOverflow.ellipsis, maxLines: 3, style: TextStyle(fontSize: 12, color: Color(0xFF365e7a),),),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(item.price, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 13, color: Color(0xFF365e7a), fontWeight: FontWeight.bold),),
                  ),
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
      ),
    );
  }
}
