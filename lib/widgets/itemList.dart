import 'package:flutter/material.dart';
import './item.dart';

class ItemContainerList extends StatelessWidget {

  ItemContainerList({this.name});
  final String name;
  @override

  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            key: PageStorageKey<String>(name),
            slivers: <Widget>[
              SliverFixedExtentList(
                itemExtent: 125.0,
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return ItemContainer();
                  },
                  childCount: 30,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
