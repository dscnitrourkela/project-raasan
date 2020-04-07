import 'package:get_it/get_it.dart';
import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/viewModels/allProducts_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(()=>Apis());
  locator.registerLazySingleton(()=>AllProductsModel());
}
