import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iamrich/screens/QRScanner.dart';
import 'package:iamrich/screens/cartPage.dart';

class Header extends StatelessWidget {

  Header({this.restaurant, this.items});
  final restaurant;
  final items;

  @override

  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: MyDynamicHeader(restaurant: restaurant, items: items),
    );
  }
}

class MyDynamicHeader extends SliverPersistentHeaderDelegate {

  MyDynamicHeader({this.restaurant, this.items});
  final restaurant;
  final items;

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
                      image: NetworkImage(restaurant.imgUrl),
                      fit: BoxFit.cover,
                    )
                ),
                height: constraints.maxHeight,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
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
                        margin: EdgeInsets.only(right: 20.0, top:5),
                        child: IconButton(icon: Icon(CupertinoIcons.photo_camera, size: 35, color: Colors.white,), onPressed: () {
                                      Navigator.of(context).push(
                                      MaterialPageRoute(builder: (ctx) => QRViewExample()),
                                        );     
                        }                   
                      ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(restaurant.title, overflow: TextOverflow.ellipsis, maxLines: 1, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18, color: Colors.white,),),
                            // Text('', overflow: TextOverflow.ellipsis, maxLines: 1, textAlign: TextAlign.center, style: TextStyle(fontSize: 5, color: Colors.white,),),
                            // Text('', overflow: TextOverflow.ellipsis, maxLines: 1, textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300),),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0, top: 5),
                        child: Stack(
                          children: <Widget>[
                            IconButton(icon: Icon(CupertinoIcons.shopping_cart, size: 35, color: Colors.white,), onPressed: () {
                                      Navigator.of(context).push(
                                      MaterialPageRoute(builder: (ctx) => CartPage()),
                                        );
                            }),
                            items.values.length > 0 ? Positioned(
                               right: 7,
                               top: 3,
                               child: new Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: new BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                       ),
                                  constraints: BoxConstraints(
                                      minWidth: 15,
                                      minHeight: 15,
                                      ),
                                  child: Text(items.values.length.toString(), style: TextStyle(color: Colors.white, fontSize: 12,), textAlign: TextAlign.center,),
                               ),
                            ) : Container()
                              ],
                        ),
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
