import 'package:flutter/material.dart';
import 'package:iamrich/Networking/Auth.dart';
import 'package:iamrich/models/restaurant.dart';
import 'package:iamrich/screens/homePage.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../main.dart';
import 'package:flutter/cupertino.dart';
import '../models/orders.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../models/user.dart';
import '../Networking/Restaurant.dart';

class QRViewExample extends StatefulWidget {
  static const routeName = '/QRView';
  @override
  QRViewExampleState createState() => QRViewExampleState();
}

class QRViewExampleState extends State<QRViewExample> with RouteAware {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final restaurantNetworking = RestaurantNetworking();
  static final myTabbedPageKey = new GlobalKey<HomePageState>();

  var qrText = "";
  bool _isloading = false;
  QRViewController controller;

  @override
  void initState() {
    super.initState();
    Auth().checkIfUserExists(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
  }

  @override
  void didPopNext() {
    setState(() => _isloading = !_isloading);
    // Covering route was popped off the navigator.
    // logger.log("pop");
    if (controller != null) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
          ],
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Color(0xFF365e7a).withOpacity(0.3),
        ),
        Center(
          child: Opacity(
            opacity: 0.7,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/Scan.png'),
              )),
            ),
          ),
        ),
      ]),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      if (!_isloading) {
        setState(() => _isloading = !_isloading);
        final user = Provider.of<User>(context);
        
          try {
            if (user.uid != null) {
            final data = await restaurantNetworking.fetchMenuandOrders(
                "effeef", user.uid);
            final restaurantOrders = Provider.of<RestaurantOrders>(context);

            final menu = data[0];

            print(menu);
            final _orders = data[1];

            restaurantOrders.addOrders(_orders);
            goToHomePage();
            } else {
              goToHomePage();
            }
          } on CloudFunctionsException catch (e) {
            print("object");
            print("error");
            print(e.message);
          } catch (e) {
            print("object2");
            print("error");
            print(e.toString());
          }
        }
      
    });
   
    }
     void goToHomePage() {
      Navigator.of(context).push(
          CupertinoPageRoute(
              builder: (ctx) => WillPopScope(
                  onWillPop: () async {
                    if (Navigator.of(context).userGestureInProgress)
                      return false;
                    else
                      return true;
                  },
                  child: HomePage(key: myTabbedPageKey))),
        );
  }

  @override
  void dispose() {
    controller?.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
