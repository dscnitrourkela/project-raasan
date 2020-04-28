import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/core/viewModels/cart_view_model.dart';
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/shared/colors.dart' as colors;
import 'package:gogrocy/ui/widgets/cart_counter.dart';

class CartList extends StatelessWidget {
  final String baseImgUrl =
      "https://res.cloudinary.com/gogrocy/image/upload/v1/";
  CartViewModel model;
  cart_list cartList;

  CartList(CartViewModel m, cart_list c) {
    model = m;
    cartList = c;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    cart_list usableCartList;
    usableCartList = cartList;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: usableCartList.cart.length,
          itemBuilder: (context, index) {
            int eachItemCost = int.parse(usableCartList.cart[index].price);
            int quantityOrdered =
                int.parse(usableCartList.cart[index].quantity_ordered);
            int totalCost = eachItemCost * quantityOrdered;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      width: constants.CartConfig.imageWidth,
                      height: constants.CartConfig.imageHeight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: NetworkImage(
                              'https://res.cloudinary.com/gogrocy/image/upload/v1/' +
                                  usableCartList.cart[index].image),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(usableCartList.cart[index].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14.0)),
                          Text('₹' + usableCartList.cart[index].price,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: colors.primaryColor)),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: CartCounter(
                              maxQuantity: int.parse(
                                  usableCartList.cart[index].quantity),
                              orderedQuantity: int.parse(
                                  usableCartList.cart[index].quantity_ordered),
                              model: model,
                              index: index,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '₹ $totalCost',
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                              color: colors.primaryColor),
                          textAlign: TextAlign.right,
                        )),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
