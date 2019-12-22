import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../screens/authScreen.dart';
import 'dart:math';

class ProfileNotLoggedIn extends StatelessWidget {
  final showBackButton;
  ProfileNotLoggedIn({this.showBackButton = false});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
        iconTheme: IconThemeData(color: kMainColor),
        brightness: Brightness.light,
        elevation: 1,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: showBackButton,
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
         leading:  showBackButton ?  IconButton(
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
      ),
      body: Column(
        children: <Widget>[
          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     border: Border(
          //         bottom: BorderSide(color: kMainColor, width: 0.25)),
          //   ),
          //   height: 35.0,
          //   padding: EdgeInsets.only(left: 20),
          // ),
          // InkWell(
          //   onTap: () {
          //     Navigator.of(context).push(
          //       CupertinoPageRoute(
          //           builder: (ctx) => AuthPage(
          //                 pageState: "login",
          //               )),
          //     );
          //   },
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       border: Border(
          //           bottom: BorderSide(color: kMainColor, width: 0.25)),
          //     ),
          //     height: 50.0,
          //     padding: EdgeInsets.only(left: 20),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: <Widget>[
          //         Container(
          //           child: Icon(
          //             CupertinoIcons.padlock,
          //             size: 35,
          //             color: kMainColor,
          //           ),
          //         ),
          //         Container(
          //           padding: EdgeInsets.only(left: 25),
          //           child: Text(
          //             "Login",
          //             overflow: TextOverflow.ellipsis,
          //             maxLines: 1,
          //             style: TextStyle(
          //               fontSize: 15,
          //               color: kMainColor,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          profileCard(context, "Login", AuthPage(
                          pageState: "login",
                        )),
          profileCard(context, "Sign Up", AuthPage(
                          pageState: "signUp",
                        )),
          profileCard(context, "QIOSK.ca", null),
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
