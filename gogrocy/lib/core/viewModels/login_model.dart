import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/services/authentication_service.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/service_locator.dart';

import 'base_model.dart';

//enum ViewState{ Idle, Busy }

class LoginModel extends BaseModel {
  final AuthenticationService authenticationService =
      locator<AuthenticationService>();
  final NavigationService navigationService = locator<NavigationService>();

  Future loginWithPhone(
      {@required BuildContext context, @required String phoneNumber}) async {
    setState(ViewState.Busy);

    var result =
        await authenticationService.verifyPhoneNumber(context, phoneNumber);

    setState(ViewState.Idle);

    if (result is bool) {
      if (result) {
        print('login success with phone number');
        navigationService.navigateTo('awesome', arguments: phoneNumber);
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
      @required String phoneNumber}) async {
    setState(ViewState.Busy);

    var result = await authenticationService.signInWithOtp(
        authenticationService.verificationId, otp);

    setState(ViewState.Idle);
    if (result is bool) {
      if (result) {
        print('login success with otp');
        navigationService.navigateTo('awesome', arguments: phoneNumber);
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
}
