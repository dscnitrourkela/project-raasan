import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/viewModels/cart_view_model.dart';
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/views/cart/cart_header.dart';
import 'package:gogrocy/ui/views/cart/cart_list.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<CartViewModel>(
        onModelReady: (model){
          model.getCartList(product_id: null,quantity: null);
        },
        builder: (context,model,child){
          if(model.state==ViewState.Busy)
            return Center(child: CircularProgressIndicator());
          else if(model.state==ViewState.Intermediate){
            return ListView(
                children: <Widget>[
                CartHeader(model.intermediateCartList),
          CartList(model,model.intermediateCartList),
          ],
          );
          }
          else
            return ListView(
              shrinkWrap: true,
              children: <Widget>[
                CartHeader(model.cartList),
                CartList(model,model.cartList),
              ],
            );

        },
      ),
    );
  }
}
