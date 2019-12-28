import 'package:flutter/material.dart';
import 'package:iamrich/models/Item.dart';
import 'package:iamrich/models/cart.dart';
import 'package:iamrich/models/restaurant.dart';
import 'package:iamrich/models/taxes.dart';
import 'package:iamrich/screens/splashScreen.dart';
import 'package:provider/provider.dart';
import './screens/cartPage.dart';
import './screens/homePage.dart';
import 'package:flutter/services.dart';
import './screens/loginPage.dart';
import './screens/signUpPage.dart';
import './models/user.dart';
import './screens/ItemOverView.dart';
import './models/goToCheckout.dart';
import './models/restaurant.dart';
import './models/orders.dart';
import './models/payment.dart';
import 'package:flutter_stripe_payment/flutter_stripe_payment.dart';
import 'package:camera/camera.dart';
import './screens/QRScanner.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'constants.dart';
import 'screens/splashScreen.dart';
import 'package:flutter/rendering.dart';



final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
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
  @override
  void initState() {
    super.initState();
    FlutterStripePayment.setStripeSettings("pk_test_3pnCHeZmNkaGk0lwKa9FRKln");
    StripePayment.setOptions(StripeOptions(
      publishableKey: 'pk_test_3pnCHeZmNkaGk0lwKa9FRKln',
      // merchantId: 'MERCHANT_ID',
      // androidPayMode: 'test',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Taxes(),
        ),
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
          create: (_) => PaymentModel(),
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
        // darkTheme: ThemeData.dark(),
        theme: ThemeData(
          fontFamily: 'Avenir',
          primaryColor: kMainColor,
        ),
        home: Splash(),
        navigatorObservers: [routeObserver],
        routes: {
          QRViewExample.routeName: (ctx) => QRViewExample(),
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
