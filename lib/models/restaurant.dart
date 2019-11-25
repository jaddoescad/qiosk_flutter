import 'package:flutter/foundation.dart';

class Restaurant {
  final String id;
  final String title;
  final String imgUrl;
  final String tableNumber;
  final List<Section> sections;

  Restaurant({@required this.id, @required this.title, this.imgUrl, this.tableNumber, this.sections});
}

class Section {
  final String id;
  final String title;
  final List<Item> items;

  Section({@required this.id, @required this.title, this.items});
}

class Item {
  final String id;
  final String title;
  final String description;
  final String price;
  final String imgUrl;

  Item({@required this.id, @required this.title, this.description, @required this.price, this.imgUrl});
}