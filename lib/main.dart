import 'package:flutter/material.dart';
import './screens/ItemOverview.dart';
import './screens/menu.dart';

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
      title: 'Qiosk',
      home: Menu(),
      routes: {ItemOverview.routeName: (ctx) => ItemOverview()},
    );
  }
}