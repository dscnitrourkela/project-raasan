import 'package:gogrocy/core/services/authentication_service.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:gogrocy/service_locator.dart';

class StartupViewModel extends BaseModel {
  final AuthenticationService authenticationService =
      locator<AuthenticationService>();

  Future handleStartUpLogic() async {
    final NavigationService navigationService = locator<NavigationService>();
    var hasLoggedInUser = await authenticationService.isUserLoggedIn();
    Future.delayed(Duration(seconds: 3), () {
      if (hasLoggedInUser) {
        //navigationService.goBack();
        navigationService.goBack();
        navigationService.navigateTo('home');
      } else {
        navigationService.goBack();
        navigationService.navigateTo('login');
      }
    });
  }
}
