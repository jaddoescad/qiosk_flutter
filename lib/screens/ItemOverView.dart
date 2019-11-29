import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/ItemOverviewWidgets.dart';
import '../models/Item.dart';
import '../main.dart';


class ItemOverview extends StatefulWidget {
  static const routeName = '/ItemOverview';
  @override
  _ItemOverviewState createState() => _ItemOverviewState();
}

class _ItemOverviewState extends State<ItemOverview> with WidgetsBindingObserver, RouteAware{
  Future itemFuture;
  final menuItem = Item(id: "Mighty Hamburger",basePrice: 18.95, description: "Delicious Sauced hamburger with a hint of Khara", imgUrl: "https://assets.bonappetit.com/photos/5d1cb1880813410008e914fc/16:9/w_1200,c_limit/Print-Summer-Smash-Burger.jpg", title: "dfkefkmrke");

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
    // TODO: implement didPop
    super.didPop();
    final item = Provider.of<Item>(context);
    item.reset();
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context, listen: false);
    return FutureBuilder(
      future: itemFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          item.fromSelectionJson(snapshot.data, menuItem);
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
          backgroundColor: Colors.white,
          body: Column(
            children: [
              ItemBody(), 
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