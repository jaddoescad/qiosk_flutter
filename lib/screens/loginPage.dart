import 'package:flutter/material.dart';
import 'package:iamrich/screens/signUpPage.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

typedef void ChangeAuthPage(String pageString);

class AuthPage extends StatefulWidget {

  final String pageState;
  AuthPage({this.pageState});

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
    print("changing auth");
    setState(() {
      pageState = pageString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (pageState == "login")
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
  final _auth = FirebaseAuth.instance;

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
                        widget
                            .changePageCallback("signUp"); // function is called
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
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      print('Printing the login data.');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');

      try {
        await _auth.signInWithEmailAndPassword(
            email: _data.email, password: _data.password);
      } catch (e) {
        print(e);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Error"),
                content: new Text(e.toString()),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      } finally {
        final user = Provider.of<User>(context);
        FirebaseAuth.instance.currentUser().then((firebaseUser) {
          if (firebaseUser != null) {
            user.changeUID(firebaseUser.uid);
            Navigator.of(context).pop();
          }
        });
      }
    }
  }
}

class _LoginData {
  String email = '';
  String password = '';
}