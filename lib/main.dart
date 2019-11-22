import 'package:flutter/material.dart';
import './Item.dart';


void main() {
  runApp(QioskApp());
} 

class QioskApp extends StatefulWidget {
  @override
  _QioskAppState createState() => _QioskAppState();
}

class _QioskAppState extends State<QioskApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Stack(
        children: <Widget>[
          Container(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  ItemBody(), 
                  AddToCartButton(), 
                ],
              ),
            ),
          ),
          ItemAppBar()
        ],
      ),
    );
  }
}
