import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: MyDynamicHeader(),
    );
  }
}

class MyDynamicHeader extends SliverPersistentHeaderDelegate {
  int opacity = 0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(
        builder: (context, constraints) {
          final double percentage = (constraints.maxHeight - minExtent)/(maxExtent - minExtent);

          return Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://media.blogto.com/listings/20180802-2048-LesMoulins7.jpg?w=2048&cmd=resize_then_crop&height=1365&quality=70"),
                      fit: BoxFit.cover,
                    )
                ),
                height: constraints.maxHeight,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                ),
                height: constraints.maxHeight,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF365e7a).withOpacity(1 - percentage),
                ),
                height: constraints.maxHeight,
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: IconButton(icon: Image.asset('assets/images/left.png', height: 35.0, width: 35.0,), onPressed: null),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Pure Kitchen', overflow: TextOverflow.ellipsis, maxLines: 1, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white,),),
                            Text('', overflow: TextOverflow.ellipsis, maxLines: 1, textAlign: TextAlign.center, style: TextStyle(fontSize: 5, color: Colors.white,),),
                            Text('Table 10', overflow: TextOverflow.ellipsis, maxLines: 1, textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.white,),),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: IconButton(icon: Image.asset('assets/images/right.png', height: 35.0, width: 35.0,), onPressed: null),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => 250.0;

  @override
  double get minExtent => 80.0;
}
