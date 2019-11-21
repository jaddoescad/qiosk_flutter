import 'package:flutter/material.dart';
import './constants.dart';

const img_url = 'https://pbs.twimg.com/media/Cv8X5bXXYAAOskj.jpg';
const title = 'Burger Angus Original';
const description = 'Whether spicy or mild, our Bonafide Chicken is marinated for at least 12 hours, then hand-battered, hand-breaded and bursting with bold Louisiana flavour.';

class ItemHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ItemImage(),
        ItemTitle(),
        ItemDescription(),
      ],
    );
  }
}

class ItemImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      child: Image.network(
        img_url,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ItemTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
            left: kLeftPadding, right: kRightPadding, top: 15),
        child: Text(
          title,
          style: TextStyle(
              color: kMainColor, fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class ItemDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
            left: kLeftPadding, right: kRightPadding, top: 10, bottom: 15),
        child: Text(
          description,
          style: TextStyle(
              color: kMainColor, fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
