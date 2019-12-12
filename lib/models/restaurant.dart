import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Restaurant extends ChangeNotifier{
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
          title: section['title'] ,
          items: getItem(section['items'])
      ));
    });
    sectionArray = sortArray(sectionArray);
    return sectionArray;
  }

  static List<MenuItem> getItem(Map<dynamic, dynamic> itemsJson) {
    List<MenuItem> itemArray = [];
    itemsJson.forEach((final id, final item) {
      itemArray.add(MenuItem(
          id: id.toString(),
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

  void fetchRestaurant(_id, json)  {
      // var document =  await Firestore.instance.collection('Restaurants').document('KYnIcMxo6RaLMeIlhh9u').get();
      // return fromRestaurantJson(id, data);
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