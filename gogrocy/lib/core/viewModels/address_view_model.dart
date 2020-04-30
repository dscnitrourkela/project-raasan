import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/address.dart';
import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:gogrocy/service_locator.dart';

class AddressViewModel extends BaseModel {
  final Apis _apiService = locator<Apis>();

  List<Address> _addressList;

  List<Address> get addressList => _addressList;

  Future getAddresses() async {
    setState(ViewState.Busy);
    _addressList = await _apiService.getAddresses();
    setState(ViewState.Idle);
    notifyListeners();
  }
}
