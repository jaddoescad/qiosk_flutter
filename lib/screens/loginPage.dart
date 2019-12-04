import 'package:flutter/material.dart';
import 'package:iamrich/screens/cartPage.dart';
import 'package:iamrich/screens/signUpPage.dart';
import '../constants.dart';
import '../widgets/socialButton.dart';
import '../util/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

typedef void ChangeAuthPage(String pageString);

class AuthPage extends StatefulWidget {
  // AuthPage({this.pageState = "login"});
  String pageState = "login";
  AuthPage({this.pageState});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  void changePage(String pageString) {
    setState(() {
      widget.pageState = pageString;
      //   widget.pageState = pageString;
    });
  }


  @override
  Widget build(BuildContext context) {
    return (widget.pageState == "login")
        ? LoginPage(changePageCallback: changePage)
        : SignUpPage(changePageCallback: changePage);
  }
}

class LoginPage extends StatefulWidget {
  static const routeName = '/Login';
  final Function changePageCallback;
  LoginPage({this.changePageCallback});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();

  /// Normally the signin buttons should be contained in the SignInPage
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
                // // SocialButton(Color(0xff3C579E), "Sign in with Facebook",
                // //     "assets/images/facebook.png"),
                // SizedBox(height: 5),
                // SocialButton(Color(0xffDD4B39), "Sign in with Google",
                //     "assets/images/google.png", authWithGoogle),
                // SizedBox(height: 20),
                 Row(children: <Widget>[
                  Expanded(child: Divider()),
                  Text(
                    "Login With Email",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff365e7a)),
                  ),
                  Expanded(child: Divider()),
                ]),
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
                        hintText: '',
                        labelText: 'Enter your password')),
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
                    print("recover password");
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
                        widget.changePageCallback("signUp"); // function is called
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


void authWithGoogle() {
  print("authing");
  // _LoginPageState.of(context).signInWithGoogle();
}

    String _validateEmail(String value) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);   
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
    void submit() {
      print("hello");
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      print('Printing the login data.');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');
    }
  }
}

Widget _buildPage(BuildContext context) {
  return SignUpPage();
}


class _LoginData {
  String email = '';
  String password = '';
}