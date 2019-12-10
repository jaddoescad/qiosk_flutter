import 'package:provider/provider.dart';
// import 'package:stripe_payment/stripe_payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';
import 'package:flutter_stripe_payment/flutter_stripe_payment.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../Networking/Orders.dart';
import '../models/restaurant.dart';

enum PageToGo { Checkout, AddCard, Auth }

class Payments {
  Future showPaymentCard(context) async {
    PaymentResponse paymentResponse =
        await FlutterStripePayment.addPaymentMethod();

    if (paymentResponse.status == PaymentResponseStatus.succeeded) {
      addPaymentSource(paymentResponse.paymentMethodId, context);
    }
  }

  void addPaymentSource(token, context) async {
    final user = Provider.of<User>(context);
    await Firestore.instance
        .collection('Users')
        .document(user.uid)
        .collection('tokens')
        .document()
        .setData({'tokenId': token}).catchError((error) {
      print(error);
      throw (error.toString());
    });
  }

  Future<PageToGo> goToPage() async {
    PageToGo goToPage;
    await FirebaseAuth.instance.currentUser().then((firebaseUser) async {
      if (firebaseUser != null) {
        var document = await Firestore.instance
            .collection('Users')
            .document(firebaseUser.uid)
            .collection('source')
            .document('default')
            .get();

        if (document.data != null) {
          if (document.data.containsKey('id')) {
            goToPage = PageToGo.AddCard;
          }
          //go to checkout
          goToPage = PageToGo.Checkout;
        } else {
          //go to add card
          goToPage = PageToGo.AddCard;
        }
      } else {
        //go to sign in
        goToPage = PageToGo.Auth;
      }
    });
    return goToPage;
  }

  void pay(uid, orderId, amount, currency, cart, r_id, context) async {
    CloudFunctions cf = CloudFunctions();
    try {
      HttpsCallable callable = cf.getHttpsCallable(
        functionName: 'createPaymentIntent',
      );
      var resp = await callable.call(<String, dynamic>{
        "uid": uid.toString(),
        "orderId": orderId,
        "amount": amount
      });

      if (resp.data.containsKey("error")) {
        throw ('there was an error processing the payment');
      } else {
        var intentResponse = await FlutterStripePayment.confirmPaymentIntent(
            resp.data['response']['client_secret'],
            resp.data['sourceId'],
            amount);
        if (intentResponse.status == PaymentResponseStatus.succeeded) {
          print("success");
          //create order
          OrdersNetworking().CreateOrder(orderId, cart, amount, uid, "KYnIcMxo6RaLMeIlhh9u", context);
        } else if (intentResponse.status == PaymentResponseStatus.failed) {
          throw('internal error');
        } else {
          throw('failed');
        }
      }
    } on CloudFunctionsException catch (e) {
      print(e.details);
      print(e.message);
      print(e);
    } catch (e) {
      print(e);
    }
    // final Firestore _db = Firestore.instance;
    // final ref = _db.collection('Orders').document();

    // return await ref.setData({
    //   'uid': uid,
    //   'order_id': order_id,
    //   'amount': amount,
    //   'currency': currency,
    //   'description': description
    // }, merge: true);
  }
}
