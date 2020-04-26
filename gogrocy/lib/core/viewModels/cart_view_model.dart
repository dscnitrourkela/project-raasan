import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/cart_edit.dart';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:gogrocy/service_locator.dart';

class CartViewModel extends BaseModel{
  Apis _apis=locator<Apis>();

  cart_list cartList;
  cart_list intermediateCartList;
  CartEdit cartEditResponse;

  Future getCartList({String product_id, String quantity}) async{

    if(product_id==null){
      print("First time API called");
      setState(ViewState.Busy);
      cartList=await _apis.getCartList();
      setState(ViewState.Idle);
    }
    if(product_id!=null){
      print("Updating API calledUpdating API calledUpdating API calledUpdating API calledUpdating API called");
      intermediateCartList=cartList;
      setState(ViewState.Intermediate);
      print("Updating API calledUpdating API calledUpdating API calledUpdating API calledUpdating API called");
      cartEditResponse=await _apis.editCartList(product_id: product_id, quantity: quantity);
      cartList=await _apis.getCartList();
      setState(ViewState.Idle);

    }

  }

  Future editCartList(String product_id, String quantity) async{
    setState(ViewState.Busy);
    await _apis.editCartList(product_id: product_id, quantity: quantity);
    setState(ViewState.Idle);

  }

}