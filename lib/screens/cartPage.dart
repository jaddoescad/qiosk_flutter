import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iamrich/constants.dart';
import 'package:iamrich/models/cart.dart';
import '../constants.dart';
import '../screens/authScreen.dart';
import 'package:provider/provider.dart';
import 'package:iamrich/widgets/cartItem.dart';
import 'package:iamrich/widgets/addCart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main.dart';
import '../models/goToCheckout.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../Networking/Payments.dart';
import '../models/user.dart';
import '../models/restaurant.dart';
import '../widgets/errorMessage.dart';
import 'package:flutter_stripe_payment/flutter_stripe_payment.dart';
import '../widgets/Loader.dart';
import '../models/taxes.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

class CartPage extends StatefulWidget {
  static const routeName = '/CartPage';

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with RouteAware {
  bool loader = false;
  var loaderText = 'Logging In...';
  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
  }

  @override
  void didPopNext() {
    final goToCheckout = Provider.of<GoToCheckout>(context);
    final cart = Provider.of<Cart>(context);
    final user = Provider.of<User>(context);

    FirebaseAuth.instance.currentUser().then((firebaseUser) async {
      if (firebaseUser == null) {
        // goToCheckout.setGoToCheckout(false);
      } else {
        setState(() {
          loader = true;
        });
        if (goToCheckout.goToCheckout) {
          goToCheckout.setGoToCheckout(false);
          setState(() {
            loader = false;
          });
          checkout(context, user, cart);
        } else {
          setState(() {
            loader = false;
          });
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  interceptReturn() {
    if (loader != true) {
      return null;
    } else {
      return () async {
        return false;
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final taxes = Provider.of<Taxes>(context);

    return WillPopScope(
      onWillPop: interceptReturn(),
      child: ModalProgressHUD(
        progressIndicator: Loader(context: context, loaderText: loaderText),
        inAsyncCall: loader,
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: cart.items.values.toList().length > 0
              ? SafeArea(
                  child: CartButton(title: "Place Your Order", func: checkout))
              : null,
          appBar: AppBar(
            iconTheme: IconThemeData(color: kMainColor),
            brightness: Brightness.light,
            elevation: 1,
            backgroundColor: Colors.white,
            title: Text(
              "Cart",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: kMainColor,
              ),
            ),
            centerTitle: true,
            leading: new IconButton(
              splashColor: Colors.transparent,
              highlightColor:
                  Colors.transparent, // makes highlight invisible too
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
              onPressed: () {
                //add to cart
                Navigator.of(context).pop();
              },
            ),
          ),
          body: CustomScrollView(slivers: <Widget>[
            SliverToBoxAdapter(
              child: Stack(
                children: <Widget>[
                  cart.items.values.toList().length < 1
                      ? Container(
                          color: Colors.white,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height - 105,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Cart Is Empty",
                                style: TextStyle(
                                    color: kMainColor.withOpacity(0.4),
                                    fontSize: 20),
                              )
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                ...cart.items.values
                    .toList()
                    .map((item) => CartItemCard(item: item)),
              ]),
            ),
            SliverToBoxAdapter(
              child: cart.items.values.toList().length > 0
                  ? Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 15, left: 25, right: 20),
                      // margin: EdgeInsets.only(left: 30, right: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Subtotal"),
                                  Text(
                                      '\$ ${cart.totalAmount.toStringAsFixed(2)}'),
                                ],
                              ),
                            ),

                            // Text(" "),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text("Taxes"),
                                  Text(
                                      '\$ ${taxes.applyTax(cart.totalAmount).toStringAsFixed(2)}'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Total",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      '\$ ${taxes.getTotal(cart.totalAmount).toStringAsFixed(2)}'),
                                ],
                              ),
                            ),
                            Divider()
                          ]),
                    )
                  : Container(),
            ),
          ]),
        ),
      ),
    );
  }

  void checkout(context, user, cart) async {
    Payments().goToPage(context).then((page) async {
      if (page == PageToGo.Auth) {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (ctx) => AuthPage(
                  cameFrom: "cart",
                )));
      } else if (page == PageToGo.AddCard) {
        try {
          loaderText = 'Adding Payment Card...';
          PaymentResponse paymentResponse =
              await FlutterStripePayment.addPaymentMethod();

          setState(() {
            loader = true;
          });

          await Payments().showPaymentCard(context, paymentResponse);
          showSuccessDialog(context, "Successfully added card");
          setState(() {
            loader = false;
          });
        } catch (error) {
          setState(() {
            loader = false;
          });
          print('there was an error adding card: ${error.toString()}');
          showErrorDialog(context, 'There was an error adding your card');
        }
      } else if (page == PageToGo.Checkout) {
        YYDialog().build(context)
          ..width = 250
          ..borderRadius = 4.0
          ..text(
            padding: EdgeInsets.all(25.0),
            alignment: Alignment.center,
            text: "Where would you like to eat?",
            color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          )
          ..divider()
          ..doubleButton(
            padding: EdgeInsets.only(top: 10.0),
            gravity: Gravity.center,
            withDivider: true,
            text1: "For Here",
            color1: Colors.redAccent,
            fontSize1: 14.0,
            fontWeight1: FontWeight.bold,
            onTap1: () async {
              loaderText = 'Placing Order...';
              setState(() {
                loader = true;
              });
              await pay(user, cart, 'For Here');
              setState(() {
                loader = false;
              });
            },
            text2: "To Go",
            color2: Colors.redAccent,
            fontSize2: 14.0,
            fontWeight2: FontWeight.bold,
            onTap2: () async {
              loaderText = 'Placing Order...';
              setState(() {
                loader = true;
              });
              await pay(user, cart, 'To Go');
              setState(() {
                loader = false;
              });
            },
          )
          ..show();
      }
    });
  }

  Future pay(User user, Cart cart, forwhere) async {
    final restaurant = Provider.of<Restaurant>(context);
    final taxes = Provider.of<Taxes>(context);

    try {
      await Payments.pay(
          user.uid,
          user.stripeId,
          DateTime.now().millisecondsSinceEpoch.toString(),
          cart.totalAmount,
          taxes.applyTax(cart.totalAmount),
          taxes.getTotal(cart.totalAmount),
          "CAD",
          cart,
          restaurant.id,
          context,
          restaurant.title,
          forwhere,
          user.name);
    } catch (error) {
      print('error paying : $error');
      showErrorDialog(context, 'There was an error processing payment');
      setState(() {
        loader = false;
      });
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
