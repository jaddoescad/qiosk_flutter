import 'package:iamrich/models/payment.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';
import 'package:flutter_stripe_payment/flutter_stripe_payment.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../Networking/Orders.dart';
import '../models/payment.dart';
import 'package:stripe_payment/stripe_payment.dart';

enum PageToGo { Checkout, AddCard, Auth }
enum AddPaymentStatus { Success, Failed }

class Payments {
  Future showPaymentCard(context, paymentResponse) async {
    if (paymentResponse.status == PaymentResponseStatus.succeeded) {
      await addPaymentSource(paymentResponse.paymentMethodId, context);
      return AddPaymentStatus.Success;
    } else {
      return AddPaymentStatus.Failed;
    }
  }

  Future addPaymentSource(token, context) async {
    final payment = Provider.of<PaymentModel>(context);
    final user = Provider.of<User>(context);
    CloudFunctions cf = CloudFunctions();
    HttpsCallable callable = cf.getHttpsCallable(
      functionName: 'addPaymentSource',
    );
    var resp = await callable.call(<String, dynamic>{
      'token': token,
      'uid': user.uid,
      'stripeId': user.stripeId
    });

    if (resp.data.containsKey('error')) {
      print('error');

      throw (resp.data['error']);
    } else {
      final card = resp.data['source'];
      payment.setCard(card['id'], card['card']['last4'], card['card']['brand']);
    }
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

  static Future pay(uid, stripeId, orderId, subtotal, taxes, total, currency, cart, rid, context, rname, forwhere, username) async {
    final token = Provider.of<PaymentModel>(context).token;

    // CloudFunctions cf = CloudFunctions();
    // HttpsCallable callable = cf.getHttpsCallable(
    //   functionName: 'createPaymentIntent',
    // );
    // var resp = await callable.call(<String, dynamic>{
    //   'uid': uid.toString(),
    //   'stripeId': stripeId,
    //   'orderId': orderId,
    //   'token': token,
    //   'amount': total,
    // });

    // if (resp.data.containsKey('error')) {
    //   throw ('there was an error processing the payment ${resp.data['error'].toString()}');
    // } else {
    //   await StripePayment.confirmPaymentIntent(
    //     PaymentIntent(
    //       clientSecret: resp.data['response']['client_secret'],
    //       paymentMethodId: resp.data['sourceId'],
    //     ),
    //   ).then((paymentIntent) async {
    //     print(paymentIntent.status);
    //     if (paymentIntent.status == 'succeeded') {
    //       print('payment succeeded');
          await OrdersNetworking().createOrder(orderId, cart, subtotal, taxes, total, uid, rid, context, token, rname, forwhere, username);
      //   } else {
      //     print(paymentIntent.status);
      //     throw ('error processing payment');
      //   }
      // }).catchError((setError) {
      //   print(setError.toString());
      //   throw (setError.toString());
      // });
    // }
  }
}