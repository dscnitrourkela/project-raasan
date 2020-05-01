import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/orders.dart';
import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:gogrocy/service_locator.dart';

class OrderViewModel extends BaseModel {
  Orders orders;
  Apis _apis = locator<Apis>();

  Future getOrders() async {
    print("Model orders");
    setState(ViewState.Busy);
    orders = await _apis.getOrders();
    setState(ViewState.Idle);
  }
}
