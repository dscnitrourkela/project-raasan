import 'package:flutter/cupertino.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/cart_edit.dart';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:gogrocy/service_locator.dart';

class CartViewModel extends BaseModel {
  Apis _apis = locator<Apis>();

  CartDataModel cartList;
  CartDataModel intermediateCartList;
  CartEditModel cartEditResponse;

  Future getCartList({String cart_id, String quantity}) async {
    if (cart_id == null) {
      print("First time API called");
      setState(ViewState.Busy);
      cartList = await _apis.getCartList();
      setState(ViewState.Idle);
    }
    if (cart_id != null) {
      print(
          "Updating API calledUpdating API calledUpdating API calledUpdating API calledUpdating API called");
      intermediateCartList = cartList;
      setState(ViewState.Intermediate);
      print(
          "Updating API calledUpdating API calledUpdating API calledUpdating API calledUpdating API called");
          //await _apis.editCartList(productId: productId, quantity: quantity);

      cartList=await _apis.editCart(cart_id:cart_id, quantity: quantity);
      setState(ViewState.Idle);
    }
  }

  Future editCartList(String cart_id, String quantity) async {
    setState(ViewState.Busy);
    intermediateCartList=cartList;
    setState(ViewState.Intermediate);
    cartList=await _apis.editCart(cart_id:cart_id, quantity: quantity);
    setState(ViewState.Idle);
    //getCartList();
  }

}
