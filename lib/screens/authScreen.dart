import 'package:flutter/material.dart';
import 'package:iamrich/screens/signUpPage.dart';
import '../screens/loginPage.dart';


class AuthPage extends StatefulWidget {

  final String pageState;
  final String cameFrom;
  AuthPage({this.pageState, this.cameFrom});



  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  
  String pageState;

  @override
  void initState() {
    super.initState();
        pageState = widget.pageState;
    }
  
  void changePage(String pageString) {
    setState(() {
      pageState = pageString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (pageState == "login")
        ? LoginPage(changePageCallback: changePage, cameFrom: widget.cameFrom,)
        : SignUpPage(changePageCallback: changePage, cameFrom: widget.cameFrom,);
  }
}