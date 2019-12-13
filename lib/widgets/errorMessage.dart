
import 'package:flutter/material.dart';




void showSuccessDialog(context, e) {

showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Success"),
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
}
