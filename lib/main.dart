import 'package:flutter/material.dart';
import 'package:iamrich/models/Item.dart';
import 'package:iamrich/models/cart.dart';
import 'package:provider/provider.dart';
import './screens/ItemOverview.dart';
import './screens/menu.dart';
import './screens/QRScanner.dart';
import './screens/cartPage.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

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
         ChangeNotifierProvider.value(
          value: Cart(),
        )
      ],
        child: MaterialApp(
        title: 'Qiosk',
        home: Menu(),
        navigatorObservers: [routeObserver],
        routes: {
          ItemOverview.routeName: (ctx) => ItemOverview(),
          Menu.routeName: (ctx) => Menu(),
          CartPage.routeName: (ctx) => CartPage()
        },
      ),
    );
  }
}