import 'package:flutter/material.dart';
import 'package:iamrich/models/user.dart';
import 'package:provider/provider.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
      ),
      body: ListView(children: <Widget>[
        Text('data')
      ],),
    );
  }
}