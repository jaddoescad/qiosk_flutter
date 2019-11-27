import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

Future<Restaurant> fetchRestaurant() async {
  final response = await rootBundle.loadString('assets/mock/Menu.json').then((restaurantData) {
    return restaurantData;
  });
  return Restaurant.fromSelectionJson(json.decode(response));
}

class Restaurant {
  final String id;
  final String title;
  final String imgUrl;
  final String tableNumber;
  final List<Section> sections;

  Restaurant({@required this.id, @required this.title, this.imgUrl, this.tableNumber = "10", this.sections});

  factory Restaurant.fromSelectionJson(Map<String,dynamic> json) {
    final String _id = json.keys.toList()[0].toString();
    return Restaurant(
        id: _id,
        title: json[_id]['title'],
        imgUrl: json[_id]['imgUrl'],
        sections: getSection(json[_id]['sections'])
    );
  }

  static List<Section> getSection(sectionsJson) {
    List<Section> sectionArray = [];
    sectionsJson.forEach((final String id, final section) {
      sectionArray.add(Section(
          id: id.toString(),
          title: section['title'] ,
          items: getItem(section['items'])
      ));
    });
    sectionArray = sortArray(sectionArray);
    return sectionArray;
  }

  static List<Item> getItem(itemsJson) {
    List<Item> itemArray = [];
    itemsJson.forEach((final String id, final item) {
      itemArray.add(Item(
          id: id.toString(),
          title: item['title'] ,
          description: item['description'],
          price: item['price'],
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

}

class Section {
  final int order;
  final String id;
  final String title;
  final List<Item> items;

  Section({this.order, @required this.id, @required this.title, this.items});
}

class Item {
  final int order;
  final String id;
  final String title;
  final String description;
  final String price;
  final String imgUrl;

  Item({this.order, @required this.id, @required this.title, this.description, @required this.price, this.imgUrl});
}