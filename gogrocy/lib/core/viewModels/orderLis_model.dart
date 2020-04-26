import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/Orders.dart';
import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:gogrocy/service_locator.dart';

class OrderViewModel extends BaseModel {

  Orders orders;

  Future getOrders()async{
    setState(ViewState.Busy);
    Apis _apis=locator<Apis>();
    orders=await _apis.getOrders();
    setState(ViewState.Idle);
  }



}
