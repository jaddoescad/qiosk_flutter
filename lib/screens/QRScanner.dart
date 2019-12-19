import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:iamrich/Networking/Auth.dart';
import 'package:iamrich/models/restaurant.dart';
import 'package:iamrich/screens/homePage.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';
import '../main.dart';
import 'package:flutter/cupertino.dart';
import '../models/orders.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../Networking/Restaurant.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/errorMessage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:core';
import 'dart:async';
import '../models/user.dart';
import '../screens/profile.dart';
import 'package:flutter/services.dart';

class QRViewExample extends StatefulWidget {
  static const routeName = '/QRView';
  @override
  QRViewExampleState createState() => QRViewExampleState();
}

class QRViewExampleState extends State<QRViewExample> with RouteAware {
  static final myTabbedPageKey = new GlobalKey<HomePageState>();
  bool cameraPermission = false;
  final PermissionHandler _permissionHandler = PermissionHandler();

  bool _isloading = false;
  bool _disable = false;
  BarcodeDetector detector = FirebaseVision.instance.barcodeDetector();
  final _scanKey = GlobalKey<CameraMlVisionState>();

  @override
  void initState() {
    super.initState();
    try {
      Auth().checkIfUserExists(context);
    } catch (e) {
      print(e);
    }
    _permissionHandler
        .requestPermissions([PermissionGroup.camera]).then((result) {
      if (result[PermissionGroup.camera] == PermissionStatus.granted) {
        setState(() {
          cameraPermission = true;
        });
        // permission was granted
      } else {
        setState(() {
          cameraPermission = false;
        });
      }
    });
  }

  Future _readBarcode(qrValue) async {
    if (_isloading == false && _disable == false) {
      setState(() {
_isloading = true;
_disable = true;
      } );
      try {
        await getMenuandOrders("KYnIcMxo6RaLMeIlhh9u");
        Future.delayed(const Duration(milliseconds: 500), () {
          goToHomePage();
        });
        // setState(() => _isloading = false);
      } on CloudFunctionsException catch (error) {
        print('error ${error.message}');
        showErrorDialog(
            context, 'there was an error: ${error.message.toString()}');
        // startImageStream();
        setState(() => _isloading = false);
      } catch (error) {
        print('error ${error.toString()}');
        showErrorDialog(context, 'there was an error: ${error.toString()}');
        // startImageStream();
        setState(() => _isloading = false);
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPopNext() {
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      setState(() {
        _disable = false;
      });
    });
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return mounted
        ? qrScannerView()
        : Scaffold(
            body: Container(
              child: Center(
                child: FlatButton(
                  child: Text('Please press to activate Camera'),
                  onPressed: () async {
                    bool isOpened = await PermissionHandler().openAppSettings();

                    PermissionStatus permission = await PermissionHandler()
                        .checkPermissionStatus(PermissionGroup.camera);

                    if (permission == PermissionStatus.granted) {
                      print("here");
                      setState(() {
                        cameraPermission = true;
                      });
                      // permission was granted
                    } else {
                      setState(() {
                        cameraPermission = false;
                      });
                    }
                  },
                ),
              ),
            ),
          );
  }

  ModalProgressHUD qrScannerView() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
   statusBarColor: Colors.black, // Color for Android
   statusBarBrightness: Brightness.light // Dark == white status bar -- for IOS.
));
    return ModalProgressHUD(
        child: Scaffold(
          body: Stack(fit: StackFit.expand, children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Color(0xff131111),
            ),
            CameraMlVision<List<Barcode>>(
              // loadingBuilder: ,
              loadingBuilder: (c) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Color(0xff131111),
                );
              },
              resolution: ResolutionPreset.medium,
              key: _scanKey,

              detector: detector.detectInImage,
              onResult: (barcodes) {
                if (barcodes == null ||
                    barcodes.isEmpty ||
                    !mounted ||
                    _isloading ||
                    _disable) {
                  return;
                }
                _readBarcode(barcodes.first.displayValue);
              },
              onDispose: () {
                detector.close();
              },
            ),
            AppBar(
              backgroundColor: Colors.transparent, //No more green
              elevation: 0.0, //Shadow gone
              centerTitle: true,
              title: Image.asset(
                'assets/images/logoappbar.png',
                height: 20,
              ),
              leading: new IconButton(
                splashColor: Colors.transparent,
                highlightColor:
                    Colors.transparent, // makes highlight invisible too
                icon: Image.asset(
                  'assets/images/profile.png',
                  height: 30.0,
                  width: 30.0,
                ),
                onPressed: () {
                  if (_disable == false) {
                    setState(() {
                      _disable = true;
                    });
                    Navigator.of(context).push(
                      CupertinoPageRoute(builder: (ctx) {
                        return Profile();
                      }),
                    );
                  }
                },
              ),
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
        ),
        inAsyncCall: _isloading,
        opacity: 0.5,
        color: Colors.white,
        progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kMainColor)));
  }

  Future<void> getMenuandOrders(rid) async {
    final FirebaseUser firuser = await FirebaseAuth.instance.currentUser();
    final data =
        await RestaurantNetworking.fetchMenuandOrders(rid, firuser?.uid);
    final restaurantOrders = Provider.of<RestaurantOrders>(context);
    final restaurant = Provider.of<Restaurant>(context);

    final menu = data[0];
    final _orders = data[1];

    restaurant.loadRestaurant(rid, menu);
    restaurantOrders.addOrders(_orders);
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
    super.dispose();
    routeObserver.unsubscribe(this);
  }
}
