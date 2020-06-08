import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/viewModels/cart_view_model.dart';
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/views/cart/cart_bill.dart';
import 'package:gogrocy/ui/views/cart/cart_footer.dart';
import 'package:gogrocy/ui/views/cart/cart_list.dart';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/ui/shared/colors.dart' as colors;
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/widgets/vertical_spaces.dart';

typedef void CheckoutButtonPressed();

class Cart extends StatelessWidget {
  final ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<CartViewModel>(
        onModelReady: (model) {
          model.getCartList(cart_id: null, quantity: null);
        },
        builder: (context, model, child) {
          if (model.state == ViewState.Busy)
            return Center(child: CircularProgressIndicator());
          else if (model.state == ViewState.Intermediate) {
            if (model.cartList.sum != 0) {
              return ListView(
                shrinkWrap: true,
                addAutomaticKeepAlives: true,
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
            } else
              return emptyCart();
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
                  VerticalSpaces.small20,
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
              width: 0.146 * constants.screenWidth,
              height: 0.146 * constants.screenWidth,
              child: Image(
                image: AssetImage("assets/images/empty-cart.png"),
              )),
          Text(
            "Your cart is Empty!",
            textAlign: TextAlign.center,
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
  final CartDataModel model;
  final CheckoutButtonPressed checkoutButtonPressed;

  CartHeader({this.model, this.checkoutButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 0.195 * constants.screenHeight,
              color: colors.cartHeaderContainer,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.only(top: 0.020 * constants.screenHeight),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 0.046 * constants.screenWidth,
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
                                      fontSize: 0.077 * constants.screenWidth,
                                      fontWeight: FontWeight.bold,
                                      color: colors.cartHeaderColor),
                                ),
                                Text(
                                  "Grand Total ₹" +
                                      ((model.sum > 499)
                                          ? model.sum.toString().toString()
                                          : (model.sum + constants.deliveryCharges).toString()),
                                  style: TextStyle(
                                      fontFamily: 'Gilroy',
                                      fontSize: 0.032 * constants.screenWidth,
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
                    padding: EdgeInsets.only(
                        left: 0.075 * constants.screenWidth,
                        top: 0.012 * constants.screenHeight),
                    child: RawMaterialButton(
                      elevation: 0.0,
                      focusElevation: 1,
                      focusColor: colors.cartButtonBackground,
                      onPressed: () {
                        checkoutButtonPressed();
                      },
                      fillColor: colors.cartButtonBackground,
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
                                color: colors.cartButtonText,
                                fontSize: 0.031 * constants.screenWidth,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 0.035 * constants.screenHeight,
              color: Colors.white,
            )
          ],
        ),
        Positioned(
            right: 0.0,
            top: 0.0597 * constants.screenHeight,
            //bottom: 0.0,
            //top: 10.0,
            child: Image(
              height: 0.180 * constants.screenHeight,
              width: 0.450 * constants.screenWidth,
              image: AssetImage(
                'assets/images/shopping_cart.png',
              ),
            )),
      ],
    );
  }
}
