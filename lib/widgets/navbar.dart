import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../constants.dart';

class NavBar extends StatelessWidget {

  NavBar({this.sections});
  final sections;

  final List<Tab> myTabs = <Tab>[];

  @override

  Widget build(BuildContext context) {

    sections.forEach((final section) {
    myTabs.add(Tab(
        text: section.title
      ));
    });

    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 50.0,
        maxHeight: 50.0,
        child: Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: kMainColor,
                  width: 0.25,
                ),
              ),
              boxShadow: [new BoxShadow(
                color: Colors.grey,
                // blurRadius: 4.0,
              ),
              ]
          ),
          child: TabBar(
            isScrollable: true,
            indicatorColor: kMainColor,
            indicatorWeight: 2.0,
            labelColor: kMainColor,
            tabs: myTabs,
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent)
  {
    return new SizedBox.expand(child: child);
  }
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
