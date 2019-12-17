import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/payment.dart';
import '../widgets/errorMessage.dart';
import '../Networking/Payments.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
          appBar: AppBar(
            title: Text('Wallet'),
            centerTitle: true,
          ),
          body: ListView(
            children: <Widget>[
              Text('${wallet.cardType} ${wallet.lastFour}'),
              RaisedButton(
                child: Text("Wallet"),
                onPressed: () async {
                  try {
                    setState(() {
                      loader = true;
                    });
                    await Payments().showPaymentCard(context);
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
        ),
      ),
    );
  }
}
