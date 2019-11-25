import 'package:flutter/material.dart';
import '../widgets/ItemOverviewWidgets.dart';

class ItemOverview extends StatefulWidget {
  static const routeName = '/ItemOverview';
  final Map selectedList = {};
  @override
  _ItemOverviewState createState() => _ItemOverviewState();
}

class _ItemOverviewState extends State<ItemOverview> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
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