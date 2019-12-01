import 'package:flutter/material.dart';
import './item.dart';

class ItemContainerList extends StatelessWidget {

  ItemContainerList({this.section});
  final section;
  @override

  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            physics: ClampingScrollPhysics(),
            key: PageStorageKey<String>(section.title),
            slivers: <Widget>[
              SliverFixedExtentList(
                itemExtent: 150.0,
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return ItemContainer(item: section.items[index]);
                  },
                  childCount: section.items.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
