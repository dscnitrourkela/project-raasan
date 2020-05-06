import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:gogrocy/service_locator.dart';

class ProductDetailModel extends BaseModel {
  final Apis _apiService = locator<Apis>();

  String message;

  Future<bool> addToCart(String productId) async {
    return await _apiService.addToCart(quantity: "1", productId: productId);
  }
}
