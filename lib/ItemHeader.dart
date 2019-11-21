import 'package:flutter/material.dart';

class ItemHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.blue,
      child: Image.network(
        'https://pbs.twimg.com/media/Cv8X5bXXYAAOskj.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
