import 'package:flutter/material.dart';
import 'package:iamrich/constants.dart';
import 'package:iamrich/models/restaurant.dart';
import 'package:provider/provider.dart';
import '../widgets/ItemOverviewWidgets.dart';
import '../models/Item.dart';
import '../main.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../widgets/Loader.dart';

class ItemOverview extends StatefulWidget {
  static const routeName = '/ItemOverview';
  ItemOverview({this.fromMenuItem, this.itemID});
  final MenuItem fromMenuItem;
  final String itemID;

  @override
  _ItemOverviewState createState() => _ItemOverviewState();
}

class _ItemOverviewState extends State<ItemOverview> {
  Future itemFuture;
  bool loader = true;
  final loaderText = 'Fetching Item...';

  interceptReturn() {
    if (loader == true) {
      return null;
    } else {
      return () async {
        return false;
      };
    }
  }

  @override
  void initState() {
    super.initState();
    final item = Provider.of<Item>(context, listen: false);
    final menuItem = Item(
        id: widget.fromMenuItem.id,
        basePrice: widget.fromMenuItem.price,
        description: widget.fromMenuItem.description,
        imgUrl: widget.fromMenuItem.imgUrl,
        title: widget.fromMenuItem.title.toString());
    item.updateHeader(menuItem);
    itemFuture = Future.delayed(Duration.zero, () {
      return fetchSelection(context, widget.itemID);
    });
  }



  @override
  Widget build(BuildContext context) {
    return itemFutureBuilder();
  }

  FutureBuilder itemFutureBuilder() {
    return FutureBuilder(
        future: itemFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SelectionPage();
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return WillPopScope(
            onWillPop: null,
            child: ModalProgressHUD(
              opacity: 0,
              color: kMainColor,
              progressIndicator: Loader(context: context, loaderText: loaderText),
              child: SelectionPage(),
              inAsyncCall: loader,
            ),
          );
        });
  }
}

class SelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Scaffold(
              bottomNavigationBar: SelectionCartButton(),
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  ItemBody(),
                ],
              ),
            ),
          ),
          ItemAppBar()
        ],
      ),
    );
  }
}
