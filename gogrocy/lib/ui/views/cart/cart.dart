import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/viewModels/cart_view_model.dart';
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/views/cart/cart_bill.dart';
import 'package:gogrocy/ui/views/cart/cart_footer.dart';
import 'package:gogrocy/ui/views/cart/cart_list.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/core/services/checkout_button_callback.dart';
import 'package:gogrocy/core/viewModels/cart_view_model.dart';
import 'package:gogrocy/ui/shared/colors.dart' as colors;
import 'package:gogrocy/ui/shared/constants.dart' as constants;

typedef void CheckoutButtonPressed();

class Cart extends StatelessWidget {
  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<CartViewModel>(
        onModelReady: (model) {
          model.getCartList(product_id: null, quantity: null);
        },
        builder: (context, model, child) {
          if (model.state == ViewState.Busy)
            return Center(child: CircularProgressIndicator());
          else if (model.state == ViewState.Intermediate) {
            if (model.cartList.sum == 0) {
              return ListView(
                shrinkWrap: true,
                controller: scrollController,
                children: <Widget>[
                  CartHeader(
                    model: model.cartList,
                    checkoutButtonPressed: () {
                      scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                      print("Callback succeeds");
                    },
                  ),
                  CartList(model, model.intermediateCartList),
                  CartBill(
                    model.cartList,
                  ),
                  CartFooter(model),
                  SizedBox(
                    height: 50,
                  ),
                ],
              );
            } else return emptyCart();

          } else {
            if (model.cartList.sum == 0) {
              return emptyCart();
            } else
              return ListView(
                shrinkWrap: true,
                controller: scrollController,
                children: <Widget>[
                  CartHeader(
                      model: model.cartList,
                      checkoutButtonPressed: () {
                        scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                        print("Callback succeeds");
                      }),
                  CartList(model, model.cartList),
                  CartBill(model.cartList),
                  CartFooter(model),
                  SizedBox(
                    height: 50,
                  ),
                ],
              );
          }
        },
      ),
    );
  }

  Widget emptyCart() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
              width: 60.0,
              height: 60.0,
              child: Image(
                image: AssetImage("assets/images/empty-cart.png"),
              )),
          Text(
            "Your cart is Empty!",
            style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class CartHeader extends StatelessWidget {
  cart_list model;
  CheckoutButtonPressed checkoutButtonPressed;

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
                      color: colors.CART_HEADER_COLOR,
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
                                color: colors.CART_HEADER_COLOR),
                          ),
                          Text(
                            "Grand Total Rs" + model.sum.toString(),
                            style: TextStyle(
                                fontFamily: 'Gilroy',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: colors.CART_HEADER_COLOR),
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
                focusColor: colors.CART_BUTTON_BACKGROUND,
                onPressed: () {
                  checkoutButtonPressed();
                },
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
