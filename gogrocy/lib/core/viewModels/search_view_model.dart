import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/ProductsByCity.dart';
import 'package:gogrocy/core/models/product.dart';
import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:gogrocy/service_locator.dart';

class SearchViewModel extends BaseModel{
  Apis _apis=locator<Apis>();

  ProductsByCity searchResults;

  Future getAllProducts(String query) async{
    setState(ViewState.Busy);
    searchResults=await _apis.searchProductByCity(query);
    //allProducts.result.shuffle();
    setState(ViewState.Idle);
  }


}