import 'package:flutter/material.dart';
import 'package:iamrich/Networking/Auth.dart';
import 'package:iamrich/screens/homePage.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../main.dart';
import 'package:flutter/cupertino.dart';


class QRViewExample extends StatefulWidget {
  static const routeName = '/QRView';
  @override
  _QRViewExampleState createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> with RouteAware {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  bool _isloading = false;
  QRViewController controller;
  
  @override
  void initState() {
    // TODO: implement initState
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
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      if (!_isloading) {
        setState(() => _isloading = !_isloading);
        Navigator.of(context).push(
          CupertinoPageRoute(
              builder: (ctx) => WillPopScope(
                  onWillPop: () async {
                    if (Navigator.of(context).userGestureInProgress)
                      return false;
                    else
                      return true;
                  },
                  child: HomePage())),
        );
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}