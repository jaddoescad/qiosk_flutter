import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/authScreen.dart';
import 'package:iamrich/constants.dart';

class ProfileNotLoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF365e7a),
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
        ),
      ),
      body: Column(
        children: <Widget>[
                Container(
                  color: kSectionColor,
                  height: 50.0,
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Guest",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xFF365e7a),
                        ),
                      )),
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
              ),
              height: 55.0,
              padding: EdgeInsets.only(left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Icon(
                      CupertinoIcons.padlock_solid,
                      size: 30,
                      color: Color(0xFF365e7a),
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
                        color: Color(0xFF365e7a),
                        fontWeight: FontWeight.bold,
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
              ),
              height: 55.0,
              padding: EdgeInsets.only(left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Icon(
                      CupertinoIcons.person_add_solid,
                      size: 30,
                      color: Color(0xFF365e7a),
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
                        color: Color(0xFF365e7a),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: 55.0,
            padding: EdgeInsets.only(left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Icon(
                    CupertinoIcons.mail_solid,
                    size: 30,
                    color: Color(0xFF365e7a),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "Contact Us",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF365e7a),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: 55.0,
            padding: EdgeInsets.only(left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.info,
                    size: 30,
                    color: Color(0xFF365e7a),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "About Us",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF365e7a),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
