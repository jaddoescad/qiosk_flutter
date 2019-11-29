import 'package:flutter/material.dart';
import 'package:iamrich/constants.dart';
import '../widgets/cartItem.dart';
import '../widgets/addCart.dart';

class CartPage extends StatelessWidget {
static const routeName = '/CartPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
      height: 65,
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(
            color: Colors.grey,
            blurRadius: 6.0,
          ),
          ]
      ),
      child: RaisedButton(
        elevation: 10,
        child: Text('Place Your Order', style: TextStyle(fontSize: 15, color: Colors.white),),
        color: Color(0xFF365e7a),
        onPressed:  () {}
      ),
    ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          backgroundColor: Color(0xFF365e7a),
          title: Text("Cart"),
          centerTitle: true,
          leading: new IconButton(
             splashColor: Colors.transparent,
             highlightColor: Colors.transparent, // makes highlight invisible too
             icon: Image.asset(
                'assets/images/backButton.png',
                 height: 35.0,
                 width: 35.0,
              ),
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
                          child: Text("Pure Kitchen", overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF365e7a),),)
                          ),
                        ),
              ),
              SliverFixedExtentList(
                itemExtent: 125.0,
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                      return CartItem();
                  },
                  childCount: 6,
                ),
              ),
           ]
         ),
     );
  }
}

