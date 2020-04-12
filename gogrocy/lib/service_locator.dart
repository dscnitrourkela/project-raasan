import 'package:get_it/get_it.dart';
import 'package:gogrocy/core/viewModels/login_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(LoginModel());
}