import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../widgets/addCart.dart';
import '../widgets/itemList.dart';
import '../widgets/header.dart';
import '../widgets/navbar.dart';

final List<Restaurant> loadedData = [
  Restaurant(
    id: "1",
    title: "Pure Kitchen",
    imgUrl: "https://d1ralsognjng37.cloudfront.net/8efe8702-5fd9-4bde-9e1d-e8144545a4aa.jpeg",
    tableNumber: "10",
    sections: [
      Section(
        id: "11",
        title: "Recommended",
        items: [
          Item(
            id: "111",
            title: "Fantastic",
            description: "Ginger lime tofu, broccoli, red peppers, kale, scallions, cilantro, roasted peanuts, peanut sauce, and rice noodles.",
            price: "16.00",
            imgUrl: "https://d1ralsognjng37.cloudfront.net/586ffae5-5428-4c0c-8129-35d36ce07202.jpeg",
          ),
        ],
      ),
      Section(
        id: "12",
        title: "Appetizers",
        items: [
          Item(
            id: "121",
            title: "Fantastic",
            description: "Ginger lime tofu, broccoli, red peppers, kale, scallions, cilantro, roasted peanuts, peanut sauce, and rice noodles.",
            price: "16.00",
            imgUrl: "https://d1ralsognjng37.cloudfront.net/586ffae5-5428-4c0c-8129-35d36ce07202.jpeg",
          ),
        ],
      ),
      Section(
        id: "13",
        title: "Sandwiches",
        items: [
          Item(
            id: "131",
            title: "Fantastic",
            description: "Ginger lime tofu, broccoli, red peppers, kale, scallions, cilantro, roasted peanuts, peanut sauce, and rice noodles.",
            price: "16.00",
            imgUrl: "https://d1ralsognjng37.cloudfront.net/586ffae5-5428-4c0c-8129-35d36ce07202.jpeg",
          ),
        ],
      ),
      Section(
        id: "14",
        title: "Burgers",
        items: [
          Item(
            id: "141",
            title: "Fantastic",
            description: "Ginger lime tofu, broccoli, red peppers, kale, scallions, cilantro, roasted peanuts, peanut sauce, and rice noodles.",
            price: "16.00",
            imgUrl: "https://d1ralsognjng37.cloudfront.net/586ffae5-5428-4c0c-8129-35d36ce07202.jpeg",
          ),
        ],
      ),
      Section(
        id: "15",
        title: "Hot Bowls",
        items: [
          Item(
            id: "151",
            title: "Fantastic",
            description: "Ginger lime tofu, broccoli, red peppers, kale, scallions, cilantro, roasted peanuts, peanut sauce, and rice noodles.",
            price: "16.00",
            imgUrl: "https://d1ralsognjng37.cloudfront.net/586ffae5-5428-4c0c-8129-35d36ce07202.jpeg",
          ),
        ],
      ),
      Section(
        id: "16",
        title: "Cold Bowls",
        items: [
          Item(
            id: "161",
            title: "Fantastic",
            description: "Ginger lime tofu, broccoli, red peppers, kale, scallions, cilantro, roasted peanuts, peanut sauce, and rice noodles.",
            price: "16.00",
            imgUrl: "https://d1ralsognjng37.cloudfront.net/586ffae5-5428-4c0c-8129-35d36ce07202.jpeg",
          ),
        ],
      ),
    ],
  ),
];

final List<Tab> myTabs = <Tab>[
  Tab(text: 'Recommended'),
  Tab(text: 'Appetizers'),
  Tab(text: 'Sandwiches'),
  Tab(text: 'Burgers'),
  Tab(text: 'Hot Bowls'),
  Tab(text: 'Cold Bowls'),
];

var _tabs = ['Recommended', 'Appetizers', 'Sandwiches', 'Burgers', 'Hot Bowls', 'Cold Bowls'];

class Menu extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: loadedData[0].sections.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Cart(),
        body:NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              Header(),
              NavBar(),
            ];
          },
          body: TabBarView(
            children: _tabs.map((String name) {
              return ItemContainerList(name: name);
            }).toList(),
          ),
        ),
      ),
    );
  }
}