import 'package:flutter/material.dart';
import 'package:iamrich/models/Item.dart';
import 'package:provider/provider.dart';
import './screens/ItemOverview.dart';
import './screens/menu.dart';
import './screens/cartPage.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Item(),
        ),
      ],
        child: MaterialApp(
        title: 'Qiosk',
        home: Menu(),
        routes: {ItemOverview.routeName: (ctx) => ItemOverview(),
                CartPage.routeName: (ctx) => CartPage()},
      ),
    );
  }
}