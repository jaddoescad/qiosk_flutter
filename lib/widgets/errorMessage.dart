
import 'package:flutter/material.dart';




void showSuccessDialog(context, e) {

showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                elevation: 0,
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

void showErrorDialog(context, e) {

showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                elevation: 0,
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
}