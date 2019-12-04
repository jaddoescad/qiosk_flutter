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
        padding: new EdgeInsets.only(left: 30.0, right: 30.0),
        child: Form(
          key: this._formKey,
          child: Theme(
            data: Theme.of(context).copyWith(splashColor: Colors.transparent),
            child: new ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 20),
                SocialButton(Color(0xff3C579E), "Sign in with Facebook",
                    "assets/images/facebook.png"),
                SizedBox(height: 10),
                SocialButton(Color(0xffDD4B39), "Sign in with Google",
                    "assets/images/google.png"),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 10),
                Text(
                  "Sign Up With Email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff365e7a)),
                ),
                SizedBox(height: 10),
                TextFormField(
                    keyboardType: TextInputType
                        .text, // Use email input type for emails.
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: COlors.)),
                      hintText: 'John Doe',
                      labelText: 'Name',
                    )),
                SizedBox(height: 10),
                TextFormField(
                    keyboardType: TextInputType
                        .emailAddress, // Use email input type for emails.
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: COlors.)),
                      hintText: 'you@example.com',
                      labelText: 'E-mail Address',
                    )),
                                    SizedBox(height: 10),
                TextFormField(
                    obscureText: true, // Use secure text for passwords.
                    decoration: new InputDecoration(
                        hintText: 'Password',
                        labelText: 'Enter your password')),
                SizedBox(height: 10),
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
                      // Navigator.popUntil(context, ModalRoute.withName('/screen2'));
                        },
                    color: Color(0xff365e7a),
                  ),
                  margin: new EdgeInsets.only(top: 20.0),
                ),
                SizedBox(height: 10),

                Container(
                  padding: EdgeInsets.only(left:40, right: 40),
                  child: Text("By signing up, you agree with the Terms of Services & Privacy", textAlign: TextAlign.center, style: TextStyle(fontSize: 12),))
              
              ,
              SizedBox(height: 20,),
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
                        widget.changePageCallback("login"); // function is called
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
}
