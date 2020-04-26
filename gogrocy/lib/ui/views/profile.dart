import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/core/viewModels/cart_view_model.dart';
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/views/cart/cart.dart';
import 'package:gogrocy/ui/shared/colors.dart' as colors;
import 'package:gogrocy/ui/views/orders/orders.dart';
class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<CartViewModel>(
        onModelReady: (model){
          model.getCartList(product_id: null,quantity: null);
        },
        builder: (context,model,child){
          if(model.state==ViewState.Busy)
            return Center(child: CircularProgressIndicator(),);
          else return Column(
            children: <Widget>[
              CartHeader(model: model.cartList,),
              GestureDetector(
                  onTap: (){Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderView()),
                  );},
                  child: options(icon: 'assets/images/orders.png',title: "Orders")),
            ],
          );
        },
      ),
    );
  }
  
  Widget options({String icon, String title}){
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(icon),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
        )
      ],
    );
  }
}

class CartHeader extends StatelessWidget {

  cart_list model;
  CheckoutButtonPressed checkoutButtonPressed;

  CartHeader({this.model});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image(image: AssetImage('assets/images/cart_background.png')),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 20.0,
                      color: colors.CART_HEADER_COLOR,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Your Cart",
                            style: TextStyle(fontFamily: 'Gilroy',fontSize: 32.0,fontWeight: FontWeight.bold, color: colors.CART_HEADER_COLOR),),
                          Text("Grand Total Rs"+model.sum.toString(),
                            style: TextStyle(fontFamily: 'Gilroy',fontSize: 14.0,fontWeight: FontWeight.w600, color: colors.CART_HEADER_COLOR),),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

