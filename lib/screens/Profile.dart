import 'package:flutter/material.dart';
import '../screens/loginPage.dart';
import '../screens/signUpPage.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF365e7a),
          title: Text("Profile"),
          centerTitle: true,
         ),
       ),
       body: Column(
         children: <Widget> [
       Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                  color: Color(0xFF365e7a),
                  width: 0.25
                )
            ),
          ), 
          height: 35.0, 
          padding: EdgeInsets.only(left: 20),
        ),
       InkWell(
         onTap: () {

                 Navigator.of(context).push(
  MaterialPageRoute(builder: (ctx) => AuthPage(pageState: "login",)),
    );
         },
                child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF365e7a),
                    width: 0.25
                  )
              ),
            ), 
            height: 50.0, 
            padding: EdgeInsets.only(left: 20),
            child: Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[
                Container(
                  child: Icon(Icons.lock, size: 30, color: Color(0xFF365e7a),),
                ),
                Container(
                  padding: EdgeInsets.only(left: 25),
                  child: Text("Login", overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, color: Color(0xFF365e7a),),),
                ),
              ],
              ),
          ),
       ),
       InkWell(
         onTap: () {
                Navigator.of(context).push(
  MaterialPageRoute(builder: (ctx) => AuthPage(pageState: "signUp",)),
    );
         },
                child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF365e7a),
                    width: 0.25
                  )
              ),
            ), 
            height: 50.0, 
            padding: EdgeInsets.only(left: 20),
            child: Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.start,
             children: <Widget>[
                Container(
                  child: Icon(Icons.person_add, size: 30, color: Color(0xFF365e7a),),
                ),
                Container(
                  padding: EdgeInsets.only(left: 25),
                  child: Text("Create Account", overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, color: Color(0xFF365e7a),),),
                ),
              ],
              ),
          ),
       ),
       Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                  color: Color(0xFF365e7a),
                  width: 0.25
                )
            ),
          ), 
          height: 50.0, 
          padding: EdgeInsets.only(left: 20),
          child: Row(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
              Container(
                child: Icon(Icons.mail, size: 30, color: Color(0xFF365e7a),),
              ),
              Container(
                padding: EdgeInsets.only(left: 25),
                child: Text("Contact Us", overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, color: Color(0xFF365e7a),),),
              ),
            ],
            ),
        ),
         ],
       ),
     );
  }
}
