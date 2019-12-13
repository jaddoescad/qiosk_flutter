import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../Networking/Auth.dart';
import '../widgets/errorMessage.dart';
import 'package:flutter/cupertino.dart';
import '../screens/resetPassword.dart';
import '../models/goToCheckout.dart';

typedef void ChangeAuthPage(String pageString);

class LoginPage extends StatefulWidget {
  static const routeName = '/Login';
  final Function changePageCallback;
  final String cameFrom;
  LoginPage({this.changePageCallback, this.cameFrom});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();
  bool loader = false;
  var authHandler = Auth(); 

  /// Normally the signin buttons should be contained in the SignInPage
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: loader,
      child: Scaffold(
        appBar: new AppBar(
            backgroundColor: kMainColor,
            title: new Text('Login'),
            centerTitle: true,
            leading: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )),
        body: Container(
          // color: Colors.red,
          height: double.infinity,
          padding: new EdgeInsets.only(left: 40.0, right: 40.0),
          child: Form(
            key: this._formKey,
            child: Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.transparent),
              child: new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(height: 30),
                  Container(
                    child: new TextFormField(
                        onSaved: (String value) {
                          this._data.email = value;
                        },
                        validator: this._validateEmail,
                        keyboardType: TextInputType
                            .emailAddress, // Use email input type for emails.
                        decoration: new InputDecoration(
                          fillColor: Colors.white,
                          // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: COlors.)),
                          hintText: '',
                          labelText: 'E-mail Address',
                        )),
                  ),
                  new TextFormField(
                      onSaved: (String value) {
                        this._data.password = value;
                      },
                      validator: this._validatePassword,
                      obscureText: true, // Use secure text for passwords.
                      decoration: new InputDecoration(
                          hintText: '', labelText: 'Enter your password')),
                  // SizedBox(height: 10),
                  new Container(
                    width: screenSize.width,
                    height: 50,
                    // color: Color(0xff365e7a),
                    child: new FlatButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: new Text(
                        'Login',
                        style: new TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      onPressed: () {
                        submit();
                      },
                      color: Color(0xff365e7a),
                    ),
                    margin: new EdgeInsets.only(top: 20.0),
                  ),
                  FlatButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    color: Colors.transparent,
                    child: Text("Forgot your password?",
                        style: TextStyle(
                            color: Color(0xff365e7a),
                            fontWeight: FontWeight.w500)),
                    onPressed: () {
                              Navigator.of(context).push(CupertinoPageRoute(builder: (ctx) => ResetPasswordPage()));
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Need an Account?  ",
                          style: TextStyle(
                              color: Color(0xff365e7a),
                              fontWeight: FontWeight.w300)),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Color(0xff365e7a),
                              fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          widget.changePageCallback(
                              "signUp"); // function is called
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  String _validateEmail(String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid) {
      return 'The Email Address must be a valid email address.';
    }
    return null;
  }

  // Add validate password function.
  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }

    return null;
  }

  void submit() async {
    //

    if (this._formKey.currentState.validate()) {
      setState(() {
        loader = true;
      });
      _formKey.currentState.save(); // Save our form now.
      await authHandler
          .handleSignInEmail(_data.email, _data.password, context)
          .then((FirebaseUser user) async {
        await Future.delayed(const Duration(milliseconds: 500), (){});
        setState(() {
          loader = false;
        });
        if (widget.cameFrom == "cart") {
          final goToCheckout = Provider.of<GoToCheckout>(context);
          goToCheckout.setGoToCheckout(true);
        }

        Navigator.of(context).pop();

      }).catchError((e) {
        setState(() {
          loader = false;
        });
        print(e);
      });
    }
  }
}

class _LoginData {
  String email = '';
  String password = '';
}
