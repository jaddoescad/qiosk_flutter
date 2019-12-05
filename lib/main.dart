import 'package:flutter/material.dart';
import 'package:iamrich/models/Item.dart';
import 'package:iamrich/models/cart.dart';
import 'package:iamrich/screens/menu.dart';
import 'package:provider/provider.dart';
import './screens/ItemOverview.dart';
import './screens/QRScanner.dart';
import './screens/cartPage.dart';
import './screens/homePage.dart';
import 'package:flutter/services.dart';
import './screens/loginPage.dart';
import './screens/signUpPage.dart';
import './models/user.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  // debugPaintSizeEnabled = true; //         <--- enable visual rendering
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
   .then((_) {
     runApp(MyApp());
   });
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
          value: User(),
        ),
        ChangeNotifierProvider.value(
          value: Item(),
        ),
         ChangeNotifierProvider.value(
          value: Cart(),
        )
      ],
        child: MaterialApp(
        title: 'Qiosk',
        theme: ThemeData(
          fontFamily: 'Roboto',
          primaryColor: Color(0xFF365E7a),
          // accentColor: Color(0xFF365E7a)
          ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        routes: {
          ItemOverview.routeName: (ctx) => QRViewExample(),
          HomePage.routeName: (ctx) => HomePage(),
          CartPage.routeName: (ctx) => CartPage(),
          LoginPage.routeName: (ctx) => LoginPage(),
          SignUpPage.routeName: (ctx) => SignUpPage()

        },
      ),
    );
  }
}