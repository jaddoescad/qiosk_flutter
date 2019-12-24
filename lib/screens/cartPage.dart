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
    return WillPopScope(
      onWillPop: interceptReturn(),
      child: ModalProgressHUD(
        progressIndicator: Loader(context: context, loaderText: loaderText),
        inAsyncCall: loader,
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: cart.items.values.toList().length > 0
              ? CartButton(title: "Place Your Order", func: checkout)
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
             child: cart.items.values.toList().length > 0 ? Container(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Subtotal"),
                    Text('\$ ${cart.totalAmount.toStringAsFixed(2)}'),
                  ],
                ),

                Text(" "),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Taxes"),
                    Text('\$ ${Taxes().applyTax(cart.totalAmount).toStringAsFixed(2)}'),
                  ],
                ),

                Text(" "),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Total", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('\$ ${Taxes().getTotal(cart.totalAmount).toStringAsFixed(2)}'),
                  ],
                ),
                ]
                ),
                ) : Container(),
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
          PaymentResponse paymentResponse = await FlutterStripePayment.addPaymentMethod();

          setState(() {
            loader = true;
          });
          
              await Payments().showPaymentCard(context, paymentResponse);
          showSuccessDialog(context, "Successfully added card");
          setState(() {
            loader = false;
          });
        } catch (error) {
          print('there was an error processing payment: ${error.toString()}');
          showErrorDialog(context, 'there was an error: ${error.toString()}');
        }
      } else if (page == PageToGo.Checkout) {
          loaderText = 'Placing Order...';
          setState(() {
            loader = true;
        });
        await pay(user, cart);
         setState(() {
           loader = false;
         });
      }
    });
  }

  Future pay(user, Cart cart) async {
    final restaurant = Provider.of<Restaurant>(context);

    try {
      await Payments.pay(
          user.uid,
          user.stripeId,
          DateTime.now().millisecondsSinceEpoch.toString(),
          cart.totalAmount,
          Taxes().applyTax(cart.totalAmount),
          Taxes().getTotal(cart.totalAmount),
          "CAD",
          cart,
          restaurant.id,
          context);
    } catch (error) {
      print('error paying : $error');
      showErrorDialog(context, 'there was an error: ${error.toString()}');
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


