import 'package:flutter/foundation.dart';

class Item {
  final String id;
  final double basePrice;
  final String title;
  final String description;
  final String imgUrl;
  final List<Section> sections;

  Item({@required this.id,this.basePrice = 0, @required this.title, this.description, this.imgUrl, this.sections});
}


class Section {
  final String id;
  final int max;
  final int min;
  final String title;
  final String type;
  final List<Selection> selections;

  Section({@required this.id, this.max, this.min = 0,@required this.title, this.type, this.selections});
}

class Selection {
  final String id;
  final String price;
  final String title;
  Selection({@required this.id, this.price,@required this.title});
}