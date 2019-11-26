import 'package:flutter/material.dart';
import '../widgets/ItemOverviewWidgets.dart';
import '../models/Item.dart';


class ItemOverview extends StatefulWidget {
  static const routeName = '/ItemOverview';
  final Map selectedList = {};
  @override
  _ItemOverviewState createState() => _ItemOverviewState();
}

class _ItemOverviewState extends State<ItemOverview> with WidgetsBindingObserver {
  Future<Item> item;

  @override
  void initState() {
    super.initState();
    item = fetchSelection( Item(id: "rkfmrmrkf",basePrice: 18.95, description: "jdjendje", imgUrl: "https://assets.bonappetit.com/photos/5d1cb1880813410008e914fc/16:9/w_1200,c_limit/Print-Summer-Smash-Burger.jpg", title: "dfkefkmrke"));
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Item>(
      future: item,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return selectionPage(snapshot.data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      }
      );}

  Stack selectionPage(Item item) {
    return Stack(
    children: <Widget>[
      Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              ItemBody(selectedList: widget.selectedList, item: item), 
              AddToCartButton(), 
            ],
          ),
        ),
      ),
      ItemAppBar()
    ],
  );
  }
}