import 'package:flutter/material.dart';
import 'dart:math' as math;

final List<Tab> myTabs = <Tab>[
  Tab(text: 'Recommended'),
  Tab(text: 'Appetizers'),
  Tab(text: 'Sandwiches'),
  Tab(text: 'Burgers'),
  Tab(text: 'Hot Bowls'),
  Tab(text: 'Cold Bowls'),
];

class NavBar extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return                 SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 50.0,
        maxHeight: 50.0,
        child: Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF365e7a),
                  width: 0.25,
                ),
              ),
              boxShadow: [new BoxShadow(
                color: Colors.grey,
                blurRadius: 4.0,
              ),
              ]
          ),
          child: TabBar(
            isScrollable: true,
            indicatorColor: Color(0xFF365e7a),
            indicatorWeight: 2.0,
            labelColor: Color(0xFF365e7a),
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
