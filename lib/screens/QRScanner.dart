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
import '../Networking/Restaurant.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/errorMessage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:core';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class QRViewExample extends StatefulWidget {
  static const routeName = '/QRView';
  @override
  QRViewExampleState createState() => QRViewExampleState();
}

class QRViewExampleState extends State<QRViewExample> with RouteAware {
  // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  static final myTabbedPageKey = new GlobalKey<HomePageState>();
  bool cameraPermission = false;
  final PermissionHandler _permissionHandler = PermissionHandler();

  Timer _timer;
  String _barcodeRead = "";
  bool _isloading = false;
  CameraController controller;

  @override
  void initState() {
    super.initState();
    Auth().checkIfUserExists(context);
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
    controller = CameraController(cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      _startTimer();
    });
  }

  void _startTimer() {
    _timer = new Timer(Duration(milliseconds: 500), _timerElapsed);
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  Future<void> _timerElapsed() async {
    _stopTimer();

    // Code to capture image and read barcode here...
    File file = await _takePicture();
    await _readBarcode(file);

    _startTimer();
  }

  Future<File> _takePicture() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/barcode';
    await Directory(dirPath).create(recursive: true);
    final File file = new File('$dirPath/barcode.jpg');

    if (await file.exists()) await file.delete();

    await controller.takePicture(file.path);
    return file;
  }

  Future _readBarcode(File file) async {
    FirebaseVisionImage firebaseImage = FirebaseVisionImage.fromFile(file);
    final BarcodeDetector barcodeDetector =
        FirebaseVision.instance.barcodeDetector();

    final List<Barcode> barcodes =
        await barcodeDetector.detectInImage(firebaseImage);

    _barcodeRead = "";
    for (Barcode barcode in barcodes) {
      _barcodeRead += barcode.rawValue + ", ";
    }

    if (_isloading == false && _barcodeRead != "") {
      // controller.stopImageStream();
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
    setState(() => _isloading = false);

    // if (controller != null) {
    //   controller.stopImageStream();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return cameraPermission
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
    return ModalProgressHUD(
        child: Scaffold(
          body: Stack(children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(child: CameraPreview(controller))

                // child: QRView(
                //   key: qrKey,
                //   onQRViewCreated: _onQRViewCreated,
                // ),
              ],
            ),
            AppBar(
              backgroundColor: Colors.transparent, //No more green
              elevation: 0.0, //Shadow gone
              centerTitle: true,
              // title: Text(
              //   "QIOSK",
            title: Image.asset('assets/images/logoappbar.png', height: 20,),
            // Text('QIOSK',style: TextStyle(fontFamily: 'Avenir')),
                // style: TextStyle(fontFamily: "Avenir"),
              // ),
              leading: new IconButton(
                splashColor: Colors.transparent,
                highlightColor:
                    Colors.transparent, // makes highlight invisible too
                icon: Image.asset(
                  'assets/images/profile.png',
                  height: 30.0,
                  width: 30.0,
                ),
                onPressed: () => null,
              ),
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
    controller?.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
