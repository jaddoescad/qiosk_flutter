import 'package:flutter/material.dart';
import 'package:iamrich/models/restaurant.dart';
import '../constants.dart';
import '../screens/ItemOverView.dart';
import 'package:flutter/cupertino.dart';
import '../models/Item.dart';
import 'package:provider/provider.dart';

class ItemContainer extends StatelessWidget {
  ItemContainer({this.item});
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(
            CupertinoPageRoute(
                builder: (ctx) => ItemOverview(
                      fromMenuItem: item,
                      itemID: item.id.toString(),
                    )),
          )
              .then((value) {
                print('emptied');
            final item = Provider.of<Item>(context, listen: false);
            item.reset();
          });
        },
        child: Container(
                    margin:
              EdgeInsets.only(left: 5.0, right: 5.0),
          padding:
              EdgeInsets.only( top: 18.0, bottom: 18.0, left: 15, right: 15),
          // margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              item.imgUrl != null
                  ? Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          color: kMainColor,
                          height: 175,
                          width: double.infinity,
                          child: Image.network(item.imgUrl, fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                height: 175,
                                color: kMainColor,
                                width: double.infinity,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.transparent,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                  )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only( bottom: 5),
                child: Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2),
                    ),
                  ),
                ),
              ),
              item.description != null
                  ? Container(
                      padding: EdgeInsets.only(left: 10.0, right: 8, bottom: 5),
                      width: double.infinity,
                      // height: 40,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 13,
                              color: kMainColor.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2),
                        ),
                      ),
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 2.5),
                width: double.infinity,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 13,
                        color: kMainColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.5),
                width: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}