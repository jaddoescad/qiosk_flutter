import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, description, title, buttonText),
    );
  }
}

dialogContent(BuildContext context, description, title, buttonText) {
  return Stack(
  
    children: <Widget>[
      Container(
        height: 500,
        width: 500,
        padding: EdgeInsets.only(
          top: Consts.padding,
          bottom: Consts.padding,
          left: Consts.padding,
          right: Consts.padding,
        ),
        margin: EdgeInsets.only(top: Consts.avatarRadius),
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(Consts.padding),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
        onPressed: () {
          Navigator.of(context).pop(); // To close the dialog
        },
        child: Text(buttonText),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
        onPressed: () {
          Navigator.of(context).pop(); // To close the dialog
        },
        child: Text(buttonText),
                ),
              ),
            ],
          ),
      ),
    ],
  );
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
