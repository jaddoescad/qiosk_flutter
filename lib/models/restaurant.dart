import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class Restaurant extends ChangeNotifier {
  String id;
  String title;
  String imgUrl;
  String tableNumber;
  List<Section> sections;

  Restaurant({this.id, this.title, this.imgUrl, this.tableNumber, this.sections});

  // void fromRestaurantJson(String _id, Map<String,dynamic> json) {

    
  //       id = _id;
  //       title = json['title'];
  //       imgUrl = json['imgUrl'];
  //       sections = getSection(json['sections']);
  // }

  static List<Section> getSection(Map<dynamic, dynamic> sectionsJson) {
    List<Section> sectionArray = [];
    sectionsJson.forEach((final id, final section) {
      sectionArray.add(Section(
          id: id.toString(),
          order: section.containsKey('order') ? section['order'] : null,
          title: section['title'] ,
          items: getItem(section['items'])
      ));
    });
    print(sectionArray[0].order);
    sectionArray = sortArray(sectionArray);
    print(sectionArray[0].order);
    return sectionArray;
  }

  static List<MenuItem> getItem(Map<dynamic, dynamic> itemsJson) {
    List<MenuItem> itemArray = [];
    itemsJson.forEach((final id, final item) {
      itemArray.add(MenuItem(
          id: id.toString(),
          order: item.containsKey('order') ? item['order'] : null,
          title: item['title'] ,
          description: item['description'],
          price: item['price'].toDouble(),
          imgUrl: item['imgUrl'],
      ));
    });
    itemArray = sortArray(itemArray);
    return itemArray;
  }

  static List sortArray(map) {
    map.sort((a, b) {
      return a.order
          .toString()
          .toLowerCase()
          .compareTo(b.order.toString().toLowerCase());
    });
    return map;
  }

  void loadRestaurant(_id, json)  {

        id = _id;
        title = json['title'];
        imgUrl = json['imgUrl'];
        sections = getSection(json['sections']);

  }

}

class Section {
  final int order;
  final String id;
  final String title;
  final List<MenuItem> items;

  Section({this.order, @required this.id, @required this.title, this.items});
}

class MenuItem {
  final int order;
  final String id;
  final String title;
  final String description;
  final double price;
  final String imgUrl;

  MenuItem({this.order, @required this.id, @required this.title, this.description, @required this.price, this.imgUrl});
}