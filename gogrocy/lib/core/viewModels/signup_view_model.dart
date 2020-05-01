import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/core/services/shared_prefs.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/views/signup_view.dart';

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
    var signUp = await _apiService.signUpApi(
        name: nameController.text,
        countryCode: countryCode,
        password: passwordController.text,
        cPassword: cPasswordController.text,
        mobile: mobile,
        locality: addressController.text,
        city: cityController.text,
        zip: pinCodeController.text);
    if (signUp.success) {
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
