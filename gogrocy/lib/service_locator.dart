import 'package:get_it/get_it.dart';
import 'package:gogrocy/core/services/authentication_service.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/core/viewModels/login_model.dart';
import 'package:gogrocy/core/viewModels/startup_view_model.dart';
import 'package:gogrocy/ui/views/awesome_animation_view.dart';
import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/services/bottom_appbar_provider.dart';
import 'package:gogrocy/core/viewModels/allProducts_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<StartupViewModel>(() => StartupViewModel());
  locator.registerFactory<NavigationService>(() => NavigationService());
  locator.registerFactory<AuthenticationService>(() => AuthenticationService());
  locator.registerLazySingleton(() => AwesomeAnimationView());
  locator.registerFactory<LoginModel>(() => LoginModel());
  locator.registerLazySingleton(()=>Apis());
  locator.registerFactory(()=>AllProductsModel());
  locator.registerFactory(()=>BottomNavBarProvider());
}
