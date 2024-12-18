import 'package:flutter/material.dart';
import 'package:iamrich/screens/QRScanner.dart';
import '../util/helper.dart';
import '../Networking/Auth.dart';
import 'package:iamrich/constants.dart';


class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);
  
  @override
  _Splash createState() => new _Splash();
}

class _Splash extends State<Splash> {

  @override
  void initState() {
    super.initState();

    new Future.delayed(
        const Duration(seconds: 0),
        () {

        Navigator.pushReplacement(context, FadeRoute(page: QRViewExample()));

         
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: kMainColor,
      body: Container(
        child: new Column(children: <Widget>[
          Divider(
            height: 240.0,
            color: Colors.white,
          ),
          new Image.asset(
            'assets/images/logoappbar.png',
            fit: BoxFit.cover,
            repeat: ImageRepeat.noRepeat,
            width: 200.0,
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