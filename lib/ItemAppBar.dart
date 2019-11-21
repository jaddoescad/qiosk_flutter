import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      //Place it at the top, and not use the entire screen
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        backgroundColor: Colors.transparent, //No more green
        elevation: 0.0, //Shadow gone
        leading: new IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent, // makes highlight invisible too
          icon: new SvgPicture.asset(
            'assets/svg_images/backButton.svg',
            height: 35.0,
            width: 35.0,
            allowDrawingOutsideViewBox: true,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
