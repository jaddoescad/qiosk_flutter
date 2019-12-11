import 'package:flutter/material.dart';
import 'package:iamrich/Networking/Auth.dart';
import 'package:iamrich/models/Item.dart';
import 'package:iamrich/models/cart.dart';
import 'package:iamrich/models/restaurant.dart';
import 'package:provider/provider.dart';
import './screens/QRScanner.dart';
import './screens/cartPage.dart';
import './screens/homePage.dart';
import 'package:flutter/services.dart';
import './screens/loginPage.dart';
import './screens/signUpPage.dart';
import './models/user.dart';
import './screens/ItemOverView.dart';
import './screens/splashScreen.dart';
import './models/goToCheckout.dart';
import './models/restaurant.dart';
import './models/orders.dart';

// import 'package:stripe_payment/stripe_payment.dart';
import 'dart:async';
import 'package:flutter_stripe_payment/flutter_stripe_payment.dart';

// const publishableKey = "pk_test_3pnCHeZmNkaGk0lwKa9FRKln";

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // debugPaintSizeEnabled = true; //         <--- enable visual rendering
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  static final myTabbedPageKey = new GlobalKey<HomePageState>();
  @override
  void initState() {
    super.initState();
    // FlutterStripePayment.setStripeSettings(publishableKey);
    FlutterStripePayment.setStripeSettings("pk_test_3pnCHeZmNkaGk0lwKa9FRKln");
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Restaurant(),
        ),
        ChangeNotifierProvider(
          create: (_) => User(),
        ),
        ChangeNotifierProvider(
          create: (_) => Item(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => GoToCheckout(),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantOrders(),
        )
      ],
      child: MaterialApp(
        title: 'Qiosk',
        theme: ThemeData(
          fontFamily: 'Roboto',
          primaryColor: Color(0xFF365E7a),
          // accentColor: Color(0xFF365E7a)
        ),
        home: HomePage(key: myTabbedPageKey),
        navigatorObservers: [routeObserver],
        routes: {
          // QRViewExample.routeName: (ctx) => QRViewExample(),
          ItemOverview.routeName: (ctx) => ItemOverview(),
          HomePage.routeName: (ctx) => HomePage(),
          CartPage.routeName: (ctx) => CartPage(),
          LoginPage.routeName: (ctx) => LoginPage(),
          SignUpPage.routeName: (ctx) => SignUpPage()
        },
      ),
    );
  }
}
