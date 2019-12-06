import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';


class ProfileLoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return Scaffold(
      body: FlatButton(child: Text("sign out"), onPressed: () async {

            try {
              await FirebaseAuth.instance.signOut();
            } catch(e) {
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
              user.changeUID(null, null, null);
              print(user.uid);
            }
          },),
    );
  }
}