import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/ProductsByCity.dart';
import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:gogrocy/service_locator.dart';

class CategoryProductsViewModel extends BaseModel{
  Apis _apis=locator<Apis>();
  ProductsByCity categoryList;

  Future getProductsByCategory(String catId) async{
    setState(ViewState.Busy);
    categoryList=await _apis.getProductsByCityCategory(catId);
    setState(ViewState.Idle);
  }

}