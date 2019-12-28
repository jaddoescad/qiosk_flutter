import 'package:flutter/material.dart';
import 'package:iamrich/screens/QRScanner.dart';
import '../util/helper.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Networking/Auth.dart';


class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);
  
  @override
  _Splash createState() => new _Splash();
}

class _Splash extends State<Splash> {
  final PermissionHandler _permissionHandler = PermissionHandler();

  @override
  void initState() {
    super.initState();
        try {
      Auth().checkIfUserExists(context);
    } catch (e) {
      //do not out alertdialog here
      print(e);
    }
    new Future.delayed(
        const Duration(seconds: 3),
        () {
           _permissionHandler
         .requestPermissions([PermissionGroup.camera]).then((result) {
        Navigator.pushReplacement(context, FadeRoute(page: QRViewExample()));
         });
         
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: new Column(children: <Widget>[
          Divider(
            height: 240.0,
            color: Colors.white,
          ),
          new Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
            repeat: ImageRepeat.noRepeat,
            width: 170.0,
          ),
          Divider(
            height: 105.2,
            color: Colors.white,
          ),
        ]),
      ),
    );
  }
}