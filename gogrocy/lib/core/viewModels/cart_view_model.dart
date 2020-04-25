import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:gogrocy/service_locator.dart';

class CartViewModel extends BaseModel{
  Apis _apis=locator<Apis>();

  cart_list cartList;

  Future getCartList() async{
    setState(ViewState.Busy);
    cartList=await _apis.getCartList();
    setState(ViewState.Idle);
  }

}