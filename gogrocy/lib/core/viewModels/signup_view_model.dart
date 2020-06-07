import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/core/services/shared_prefs.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/views/signup_view.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class SignUpViewModel extends BaseModel {
  final Animation<double> womanScaleAnimation;
  final Animation<double> awesomeTextScaleAnimation;
  final Animation<double> formFadeAnimation;
  final AnimationController controller;

  final String mobile;
  final String countryCode;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  final FocusNode nameNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode cPasswordNode = FocusNode();
  final FocusNode addressNode = FocusNode();
  final FocusNode cityNode = FocusNode();
  final FocusNode pinCodeNode = FocusNode();

  final Apis _apiService = locator<Apis>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SharedPrefsService _sharedPrefsService = locator<SharedPrefsService>();

  final GlobalKey<FormState> detailsFormKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> signUpScaffoldKey = GlobalKey<ScaffoldState>();

  static SignUpView awesomeAnimationView = locator<SignUpView>();

  SignUpViewModel(
      {@required this.controller,
      @required this.mobile,
      @required this.countryCode})
      : womanScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.3, curve: Curves.easeOut),
          ),
        ),
        awesomeTextScaleAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.3, curve: Curves.easeOut),
          ),
        ),
        formFadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1.0,
              curve: Curves.easeOut,
            ),
          ),
        );

  Future<bool> signUpWithApi() async {
    print(md5.convert(utf8.encode(passwordController.text)).toString());
    print(passwordController.text);
    setState(ViewState.Busy);
    var signUp = await _apiService.signUpApi(
        name: nameController.text,
        countryCode: countryCode,
        password: md5.convert(utf8.encode(passwordController.text)).toString(),
        cPassword: md5.convert(utf8.encode(cPasswordController.text)).toString(),
        mobile: mobile,
        locality: addressController.text,
        city: cityController.text,
        zip: pinCodeController.text);
    setState(ViewState.Idle);
    if (signUp.success) {
      _sharedPrefsService.setLoggedIn(true);
      _navigationService.goBack();
      _navigationService.navigateTo('city');
      return true;
    } else {
      print(signUp.error);
      signUpScaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text("error")));
      return false;
    }
  }
}
