import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../Networking/Auth.dart';
import '../widgets/errorMessage.dart';
import '../widgets/Loader.dart';

class ResetPasswordPage extends StatefulWidget {
  static const routeName = '/resetPassword';

  final Function changePageCallback;
  ResetPasswordPage({this.changePageCallback});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  var authHandler = Auth();
  String pageState = "reset";
  final loaderText = 'Resetting Password';

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool loader = false;
  _ResetData _data = new _ResetData();

  /// Normally the signin buttons should be contained in the SignInPage
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return ModalProgressHUD(
      progressIndicator: Loader(context: context, loaderText: loaderText),
      inAsyncCall: loader,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: kMainColor),
          brightness: Brightness.light,
          elevation: 1,
          backgroundColor: Colors.white,
          title: Text(
            "Reset Password",
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
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent, // makes highlight invisible too
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
        body: (pageState == "reset")
            ? resetPassword(context, screenSize)
            : Center(
                child: Text("We've sent you an email to reset your password")),
      ),
    );
  }

  Container resetPassword(BuildContext context, Size screenSize) {
    return Container(
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
              SizedBox(
                height: 40,
              ),
              TextFormField(
                  onSaved: (String value) {
                    _data.email = value;
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
              new Container(
                width: screenSize.width,
                height: 50,
                // color: kMainColor,
                child: new FlatButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: new Text(
                    'Reset Password',
                    style: new TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  onPressed: () {
                    this.submit();
                    // Navigator.popUntil(context, ModalRoute.withName('/screen2'));
                  },
                  color: kMainColor,
                ),
                margin: new EdgeInsets.only(top: 20.0),
              ),
            ],
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

  void submit() async {
    if (this._formKey.currentState.validate()) {
      setState(() {
        loader = true;
      });
      _formKey.currentState.save();

      final auth = Auth();

      try {
        await auth.sendPasswordResetEmail(_data.email);
        setState(() {
          loader = false;
          pageState = "resetting";
        });
      } catch (error) {
        print(error);
        showErrorDialog(context, 'There was an error resetting your password}');
        setState(() {
          loader = false;
        });
      }
    }
  }
}

class _ResetData {
  String email = '';
}
