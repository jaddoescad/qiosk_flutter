import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../Networking/Auth.dart';
import '../models/goToCheckout.dart';
import '../widgets/errorMessage.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/SignUp';
   
  final Function changePageCallback;
  final String cameFrom;
  SignUpPage({this.changePageCallback, this.cameFrom});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
 
  _SignUpData _data = new _SignUpData();
  var authHandler = Auth();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool loader = false;
  /// Normally the signin buttons should be contained in the SignInPage
  @override
  Widget build(BuildContext context) {
  print(widget.cameFrom);
  
    final Size screenSize = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: loader,
          child: Scaffold(
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

  void submit() async {
    if (this._formKey.currentState.validate()) {
      setState(() {
        loader = true;
      });

      try {
        _formKey.currentState.save();
        await authHandler.handleSignUp(_data.email, _data.password, context, _data.name);
        await Future.delayed(const Duration(milliseconds: 500), (){});
        setState(() {
            loader = false;
          });
        if (widget.cameFrom == "cart") {

          final goToCheckout = Provider.of<GoToCheckout>(context);
          goToCheckout.setGoToCheckout(true);
        }
           Navigator.of(context).pop();
        setState(() {
          loader = false;
        });
      } catch(error) {
        setState(() {
          loader = false;
        });
      showErrorDialog(context, 'there was an error: ${error.toString()}');
      print(error);
      }
    }
     
    }
  }

class _SignUpData {
  String name = '';
  String email = '';
  String password = '';
}
