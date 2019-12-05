import 'package:flutter/material.dart';
import 'package:iamrich/constants.dart';
import 'package:iamrich/models/cart.dart';
import 'package:iamrich/screens/loginPage.dart';
import 'package:provider/provider.dart';
import 'package:iamrich/widgets/cartItem.dart';
import 'package:iamrich/widgets/addCart.dart';
import '../util/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/checkout.dart';

class CartPage extends StatelessWidget {
static const routeName = '/CartPage';

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Cart>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CartButton(title: "Place Your Order", func: checkout),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          backgroundColor: Color(0xFF365e7a),
          title: Text("Cart"),
          centerTitle: true,
          leading: new IconButton(
             splashColor: Colors.transparent,
             highlightColor: Colors.transparent, // makes highlight invisible too
             icon: Icon(Icons.arrow_back_ios, size: 24,),
             onPressed: () {
               //add to cart
               Navigator.of(context).pop();
             },
          ),
         ),
       ),
       body: CustomScrollView(
         slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                        color: kSectionColor, 
                        height: 50.0, 
                        padding: EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Pure Kitchen", overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Color(0xFF365e7a),),)
                          ),
                        ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [   
                   ...item.items.values.toList().map((item) => CartItemCard(item: item)),
                  ]
                ),
              ),
           ]
         ),
     );
  }

  void checkout(context) async {



FirebaseAuth.instance.currentUser().then((firebaseUser){
  if(firebaseUser == null)
   {
          Navigator.of(context).push(
  MaterialPageRoute(builder: (ctx) => AuthPage()));
     //signed out
   }
   else{
    //signed in
    print(firebaseUser.email);
           Navigator.of(context).push(
  MaterialPageRoute(builder: (ctx) => Checkout()));
  }
});
  }
}