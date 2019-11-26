import 'package:flutter/material.dart';
import '../screens/ItemOverview.dart';

class ItemContainer extends StatelessWidget {
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
                    child: Text("Name", overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 13, color: Color(0xFF365e7a), fontWeight: FontWeight.bold),),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("Description", overflow: TextOverflow.ellipsis, maxLines: 3, style: TextStyle(fontSize: 12, color: Color(0xFF365e7a),),),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text("Price", overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 13, color: Color(0xFF365e7a), fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://media.blogto.com/uploads/2018/08/02/20180802-2048-LesMoulins3.jpg?cmd=resize&quality=70&w=1400&height=2500"),
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
