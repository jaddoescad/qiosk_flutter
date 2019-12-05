import 'package:flutter/material.dart';
import 'package:iamrich/screens/QRScanner.dart';
// import 'package:splashscreen/splashscreen.dart';
// import '../screens/QRScanner.dart';
import '../util/helper.dart';


class Splash extends StatefulWidget {
  @override
  _Splash createState() => new _Splash();
}

class _Splash extends State<Splash> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 3),
        () => 
        
        Navigator.push(context, FadeRoute(page: QRViewExample()))

        // Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => QRViewExample()),
        //     )
            
            
            );
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