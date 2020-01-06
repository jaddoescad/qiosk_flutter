import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:iamrich/Networking/Auth.dart';
import 'package:iamrich/constants.dart';
import 'package:iamrich/models/restaurant.dart';
import 'package:iamrich/screens/homePage.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';
import '../main.dart';
import 'package:flutter/cupertino.dart';
import '../models/orders.dart';
import '../Networking/Restaurant.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/errorMessage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:core';
import 'dart:async';
import '../screens/profile.dart';
import 'package:flutter/services.dart';
import '../widgets/Loader.dart';
import '../models/taxes.dart';
import '../screens/Orders.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:device_info/device_info.dart';

class QRViewExample extends StatefulWidget {
  static const routeName = '/QRView';
  @override
  QRViewExampleState createState() => QRViewExampleState();
}

class QRViewExampleState extends State<QRViewExample>
    with RouteAware, WidgetsBindingObserver {
  static final myTabbedPageKey = new GlobalKey<HomePageState>();
  bool cameraPermission = false;
  final PermissionHandler _permissionHandler = PermissionHandler();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  IosDeviceInfo iosInfo;

  bool _isloading = false;
  bool _disable = false;
  bool _settingsOpen = false;
  String loaderText = '';
  BarcodeDetector detector = FirebaseVision.instance.barcodeDetector();
  final _scanKey = GlobalKey<CameraMlVisionState>();

  fetchDeviceInfo() async {
    iosInfo = await deviceInfo.iosInfo;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fetchDeviceInfo();
    setState(() {
      loaderText = 'Launching...';
      _isloading = true;
      _disable = true;
    });
    Auth().checkIfUserExists(context).then((onValue) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _isloading = false;
          _disable = false;
        });
      });
    }).catchError((onError) {
      print(onError.toString());
      setState(() {
        _isloading = false;
        _disable = false;
      });
    });

    _permissionHandler
        .requestPermissions([PermissionGroup.camera]).then((result) {
      print('passed all permisions');

      //

      if (result[PermissionGroup.camera] == PermissionStatus.granted) {
        print('success');
        setState(() {
          cameraPermission = true;
        });
      } else {
        setState(() {
          cameraPermission = false;
        });
      }
      OneSignal.shared.promptUserForPushNotificationPermission();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_settingsOpen == true) {
        setState(() {
          _settingsOpen = false;
        });
        _permissionHandler
            .checkPermissionStatus(PermissionGroup.camera)
            .then((result) {
          if (result == PermissionStatus.granted) {
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
    }
  }

  Future _readBarcode(qrValue) async {
    if (_isloading == false && _disable == false) {
      setState(() {
        loaderText = 'Fetching Menu...';
        _isloading = true;
        _disable = true;
      });
      try {
        print(qrValue.split("/")[qrValue.split("/").length - 2]);
        await getMenuandOrders(
            qrValue.split("/")[qrValue.split("/").length - 2]);
        Future.delayed(const Duration(milliseconds: 500), () {
          goToHomePage();
        });
        // setState(() => _isloading = false);
      } catch (error) {
        print('error ${error.toString()}');
        await showErrorDialog(
            context, 'There was an error finding the restaurant');
        // startImageStream();
        setState(() {
          _isloading = false;
          _disable = false;
        });
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
    return ModalProgressHUD(
        child: Scaffold(
            backgroundColor: kMainColor,
            body: mounted && cameraPermission
                ? qrScannerView()
                : Scaffold(
                    backgroundColor: kMainColor,
                    appBar: AppBar(
                      brightness: Brightness.dark,
                      backgroundColor: Colors.transparent, //No more green
                      elevation: 0.0, //Shadow gone
                      centerTitle: true,
                      title: Image.asset(
                        'assets/images/logoappbar.png',
                        height: 20,
                      ),
                      actions: <Widget>[
                        IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors
                              .transparent, // makes highlight invisible too
                          icon: Image.asset(
                            'assets/images/invoice.png',
                            height: 30.0,
                            width: 30.0,
                          ),
                          onPressed: () {
                            if (_disable == false) {
                              setState(() {
                                _disable = true;
                              });
                              Navigator.of(context)
                                  .push(
                                CupertinoPageRoute(
                                    fullscreenDialog: true,
                                    builder: (ctx) {
                                      return OrderPage(
                                          showBackButton: true,
                                          loadOrders: true);
                                    }),
                              )
                                  .then((onValue) {
                                final orders =
                                    Provider.of<RestaurantOrders>(context);
                                orders.clear();
                              });
                            }
                          },
                        ),
                      ],
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
                              CupertinoPageRoute(
                                  fullscreenDialog: true,
                                  builder: (ctx) {
                                    return Profile();
                                  }),
                            );
                          }
                        },
                      ),
                    ),
                    body: Container(
                      child: Center(
                        heightFactor: 10,
                        child: FlatButton(
                          child: Text(
                              'Please press here to enable camera permissions',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                          onPressed: () async {
                            PermissionHandler()
                                .openAppSettings()
                                .then((bool hasOpened) async {
                              print(hasOpened);
                              if (hasOpened) {
                                setState(() {
                                  _settingsOpen = true;
                                });
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  )),
        inAsyncCall: _isloading,
        opacity: 0.2,
        color: Colors.white,
        progressIndicator: Loader(context: context, loaderText: loaderText));
  }

  Widget qrScannerView() {
    return Stack(fit: StackFit.expand, children: <Widget>[
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
        resolution: getResolution(),
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
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent, //No more green
        elevation: 0.0, //Shadow gone
        centerTitle: true,
        title: Image.asset(
          'assets/images/logoappbar.png',
          height: 20,
        ),
        actions: <Widget>[
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent, // makes highlight invisible too
            icon: Image.asset(
              'assets/images/invoice.png',
              height: 30.0,
              width: 30.0,
            ),
            onPressed: () {
              if (_disable == false) {
                setState(() {
                  _disable = true;
                });
                Navigator.of(context)
                    .push(
                  CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (ctx) {
                        return OrderPage(
                            showBackButton: true, loadOrders: true);
                      }),
                )
                    .then((onValue) {
                  final orders = Provider.of<RestaurantOrders>(context);
                  orders.clear();
                });
              }
            },
          ),
        ],
        leading: new IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent, // makes highlight invisible too
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
                CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (ctx) {
                      return Profile();
                    }),
              );
            }
          },
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Opacity(
              opacity: 1,
              child: Container(
                height: MediaQuery.of(context).size.width / 1.7,
                width: MediaQuery.of(context).size.width / 1.7,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/Scan.png'),
                )),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  ResolutionPreset getResolution() {
    double info = double.tryParse('${iosInfo.systemVersion[0]+iosInfo.systemVersion[1]}');
    print(iosInfo.systemVersion);
    if (info is double) {
      if (info < 13.0) {
        return ResolutionPreset.low;
      } else {
        return ResolutionPreset.medium;
      }
    } else {
      return ResolutionPreset.medium;
    }
  }

  Future<void> getMenuandOrders(rid) async {
    final FirebaseUser firuser = await FirebaseAuth.instance.currentUser();
    final data =
        await RestaurantNetworking.fetchMenuandOrders(rid, firuser?.uid);
    //get tax rate

    final restaurantOrders = Provider.of<RestaurantOrders>(context);
    final restaurant = Provider.of<Restaurant>(context);
    final tax = Provider.of<Taxes>(context);

    final menu = data[0];
    final _orders = data[1];
    final taxRate = data[2];

    tax.setTaxRate(taxRate);
    restaurant.loadRestaurant(rid, menu);
    restaurantOrders.addOrders(_orders);
  }

  void goToHomePage() {
    Navigator.of(context).push(
      CupertinoPageRoute(
          builder: (ctx) => WillPopScope(
              onWillPop: () async {
                // if (Navigator.of(context).userGestureInProgress)
                return false;
                // else
                // return true;
              },
              child: HomePage(key: myTabbedPageKey))),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);

    super.dispose();
  }
}
