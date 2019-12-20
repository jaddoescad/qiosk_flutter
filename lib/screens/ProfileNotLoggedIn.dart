import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../screens/authScreen.dart';

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
          automaticallyImplyLeading: showBackButton,
          backgroundColor: kMainColor,
          title: Text(
            "Profile",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
           leading: new IconButton(
              splashColor: Colors.transparent,
              highlightColor:
                  Colors.transparent, // makes highlight invisible too
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
              onPressed: () {
                //add to cart
                Navigator.of(context).pop();
              },
            ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: kMainColor, width: 0.25)),
            ),
            height: 35.0,
            padding: EdgeInsets.only(left: 20),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                    builder: (ctx) => AuthPage(
                          pageState: "login",
                        )),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: kMainColor, width: 0.25)),
              ),
              height: 50.0,
              padding: EdgeInsets.only(left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Icon(
                      CupertinoIcons.padlock,
                      size: 35,
                      color: kMainColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      "Login",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15,
                        color: kMainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                    builder: (ctx) => AuthPage(
                          pageState: "signUp",
                        )),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: kMainColor, width: 0.25)),
              ),
              height: 50.0,
              padding: EdgeInsets.only(left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Icon(
                      CupertinoIcons.person_add,
                      size: 35,
                      color: kMainColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      "Create Account",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15,
                        color: kMainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // Navigator.of(context).push(
              //   CupertinoPageRoute(
              //       builder: (ctx) => AboutUs()
                        
              //           ),
              // );
            },
                      child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: kMainColor, width: 0.25)),
              ),
              height: 50.0,
              padding: EdgeInsets.only(left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Icon(
                      CupertinoIcons.mail,
                      size: 35,
                      color: kMainColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      "QIOSK.ca",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15,
                        color: kMainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
