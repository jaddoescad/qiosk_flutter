import 'package:cloud_functions/cloud_functions.dart';

class RestaurantNetworking {
Future fetchMenuandOrders(rid) async {

    rid = "KYnIcMxo6RaLMeIlhh9u";

    CloudFunctions cf = CloudFunctions();
      try {
        HttpsCallable callable = cf.getHttpsCallable(
          functionName: 'createUserAccount',
        );
        var resp = await callable.call(<String, dynamic>{"r_id": rid});
        print(resp.data);
      } on CloudFunctionsException catch (e) {
        print(e.details);
        print(e.message);
        throw(e);
      } catch (e) {
        throw(e);
      }

  } 
}