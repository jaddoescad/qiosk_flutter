import 'package:flutter/material.dart';
import './constants.dart';
import './RadioButton.dart';

const imgUrl =
    "https://cdn.vox-cdn.com/thumbor/d0jfYnyJ79WTE51N-nNbq8mBJMg=/896x473:7792x5502/1200x800/filters:focal(3649x2201:5039x3591)/cdn.vox-cdn.com/uploads/chorus_image/image/65731015/cz4jwpcaqabnupumbhji.0.jpg";
const title = 'Burger Angus Original';
const description =
    'Whether spicy or mild, our Bonafide Chicken is marinated for at least 12 hours, then hand-battered, hand-breaded and bursting with bold Louisiana flavour.';

var sections = {
  '8778': {
    'max': 2,
    'min': 0,
    'title': 'Breakfast',
    'type': 'CheckBox',
    'order': '3'
  },
  '8779': {
    'max': 2,
    'min': 0,
    'title': 'Breakfast',
    'type': 'CheckBox',
    'order': '1'
  },
  '8378': {
    'max': 2,
    'min': 0,
    'title': 'Breakfast',
    'type': 'CheckBox',
    'order': '2'
  },
  '8478': {'max': 2, 'min': 0, 'title': 'Breakfast', 'type': 'CheckBox'}
};

class ItemHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        imgUrl.isNotEmpty ? ItemImage() : Spacer(),
        ItemTitle(),
        if (description.isNotEmpty) ItemDescription(),
      ],
    );
  }
}

class Spacer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child:
            Container(height: 56, width: double.infinity, color: Colors.white),
      ),
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
        imgUrl,
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
            left: kLeftPadding, right: kRightPadding, top: 15, bottom: 5),
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
            left: kLeftPadding, right: kRightPadding, top: 5, bottom: 15),
        child: Text(
          description,
          style: TextStyle(
              color: kMainColor, fontSize: 15, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}

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
          icon: Image.asset('assets/images/backButton.png',
            height: 35.0,
            width: 35.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.red,
        child: Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: kBottomButtonContainerHeight,
        child: Container(
          margin: const EdgeInsets.only(
              bottom: kButtonContainerMargin,
              left: kButtonContainerMargin,
              right: kButtonContainerMargin),
          child: MaterialButton(
            color: kMainColor,
            onPressed: () => {printObject()},
            child: Stack(
              children: <Widget>[
                Align(
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  alignment: Alignment.center,
                ),
                Align(
                  child: Text('\$14.95',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white)),
                  alignment: Alignment.centerRight,
                ),
              ],
            ),
          ),
        ),
      ),
    )
    );
  }
}

void printObject() {}

List convertSectionMapIntoArray(map) {
  List sectionArray = [];
  map.forEach((k, v) {
    v['id'] = k;
    sectionArray.add(v);
  });
  sectionArray.sort((a, b) {
    return a['order']
        .toString()
        .toLowerCase()
        .compareTo(b['order'].toString().toLowerCase());
  });
  return sectionArray;
}

class Section extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: CustomRadio());
  }
}

class ItemBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: CustomScrollView(
        
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              ItemHeader(),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              ...convertSectionMapIntoArray(sections).map((section) =>Section()),
            ],
          ),
        ),
      ],
    ));
  }
}
