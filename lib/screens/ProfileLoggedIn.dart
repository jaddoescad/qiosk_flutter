import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';
import '../Networking/Payments.dart';
import '../models/payment.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

class ProfileLoggedIn extends StatefulWidget {
  @override
  _ProfileLoggedInState createState() => _ProfileLoggedInState();
}

class _ProfileLoggedInState extends State<ProfileLoggedIn> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      body: Row(
        children: <Widget>[
          Divider(),
          RaisedButton(
            child: Text("Create Token with Card Form"),
            onPressed: () {
              try {
                Payments().showPaymentCard(context);
              } catch (e) {
                print(e);
              }
            },
          ),
          new SignOutButton(user: user),
        ],
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text("sign out"),
      onPressed: () async {
        try {
          await FirebaseAuth.instance.signOut();
          final payment = Provider.of<PaymentModel>(context);
          payment.clear();
          user.changeUID(null, null, null);
        } catch (e) {
          print(e);
        }
      },
    );
  }
}
