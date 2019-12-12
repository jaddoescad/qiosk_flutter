import 'package:iamrich/models/payment.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';
import 'package:flutter_stripe_payment/flutter_stripe_payment.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../Networking/Orders.dart';
import '../models/payment.dart';

enum PageToGo { Checkout, AddCard, Auth }

class Payments {
  Future showPaymentCard(context) async {
    PaymentResponse paymentResponse =
        await FlutterStripePayment.addPaymentMethod();

    if (paymentResponse.status == PaymentResponseStatus.succeeded) {
      await addPaymentSource(paymentResponse.paymentMethodId, context);
    }
  }

  Future addPaymentSource(token, context) async {
    final payment = Provider.of<PaymentModel>(context);
    final user = Provider.of<User>(context);
    await Firestore.instance
        .collection('Users')
        .document(user.uid)
        .collection('tokens')
        .document()
        .setData({'tokenId': token});
    payment.setToken(token);
  }

  Future<PageToGo> goToPage(context) async {
    PageToGo goToPage;
    final payment = Provider.of<PaymentModel>(context);
    await FirebaseAuth.instance.currentUser().then((firebaseUser) async {
      if (firebaseUser != null) {
        if (payment.token != null) {
          goToPage = PageToGo.Checkout;
        } else {
          goToPage = PageToGo.AddCard;
        }
      } else {
        goToPage = PageToGo.Auth;
      }
    });
    return goToPage;
  }

  static Future pay(uid, orderId, amount, currency, cart, r_id, context) async {
    final token = Provider.of<PaymentModel>(context).token;

    CloudFunctions cf = CloudFunctions();
    HttpsCallable callable = cf.getHttpsCallable(
      functionName: 'createPaymentIntent',
    );
      var resp = await callable.call(<String, dynamic>{
        'uid': uid.toString(),
        'orderId': orderId,
        'token': token,
        'amount': amount
      });

      if (resp.data.containsKey('error')) {
        throw ('there was an error processing the payment ${resp.data['error'].toString()}');
      } else {
        var intentResponse = await FlutterStripePayment.confirmPaymentIntent(
            resp.data['response']['client_secret'],
            resp.data['sourceId'],
            amount);
        if (intentResponse.status == PaymentResponseStatus.succeeded) {
          print('success');
          OrdersNetworking.createOrder(orderId, cart, amount, uid,
              'KYnIcMxo6RaLMeIlhh9u', context, token);
        } else if (intentResponse.status == PaymentResponseStatus.failed) {
          throw ('internal error ${intentResponse.errorMessage}');
        } else {
          throw ('failed to confirm payment');
        }
      }

  }
}
