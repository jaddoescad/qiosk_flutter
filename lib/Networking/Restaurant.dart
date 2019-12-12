import 'package:cloud_functions/cloud_functions.dart';

class RestaurantNetworking {
static Future fetchMenuandOrders(rid, uid) async {

    CloudFunctions cf = CloudFunctions();
        HttpsCallable callable = cf.getHttpsCallable(
          functionName: 'getMenuAndOrders',
        );
        var resp = await callable.call(<String, dynamic>{"rid": rid, "uid": uid});

        if (resp.data.containsKey('error')) {
          throw(resp.data['error']);
        } else {
          return [resp.data['menu'], resp.data['orders']];
        }
  } 

  static Future fetchOrders(rid, uid) async {

    CloudFunctions cf = CloudFunctions();
        HttpsCallable callable = cf.getHttpsCallable(
          functionName: 'getOrders',
        );
        var resp = await callable.call(<String, dynamic>{"rid": rid, "uid": uid});

        if (resp.data.containsKey('error')) {
          throw(resp.data['error']);
        } else {
          return resp.data['orders'];
        }
  } 
}