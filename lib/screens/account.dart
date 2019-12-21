import 'package:flutter/material.dart';
import 'package:iamrich/models/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import '../models/payment.dart';
import '../models/orders.dart';
import '../widgets/errorMessage.dart';
import 'package:flutter/cupertino.dart';
import '../models/cart.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return Scaffold(
      backgroundColor: kBodyBackground,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kMainColor),
        brightness: Brightness.light,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
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
        leading: new IconButton(
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
      body: ListView(
        children: <Widget>[
          accountCard(context, "Name", user.name.toUpperCase()),
          accountCard(context, "Email", user.email),
          SizedBox(
            height: 20,
          ),
          signOutCard(context, 'Sign Out', user),
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
      child: Text("Sign Out"),
      onPressed: () async {
        try {
          await FirebaseAuth.instance.signOut();
          final payment = Provider.of<PaymentModel>(context);
          final orders = Provider.of<RestaurantOrders>(context);
          final cart = Provider.of<Cart>(context);
          cart.clear();
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

Container accountCard(BuildContext context, String header, String title) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom:
                BorderSide(color: kMainColor.withOpacity(0.5), width: 0.5))),
    child: Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
                Positioned(
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  header,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Text(title, style: TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
        ),
        FlatButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            color: Colors.white,
            child: Container(
              width: double.infinity,
              height: 75,
            ),
            onPressed: null),
      ],
    ),
  );
}

Container signOutCard(BuildContext context, String title, User user) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: kMainColor.withOpacity(0.5), width: 0.5),
          // top: BorderSide(color: kMainColor.withOpacity(0.5), width: 0.5)
        )),
    child: Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        Positioned(
          left: 20,
          child: Text(title, style: TextStyle(fontWeight: FontWeight.w800)),
        ),
        FlatButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            width: double.infinity,
            height: 75,
          ),
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
              showErrorDialog(
                  context, 'there was an error: ${error.toString()}');
            }
          },
        ),
      ],
    ),
  );
}
