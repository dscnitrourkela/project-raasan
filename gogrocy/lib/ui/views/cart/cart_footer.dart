import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/models/address.dart';
import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/viewModels/cart_view_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/shared/colors.dart' as colors;
import 'package:gogrocy/ui/shared/constants.dart' as constants;

typedef void OrderButtonPressed();

class CartFooter extends StatefulWidget {
  final CartViewModel model;

  CartFooter(this.model);

  @override
  _CartFooterState createState() => _CartFooterState();
}

class _CartFooterState extends State<CartFooter> {
  List<Address> addressList;
  Apis apis = locator<Apis>();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    int cost = widget.model.cartList.sum > 499
        ? widget.model.cartList.sum
        : (widget.model.cartList.sum + 20);
    return FutureBuilder(
        future: apis.getAddresses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return Column(
              children: <Widget>[
                Container(
                  width: double.maxFinite,
                  color: Color.fromRGBO(255, 248, 211, 0.3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Payment",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Total order is Rs $cost",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "Order will be received in 4 hours \n Payment has to be made to the delivery executive"),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Delivering to:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            addressDetails(snapshot.data[selectedIndex]),
                            Builder(builder: (context) {
                              return changeButton(snapshot.data);
                            }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                orderButton(
                    addressId: snapshot.data[selectedIndex].addressId,
                    callback: () {
                      print("Callback is succeeding");
                      widget.model.getCartList(productId: null, quantity: null);
                    }),
              ],
            );
          else
            return Center(
              child: CircularProgressIndicator(),
            );
        });
  }

  Widget addressDetails(Address address) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Text(address.locality),
          Text(address.city + ", " + address.state),
        ],
      ),
    );
  }

  Widget changeButton(List<Address> list) {
    return RawMaterialButton(
      elevation: 0.0,
      onPressed: () {
        showDialog(
            context: context,
            builder: (_) {
              return addressDialog(list);
            });
      },
      focusElevation: 0,
      focusColor: colors.VIEW_ALL_BUTTON_BACKGROUND,
      fillColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      child: SizedBox(
        width: constants.HomePageConfig.viewAllButtonWidth,
        height: constants.HomePageConfig.viewAllButtonHeight,
        child: Center(
          child: Text(
            'Change',
            style: TextStyle(
                color: colors.PRIMARY_COLOR,
                fontSize: 13.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget addressDialog(List<Address> list) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        color: Color.fromRGBO(255, 248, 211, 0.3),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Choose delivery address",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              ListView.separated(
                  itemCount: list.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;

                          Navigator.pop(context);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Card(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                list[index].locality,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                list[index].city + ", " + list[index].zip,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                list[index].state,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget orderButton({OrderButtonPressed callback, String addressId}) {
    return FlatButton(
      color: Color.fromRGBO(255, 193, 72, 0.3),
      onPressed: () async {
        bool orderStatus = await apis.placeOrder(addressId: addressId);
        if (orderStatus) {
          Flushbar(
            messageText: Text(
              "Order placed successfully!",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            duration: Duration(seconds: 2),
            flushbarStyle: FlushbarStyle.FLOATING,
            icon: Icon(
              Icons.check,
              color: colors.PRIMARY_COLOR,
            ),
            barBlur: 0.9,
            margin: EdgeInsets.all(8.0),
            borderRadius: 8.0,
            backgroundColor: Colors.white,
            boxShadows: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 0.0),
                blurRadius: 5.0,
              )
            ],
          )..show(context);
          widget.model.getCartList(productId: null, quantity: null);
        } else
          Flushbar(
            messageText: Text(
              "Error while placing order",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            duration: Duration(seconds: 2),
            flushbarStyle: FlushbarStyle.FLOATING,
            icon: Icon(
              Icons.error,
              color: Colors.red,
            ),
            barBlur: 0.9,
            margin: EdgeInsets.all(8.0),
            borderRadius: 8.0,
            backgroundColor: Colors.white,
            boxShadows: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 0.0),
                blurRadius: 5.0,
              )
            ],
          )..show(context);
        print("Order Placed");
      },
      child: Text("Place Order",
          style: TextStyle(
              color: Color.fromRGBO(255, 193, 72, 1), fontSize: 16.0)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
    );
  }
}
