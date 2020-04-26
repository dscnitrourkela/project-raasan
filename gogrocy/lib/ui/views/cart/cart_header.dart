import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/core/viewModels/cart_view_model.dart';
import 'package:gogrocy/ui/shared/colors.dart' as colors;
import 'package:gogrocy/ui/shared/constants.dart' as constants;

class CartHeader extends StatelessWidget {

  cart_list model;

  CartHeader(cart_list m){
    model=m;
  }


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
                          Text("Grand Total- Rs"+model.sum.toString(),
                          style: TextStyle(fontFamily: 'Gilroy',fontSize: 14.0,fontWeight: FontWeight.w600, color: colors.CART_HEADER_COLOR),),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0,top: 12),
              child: RawMaterialButton(
                elevation: 0.0,
                onPressed: () {},
                fillColor: colors.CART_BUTTON_BACKGROUND,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                child: SizedBox(
                  width: constants.CartConfig.checkoutButtonWidth,
                  height: constants.CartConfig.checkoutButtonHeight,
                  child: Center(
                    child: Text(
                      'Checkout Now',
                      style: TextStyle(
                          color: colors.CART_BUTTON_TEXT,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
