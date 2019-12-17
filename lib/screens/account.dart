import 'package:flutter/material.dart';
import 'package:iamrich/models/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/payment.dart';
import '../models/orders.dart';
import '../widgets/errorMessage.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        centerTitle: true,
      ),
      body: ListView(children: <Widget>[
        Text(user.name),
        Text(user.email),
        SignOutButton(user: user)
      ],),
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
          final orders = Provider.of<RestaurantOrders>(context);
          payment.clear();
          orders.clear();
          user.changeUID(null, null, null, null);
          Navigator.of(context).pop();
        } catch (error) {
          print(error);
          showErrorDialog(context, 'there was an error: ${error.toString()}');
        }
      },
    );
  }
}