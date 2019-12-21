import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:flutter/cupertino.dart';
import '../screens/account.dart';
import 'dart:math';


class Legal extends StatefulWidget {
  final showBackButton;
  Legal({this.showBackButton = false});
  @override
  _LegalState createState() => _LegalState();
}

class _LegalState extends State<Legal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBodyBackground,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kMainColor),
        brightness: Brightness.light,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: kMainColor,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          profileCard(context, 'Copyright', Account() ),
          profileCard(context, 'Terms & Conditions', Account() ),

          profileCard(context, 'Privacy Policy', Account() ),

          profileCard(context, 'Software Licenses', Account()),
          profileCard(context, 'Pricing', Account()),

        ],
      ),
    );
  }

  Container profileCard(BuildContext context, String title, Widget page) {
    return Container(
          decoration: BoxDecoration(
            color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: kMainColor.withOpacity(0.5), width: 0.5))),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Positioned(
                  left: 20,
                  child: Text(title,
                      style: TextStyle(fontWeight: FontWeight.w800))),
              Positioned(
                right: 20,
                child: Transform.rotate(
                    angle: 180 * pi / 180,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    )),
              ),
                FlatButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  // color: Colors.white,
                  child: Container(
                    width: double.infinity,
                    height: 75,
                  ),
                  onPressed: null
                ),
            ],
          ),
        );
  }
}
