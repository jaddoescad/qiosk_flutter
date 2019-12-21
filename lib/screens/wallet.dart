import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/payment.dart';
import '../widgets/errorMessage.dart';
import '../Networking/Payments.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_stripe_payment/flutter_stripe_payment.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool loader = false;
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
    final wallet = Provider.of<PaymentModel>(context, listen: false);

    return ModalProgressHUD(
      inAsyncCall: loader,
      child: WillPopScope(
        onWillPop: interceptReturn(),
        child: Scaffold(
          backgroundColor: kBodyBackground,
          appBar: AppBar(
            iconTheme: IconThemeData(color: kMainColor),
            brightness: Brightness.light,
            elevation: 1,
            backgroundColor: Colors.white,
            title: Text(
              "Wallet",
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
          body: ListView(
            children: <Widget>[
              if (wallet.cardType != null)
                walletCard(context, 'Card Brand', wallet.cardType.toUpperCase()),
              if (wallet.lastFour != null)
                walletCard(context, 'Card Number',
                    '· · · ·   · · · ·   · · · ·   ${wallet.lastFour}'),
              SizedBox(
                height: 20,
              ),
              addPaymentCard(
                  context,
                  wallet.lastFour != null
                      ? 'Replace Payment Card'
                      : 'Add Payment Card')
            ],
          ),
        ),
      ),
    );
  }

  Container addPaymentCard(BuildContext context, String title) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom:
                  BorderSide(color: kMainColor.withOpacity(0.5), width: 0.5))),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Positioned(
              left: 20,
              child: Opacity(
                  opacity: 0.5,
                  child: Text(title,
                      style: TextStyle(fontWeight: FontWeight.w800)))),
          Positioned(
            right: 20,
            child: Opacity(
              opacity: 0.5,
              child: Icon(
                Icons.add,
                size: 20,
              ),
            ),
          ),
          FlatButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            // color: Colors.white,
            child: Container(
              width: double.infinity,
              height: 75,
            ),
            onPressed: () async {
              try {
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
                print(error);
                setState(() {
                  loader = false;
                });
                showErrorDialog(
                    context, 'there was an error: ${error.toString()}');
              }
            },
          ),
        ],
      ),
    );
  }

  Container walletCard(BuildContext context, String header, String title) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom:
                  BorderSide(color: kMainColor.withOpacity(0.5), width: 0.5))),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Positioned(
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    header,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Text(title, style: TextStyle(fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          FlatButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              color: Colors.white,
              child: Container(
                width: double.infinity,
                height: 75,
              ),
              onPressed: null),
        ],
      ),
    );
  }
}
