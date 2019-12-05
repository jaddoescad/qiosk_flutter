import 'package:flutter/cupertino.dart';
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
      bottomNavigationBar: item.items.values.toList().length > 0 ? CartButton(title: "Place Your Order", func: checkout) : null,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          backgroundColor: Color(0xFF365e7a),
          title: Text("Cart", overflow: TextOverflow.ellipsis, maxLines: 1, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18, color: Colors.white,),),
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
                child: Stack(
                children: <Widget>[
                    item.items.values.toList().length < 1 ?
                    Container(
                       color: Colors.white, 
                       width: double.infinity,
                       height: MediaQuery.of(context).size.height - 105,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                           Icon(CupertinoIcons.shopping_cart, size: 130, color: Color(0xFF365e7a).withOpacity(0.4),),
                           Text("", style: TextStyle(fontSize: 10),),
                           Text("Cart is Empty", style: TextStyle(color: Color(0xFF365e7a).withOpacity(0.4), fontSize: 20),)
                  ],
                ),
                ) : Container(),
               Container(
                        color: kSectionColor, 
                        height: 50.0, 
                        padding: EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Les Moulins La Fayette", overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF365e7a),),)
                          ),
                        ),
                ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [   
                   ...item.items.values.toList().map((item) => CartItemCard(item: item)),
                  ]
                ),
              )
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