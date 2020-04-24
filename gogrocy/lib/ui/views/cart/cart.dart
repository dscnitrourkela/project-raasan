import 'package:flutter/material.dart';
import 'package:gogrocy/ui/views/cart/cart_header.dart';
import 'package:gogrocy/ui/views/cart/cart_list.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          CartHeader(),
          CartList()
        ],
      ),
    );
  }
}
