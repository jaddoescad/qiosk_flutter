import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:flutter/cupertino.dart';
import '../screens/account.dart';
import '../screens/wallet.dart';
import 'dart:math';
import '../screens/Legal.dart';


class ProfileLoggedIn extends StatefulWidget {
  final bool showBackButton;
  ProfileLoggedIn({this.showBackButton = false});
  @override
  _ProfileLoggedInState createState() => _ProfileLoggedInState();
}

class _ProfileLoggedInState extends State<ProfileLoggedIn> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Scaffold(
      backgroundColor: kBodyBackground,
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kMainColor),
        brightness: Brightness.light,
        elevation: 1,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: widget.showBackButton,
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
         leading:  widget.showBackButton ?  IconButton(
              splashColor: Colors.transparent,
              highlightColor:
                  Colors.transparent, // makes highlight invisible too
              icon: Icon(
                Icons.close,
                size: 20,
              ),
              onPressed: () {
                //add to cart
                Navigator.of(context).pop();
              },
            ) : null,
      ),
      body: ListView(
        children: <Widget>[
          profileCard(context, 'Account', Account() ),
          profileCard(context, 'Wallet', Wallet() ),

          profileCard(context, 'Legal', Legal() ),
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
                  onPressed: () {
                    if (page != null) {
                   Navigator.of(context).push(
                        CupertinoPageRoute(builder: (ctx) => page));
                  }
                    }
 
                ),
            ],
          ),
        );
  }
  
}
