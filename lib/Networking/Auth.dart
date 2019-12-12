import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../models/payment.dart';


class Auth with ChangeNotifier {

final FirebaseAuth auth = FirebaseAuth.instance;
final Firestore _db = Firestore.instance;

Future<FirebaseUser> handleSignInEmail(String email, String password, context) async {

    AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);
    print('signInEmail succeeded: $user');
    checkIfUserExists(context);
    return user;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return auth.sendPasswordResetEmail(email: email);
  }

Future<FirebaseUser> handleSignUp(email, password,context, name) async {

    AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;
    assert (user != null);
    assert (await user.getIdToken() != null);

    updateUserData(user, name);
    checkIfUserExists(context);


    CloudFunctions cf = CloudFunctions();
      try {
        HttpsCallable callable = cf.getHttpsCallable(
          functionName: 'createUserAccount',
        );
        var resp = await callable.call(<String, dynamic>{"uid": user.uid.toString(),"email": email,"name": name});
        print(resp.data);
      } on CloudFunctionsException catch (e) {
        print(e.details);
        print(e.message);
        throw(e);
      } catch (e) {
        throw(e);
      }

    return user;

  } 

void checkIfUserExists(context) async {
  await FirebaseAuth.instance.currentUser().then((firebaseUser) async {
  if(firebaseUser != null)
   {
    var document = await Firestore.instance.collection('Users').document(firebaseUser.uid.toString()).get();
    final userProvider = Provider.of<User>(context);
    final payment = Provider.of<PaymentModel>(context);

    userProvider.changeUID(document['uid'], document['displayNane'], document['email']);

    if (document.data.containsKey('source') ){
      payment.setToken(document['source']['id']);
    }
   }
});
}

void updateUserData(FirebaseUser user, name) async {
    DocumentReference ref = _db.collection('Users').document(user.uid);
    return await ref.setData({
      'uid': user.uid,
      'email': user.email,
      'displayName': name,
    }, merge: true);
  }
}