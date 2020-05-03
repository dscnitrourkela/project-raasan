import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/models/sign_up_arguments.dart';
import 'package:gogrocy/core/models/user.dart';
import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/services/authentication_service.dart';
import 'package:gogrocy/core/services/firestore_service.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/core/services/shared_prefs.dart';
import 'package:gogrocy/service_locator.dart';

import 'base_model.dart';

class LoginModel extends BaseModel {
  final AuthenticationService authenticationService =
      locator<AuthenticationService>();
  final NavigationService navigationService = locator<NavigationService>();
  final Apis _apiService = locator<Apis>();
  final SharedPrefsService _sharedPrefsService = locator<SharedPrefsService>();

  GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();

  String errorMessage;

  Future<String> getUserStatus(String mobile, String countryCode) async {
    setState(ViewState.Busy);
    var result = await _apiService.getUserStatus(
        mobile: mobile, countryCode: countryCode);
    setState(ViewState.Idle);
    return result.status;
  }

  Future loginWithPhone(
      {@required BuildContext context,
      @required String phoneNumber,
      @required String countryCode}) async {
    //var internetStatus = await checkInternetStatus();
    //setState(ViewState.Busy);

    //var finalNumber = countryCode + " " + phoneNumber;

    var result = await authenticationService.verifyPhoneNumber(
        context, phoneNumber, countryCode);

    //setState(ViewState.Idle);

    if (result is bool) {
      if (result) {
        print('login success with phone number');
        navigationService.goBack();
        navigationService.navigateTo('awesome',
            arguments: SignUpArguments(phoneNumber, countryCode));
      } else {
        print('login unsuccessful with phone number');
      }
    } else {
      print(result);
    }
  }

  Future loginWithOtp(
      {@required BuildContext context,
      @required String otp,
      @required String phoneNumber,
      @required String countryCode}) async {
    setState(ViewState.Busy);

    var result =
    await authenticationService.signInWithOtp(
        authenticationService.verificationId, otp);

    setState(ViewState.Idle);

    if (result is bool) {
      if (result) {
        print('login success with otp');
        navigationService.goBack();
        navigationService.navigateTo('awesome',
            arguments: SignUpArguments(phoneNumber, countryCode));
      } else {
        print('login unsuccessful with otp');
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Unsuccessful'),
          ),
        );
      }
    } else {
      print(result);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Unsuccessful'),
        ),
      );
    }
  }

  Future<User> loginWithApi(
      {@required String phoneNumber,
      @required String countryCode,
      @required String password}) async {
    setState(ViewState.Busy);
    var citySelected = (await _sharedPrefsService.getCity()) != null;
    var user = await _apiService.loginApi(
        mobile: phoneNumber, countryCode: countryCode, password: password);
    setState(ViewState.Idle);
    if (user.success) {
      _sharedPrefsService.setJWT(user.jwt);
      print('Login With Password successful');
      FireStoreService.addUser(
          phoneNumber: phoneNumber, countryCode: countryCode);
      print(_sharedPrefsService.setLoggedIn(true));
      if (citySelected) {
        navigationService.goBack();
        navigationService.navigateTo('home');
      } else {
        navigationService.goBack();
        navigationService.navigateTo('city');
      }
    } else {
      print(user.message);
      errorMessage = user.message;
    }
    return user;
  }

  checkInternetStatus() {
    return true;
  }
}
