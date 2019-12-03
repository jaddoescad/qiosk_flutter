import 'package:flutter/material.dart';

class Orders extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF365e7a),
          title: Text("Orders"),
          centerTitle: true,
         ),
       ),
       body: Container(
          color: Colors.white, 
          constraints: BoxConstraints.expand(),
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.receipt, size: 110, color: Color(0xFF365e7a).withOpacity(0.4),),
                    Text("", style: TextStyle(fontSize: 10),),
                    Text("No Orders", style: TextStyle(color: Color(0xFF365e7a).withOpacity(0.4), fontSize: 20),)
                  ],
                ),
                ),
     );
  }
}
