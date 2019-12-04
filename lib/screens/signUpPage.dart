import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/socialButton.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/SignUp';

  final Function changePageCallback;
  SignUpPage({this.changePageCallback});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  _SignUpData _data = new _SignUpData();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  /// Normally the signin buttons should be contained in the SignInPage
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: kMainColor,
          title: new Text('Sign Up'),
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
                // // SocialButton(Color(0xffDD4B39), "Sign in with Google",
                // //     "assets/images/google.png"),
                //     SizedBox(height: 20,),
                Row(children: <Widget>[
                  Expanded(child: Divider()),
                  Text(
                    "Sign Up With Email",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff365e7a)),
                  ),
                  Expanded(child: Divider()),
                ]),

                TextFormField(
                    onSaved: (String value) {
                      this._data.name = value;
                    },
                    validator: this._validateName,
                    keyboardType:
                        TextInputType.text, // Use email input type for emails.
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: COlors.)),
                      hintText: '',
                      labelText: 'Name',
                    )),

                TextFormField(
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

                TextFormField(
                    onSaved: (String value) {
                      this._data.password = value;
                    },
                    validator: this._validatePassword,
                    obscureText: true, // Use secure text for passwords.
                    decoration: new InputDecoration(
                        hintText: '', labelText: 'Enter your password')),
                new Container(
                  width: screenSize.width,
                  height: 50,
                  // color: Color(0xff365e7a),
                  child: new FlatButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: new Text(
                      'Sign Up',
                      style: new TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    onPressed: () {
                      this.submit();
                      // Navigator.popUntil(context, ModalRoute.withName('/screen2'));
                    },
                    color: Color(0xff365e7a),
                  ),
                  margin: new EdgeInsets.only(top: 20.0),
                ),

                Container(
                    padding: EdgeInsets.only(left: 40, right: 40, top: 10),
                    child: Text(
                      "By signing up, you agree with the Terms of Services & Privacy",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Need to Login?  ",
                        style: TextStyle(
                            color: Color(0xff365e7a),
                            fontWeight: FontWeight.w300)),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Color(0xff365e7a),
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        widget
                            .changePageCallback("login"); // function is called
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

  String _validateName(String value) {
    bool nameValid = RegExp('[a-zA-Z]').hasMatch(value);
    if (!nameValid) {
      return 'The name you entered is invalid';
    }
    return null;
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

  void submit() {
    print("hello");
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      print('Printing the login data.');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');
      print('Name: ${_data.name}');
    }
  }
}

class _SignUpData {
  String name = '';
  String email = '';
  String password = '';
}