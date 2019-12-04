import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {

  SocialButton(this.color, this.text, this.image);

  final Color color;
  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
          splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(14),
          color: color,
          width: double.infinity,
          // height: 100,
          child: Row(children: <Widget>[
            Image.asset(image, width: 20, height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(text, style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),),
            )
          ],),
            ),
      onTap: () {
        print("hello");
      },
    );
  }
}