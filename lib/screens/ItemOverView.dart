import 'package:flutter/material.dart';
import 'package:iamrich/models/restaurant.dart';
import 'package:provider/provider.dart';
import '../widgets/ItemOverviewWidgets.dart';
import '../models/Item.dart';
import '../main.dart';


class ItemOverview extends StatefulWidget {
  static const routeName = '/ItemOverview';
  ItemOverview({this.fromMenuItem});
  final MenuItem fromMenuItem;


  @override
  _ItemOverviewState createState() => _ItemOverviewState();
}

class _ItemOverviewState extends State<ItemOverview> with WidgetsBindingObserver, RouteAware{
  Future itemFuture;

  

  @override
  void initState() {
    super.initState();
    itemFuture = fetchSelection();
  }
  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

@override
  void didPop() {
    super.didPop();
    final item = Provider.of<Item>(context);
    item.reset();
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context, listen: false);
    final menuItem = Item(id: widget.fromMenuItem.id,basePrice: widget.fromMenuItem.price, description: widget.fromMenuItem.description, imgUrl: widget.fromMenuItem.imgUrl, title: widget.fromMenuItem.title.toString());

    return FutureBuilder(
      future: itemFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          item.fromSelectionJson(snapshot.data, menuItem);
          item.checkIfItemMeetsAllConditions();
          return SelectionPage();
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      }
      );
    }
}

class SelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Stack(
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
  );
  }
}