import 'package:flutter/material.dart';
import 'package:iamrich/Networking/Auth.dart';
import 'package:iamrich/models/restaurant.dart';
import 'package:iamrich/screens/homePage.dart';
import 'package:provider/provider.dart';
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
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'dart:async';

class QRViewExample extends StatefulWidget {
  static const routeName = '/QRView';
  @override
  QRViewExampleState createState() => QRViewExampleState();
}

class QRViewExampleState extends State<QRViewExample> with RouteAware {
  QRReaderController controller;
  var qrText = "";
  bool _isloading = false;
  static final myTabbedPageKey = new GlobalKey<HomePageState>();
  bool cameraPermission = false;
  final PermissionHandler _permissionHandler = PermissionHandler();
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
    setState(() => _isloading = false);

    if (controller != null) {
      // controller.resumeCamera();
    }
  }
  @override
  void initState() {
    super.initState();

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


    controller = new QRReaderController(
        cameras[0], ResolutionPreset.medium, [CodeFormat.qr], (dynamic value) async {

      print(value); // the result!

      if (_isloading == false) {
        // controller.pauseCamera();
        // qrText = scanData;
        setState(() => _isloading = true);
        try {
          await getMenuandOrders("KYnIcMxo6RaLMeIlhh9u");
          goToHomePage();
          // setState(() => _isloading = false);
        } on CloudFunctionsException catch (error) {
          print('error ${error.message}');
          showErrorDialog(
              context, 'there was an error: ${error.message.toString()}');
          setState(() => _isloading = false);
        } catch (error) {
          print('error ${error.toString()}');
          showErrorDialog(context, 'there was an error: ${error.toString()}');
          setState(() => _isloading = false);
        }
      }


      // ... do something
      // wait 3 seconds then start scanning again.
      new Future.delayed(const Duration(seconds: 3), controller.startScanning);
    });
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      controller.startScanning();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
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

    @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return new Container();
    }
    return cameraPermission ?  qrScannerView():cameraDeniedWidget() ;
  }

    Scaffold cameraDeniedWidget() {
      return Scaffold(
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
    return ModalProgressHUD(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent, //No more green
            elevation: 0.0, //Shadow gone
            title: Text(
              "QIOSK",
              style: TextStyle(fontFamily: "Avenir"),
            ),
            leading: new IconButton(
              splashColor: Colors.transparent,
              highlightColor:
                  Colors.transparent, // makes highlight invisible too
              icon: Image.asset(
                'assets/images/profile.png',
                height: 35.0,
                width: 35.0,
              ),
              onPressed: () => null,
            ),
          ),


          body: 
          
          Stack(children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: 
                  
                  
      AspectRatio(
        aspectRatio:
        controller.value.aspectRatio,
        child: new QRReaderPreview(controller))




                  
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
        ),
        inAsyncCall: _isloading,
        opacity: 0.5,
        color: Colors.white,
        progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kMainColor)));
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) async {


  //     if (_isloading == false) {
  //       controller.pauseCamera();
  //       qrText = scanData;
  //       setState(() => _isloading = true);
  //       try {
  //         await getMenuandOrders("KYnIcMxo6RaLMeIlhh9u");
  //         goToHomePage();
  //         // setState(() => _isloading = false);
  //       } on CloudFunctionsException catch (error) {
  //         print('error ${error.message}');
  //         showErrorDialog(
  //             context, 'there was an error: ${error.message.toString()}');
  //         setState(() => _isloading = false);
  //       } catch (error) {
  //         print('error ${error.toString()}');
  //         showErrorDialog(context, 'there was an error: ${error.toString()}');
  //         setState(() => _isloading = false);
  //       }
  //     }


  //   });
  // }



}