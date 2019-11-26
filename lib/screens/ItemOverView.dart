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
  // Item item;

  @override
  void initState() {
    super.initState();
    fetchSelection( Item(id: "rkfmrmrkf",basePrice: 18.95, description: "jdjendje", imgUrl: "kdmekdmek", title: "dfkefkmrke")).then((value) {
      print(value.sections[0].selections[0].title);
    });
  }
  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                ItemBody(selectedList: widget.selectedList), 
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