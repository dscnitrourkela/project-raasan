import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/product.dart';
import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:gogrocy/service_locator.dart';

class AllProductsModel extends BaseModel{
  Apis _apis=locator<Apis>();

  List<Product> allProducts;

  Future getAllProducts() async{
    setState(ViewState.Busy);
    allProducts=await _apis.getAllProducts();
    setState(ViewState.Idle);
  }


}