import 'package:flutter/material.dart';
import 'package:iamrich/screens/menu.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../main.dart';

class QRViewExample extends StatefulWidget {
  var state;
  @override
  _QRViewExampleState createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample>  with RouteAware {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  _QRViewExampleState({this.state});
  var state = false;
  var qrText = "";
  bool _isloading = false;
  QRViewController controller;

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
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
        if (!_isloading) {
        setState(() => _isloading = !_isloading);
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => Menu()),
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