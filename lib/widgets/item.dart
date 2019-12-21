import 'package:flutter/material.dart';
import 'package:iamrich/models/restaurant.dart';
import '../constants.dart';
import '../constants.dart';
import '../constants.dart';
import '../screens/ItemOverView.dart';
import 'package:flutter/cupertino.dart';

class ItemContainer extends StatelessWidget {
  ItemContainer({this.item});
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
                builder: (ctx) => ItemOverview(fromMenuItem: item, itemID: item.id.toString(),)),
          );
        },
        child: Container(
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
          // margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              item.imgUrl != null
                  ? ClipRRect(
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
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 5),
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
                      padding: EdgeInsets.only(left: 10.0, right: 8),
                      width: double.infinity,
                      height: 40,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.2),
                        ),
                      ),
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 8),
                width: double.infinity,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
                      child: Text(
                        item.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        item.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1),
                      ),
                    ),
                    Text(
                      '\$ ${item.price.toStringAsFixed(2)}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    //         ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(item.imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 95,
                width: 95,
              ),
            ],
          ), */
