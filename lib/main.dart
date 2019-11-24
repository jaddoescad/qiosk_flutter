import 'package:flutter/material.dart';
import './Item.dart';


void main() {
  // debugPaintSizeEnabled = true; //         <--- enable visual rendering
  runApp(MyApp());
} 

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Item(),
    );
  }
}

class Item extends StatefulWidget {
  Map selectedList = {};
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                ItemBody(selectedList: widget.selectedList), 
                AddToCartButton(), 
              ],
            ),
          ),
        ),
        ItemAppBar()
      ],
    );
  }
}
