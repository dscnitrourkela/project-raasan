import 'package:flutter/material.dart';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/core/services/checkout_button_callback.dart';
import 'package:gogrocy/ui/shared/colors.dart' as colors;

class CartHeader extends StatelessWidget {
  final CartDataModel model;
  final CheckoutButtonPressed checkoutButtonPressed;

  CartHeader({this.model, this.checkoutButtonPressed});

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
                      color: colors.cartHeaderColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Your Cart",
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                color: colors.cartHeaderColor),
                          ),
                          Text(
                            "Grand Total Rs" +
                                ((model.sum > 499)
                                    ? model.sum.toString().toString()
                                    : (model.sum + 20).toString()),
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: colors.cartHeaderColor),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, top: 12),
              child: RawMaterialButton(
                elevation: 0.0,
                focusElevation: 1,
                focusColor: colors.cartButtonBackground,
                onPressed: () {
                  checkoutButtonPressed;
                },
                fillColor: colors.cartButtonBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  child: Text(
                    'Checkout',
                    style: TextStyle(
                        color: colors.cartButtonText,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
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
