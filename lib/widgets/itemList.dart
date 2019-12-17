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
            key: PageStorageKey<String>(section.title),
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  ...section.items.map((item) => ItemContainer(item: item)),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
