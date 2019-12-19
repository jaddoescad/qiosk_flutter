import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iamrich/constants.dart';
import 'package:iamrich/models/cart.dart';
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

class CartPage extends StatefulWidget {
  static const routeName = '/CartPage';

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with RouteAware {
  bool loader = false;
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
        inAsyncCall: loader,
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: cart.items.values.toList().length > 0
              ? CartButton(title: "Place Your Order", func: checkout)
              : null,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55.0),
            child: AppBar(
              backgroundColor: Color(0xFF365e7a),
              title: Text(
                "Cart",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              leading: new IconButton(
                splashColor: Colors.transparent,
                highlightColor:
                    Colors.transparent, // makes highlight invisible too
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 24,
                ),
                onPressed: () {
                  //add to cart
                  Navigator.of(context).pop();
                },
              ),
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
                              ImageIcon(
                                AssetImage("assets/images/cart.png"),
                                size: 130,
                                color: Color(0xFF365e7a).withOpacity(0.4),
                              ),
                              Text(
                                "",
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                "      Cart is Empty",
                                style: TextStyle(
                                    color: Color(0xFF365e7a).withOpacity(0.4),
                                    fontSize: 20),
                              )
                            ],
                          ),
                        )
                      : Container(),
                  Container(
                    color: kSectionColor,
                    height: 50.0,
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Les Moulins La Fayette",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xFF365e7a),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                ...cart.items.values
                    .toList()
                    .map((item) => CartItemCard(item: item)),
              ]),
            )
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
          PaymentResponse paymentResponse = await FlutterStripePayment.addPaymentMethod();

          setState(() {
            loader = true;
          });
          final addPaymentStatus =
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
          DateTime.now().millisecondsSinceEpoch.toString(),
          cart.totalAmount,
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
