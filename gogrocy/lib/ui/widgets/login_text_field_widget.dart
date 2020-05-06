import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/core/viewModels/login_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/shared/colors.dart';
import 'package:gogrocy/ui/widgets/otp_field.dart';
import 'package:gogrocy/ui/widgets/snackbars.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;

class LoginTextFieldWidget extends StatefulWidget {
  LoginTextFieldWidget();

  @override
  _LoginTextFieldWidgetState createState() => _LoginTextFieldWidgetState();
}

class _LoginTextFieldWidgetState extends State<LoginTextFieldWidget> {
  bool userSignedUp = false;
  bool isOtpFieldActive = false;
  PageController controller = PageController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  FocusNode phoneFocusNode;
  FocusNode otpFocusNode;
  FocusNode passwordFocusNode;
  final _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    phoneFocusNode = FocusNode();
    otpFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    countryCodeController.text = "+91";
    phoneFocusNode.addListener(_onPhoneFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    otpController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    phoneFocusNode.dispose();
    otpFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  _onPhoneFocusChange() {
    setState(() {});
  }

  Widget textFieldContainer(
      {TextFormField mobileTextField,
      PinCodeTextField otpTextField,
      LoginModel model}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0365 * constants.screenWidth),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0.039 * constants.screenWidth),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.039 * constants.screenWidth,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                'Let\'s Begin ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gilroy',
                    fontSize: 0.044 * constants.screenWidth),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: countryCodeController,
                      validator: (value) {
                        return value.isNotEmpty ? null : "Enter country code";
                      },
                      cursorColor: primaryColor,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Country code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            0.024 * constants.screenWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 0.019 * constants.screenWidth,
                  ),
                  Expanded(
                    flex: 4,
                    child: mobileTextField,
                  ),
                  Expanded(
                    flex: 0,
                    child: Visibility(
                      visible: phoneFocusNode.hasFocus,
                      child: IconButton(
                        icon: Icon(
                          Icons.check_circle_outline,
                          color:
                              model.hasConnection ? primaryColor : Colors.grey,
                          size: 0.0976 * constants.screenWidth,
                        ),
                        onPressed: () async {
                          if (model.loginFormKey.currentState.validate()) {
                            if (model.hasConnection) {
                              var status = await model.getUserStatus(
                                  phoneController.text,
                                  countryCodeController.text);
                              print(status);
                              switch (status) {
                                case '0':
                                  controller.animateToPage(1,
                                      duration: Duration(milliseconds: 250),
                                      curve: Curves.easeOut);
                                  model.loginWithPhone(
                                      context: context,
                                      phoneNumber: phoneController.text,
                                      countryCode: countryCodeController.text);

                                  break;
                                case '1':
                                  controller.animateToPage(1,
                                      duration: Duration(milliseconds: 250),
                                      curve: Curves.easeOut);
                                  model.loginWithPhone(
                                      context: context,
                                      phoneNumber: phoneController.text,
                                      countryCode: countryCodeController.text);
                                  break;
                                case '2':
                                  setState(() {
                                    userSignedUp = true;
                                  });
                                  controller.animateToPage(1,
                                      duration: Duration(milliseconds: 250),
                                      curve: Curves.easeOut);
                              }
                            } else {
                              model.loginScaffoldKey.currentState
                                  .showSnackBar(SnackBars.noInternetSnackBar);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Verification will be done via OTP for new users and via password for existing users',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordFieldContainer(TextFormField passwordField, LoginModel model) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.047 * constants.screenWidth),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.047 * constants.screenWidth,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                'Enter Password',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gilroy',
                    fontSize: 0.047 * constants.screenWidth),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: passwordField,
                  ),
                  Expanded(
                    flex: 0,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 0.0146 * constants.screenWidth),
                      child: Visibility(
                        visible: passwordFocusNode.hasFocus,
                        child: IconButton(
                          icon: Icon(
                            Icons.check_circle_outline,
                            color: primaryColor,
                            size: 0.094 * constants.screenWidth,
                          ),
                          onPressed: () async {
                            model.loginWithApi(
                                phoneNumber: phoneController.text,
                                countryCode: countryCodeController.text,
                                password: passwordController.text);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              model.errorMessage != null
                  ? Text(model.errorMessage)
                  : Container(),
              FlatButton(
                child: Text('Forgot password?'),
                onPressed: () {
                  _navigationService.navigateTo('web',
                      arguments: 'https://gogrocy.in/forgot_password');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget otpFieldContainer(
      {TextFormField mobileTextField,
      OtpTextField otpTextField,
      LoginModel model}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.047 * constants.screenWidth),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.047 * constants.screenWidth,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 1.0,
              ),
              Text(
                'Enter OTP',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gilroy',
                    fontSize: 0.047 * constants.screenWidth),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: otpTextField,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 0.019 * constants.screenWidth),
                      child: IconButton(
                        icon: Icon(
                          Icons.check_circle_outline,
                          color: primaryColor,
                          size: 0.094 * constants.screenWidth,
                        ),
                        onPressed: () {
                          if (otpController.text.length == 6) {
                            model.loginWithOtp(
                                otp: otpController.text,
                                phoneNumber: phoneController.text,
                                context: context,
                                countryCode: countryCodeController.text);
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                          } else {
                            Flushbar(
                              message: 'OTP must be 6 digits',
                              duration: Duration(seconds: 2),
                            ).show(context);
                          }
                          //Navigator.of(context).pushNamed('awesome');
                        },
                      ),
                    ),
                  ),
                ],
              ),
              FlatButton(
                child: Text('Retry'),
                onPressed: () {
                  controller.animateToPage(0,
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeOut);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      focusNode: passwordFocusNode,
      textAlign: TextAlign.center,
      controller: passwordController,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) {},
      cursorColor: Colors.lightGreen,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    );
  }

  TextFormField mobileTextField(LoginModel model) {
    return TextFormField(
      enableInteractiveSelection: false,
      key: model.phoneFormKey,
      focusNode: phoneFocusNode,
      textAlign: TextAlign.center,
      controller: phoneController,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value.length > 3 && value.length < 13) {
          String pattern = "[0-9]+\$";
          RegExp regExp = RegExp(pattern);
          if (regExp.hasMatch(value)) {
            return null;
          } else {
            return "Enter a correct phone number";
          }
        } else {
          return "Enter correct phone number";
        }
      },
      onFieldSubmitted: (value) async {
        if (model.loginFormKey.currentState.validate()) {
          if (model.hasConnection) {
            var status = await model.getUserStatus(
                phoneController.text, countryCodeController.text);
            print(status);
            switch (status) {
              case '0':
                controller.animateToPage(1,
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeOut);
                model.loginWithPhone(
                    context: context,
                    phoneNumber: phoneController.text,
                    countryCode: countryCodeController.text);
                break;
              case '1':
                controller.animateToPage(1,
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeOut);
                model.loginWithPhone(
                    context: context,
                    phoneNumber: phoneController.text,
                    countryCode: countryCodeController.text);
                break;
              case '2':
                setState(() {
                  userSignedUp = true;
                });
                controller.animateToPage(1,
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeOut);
            }
          } else {
            model.loginScaffoldKey.currentState
                .showSnackBar(SnackBars.noInternetSnackBar);
          }
        }
      },
      cursorColor: primaryColor,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Enter your mobile number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //print(isPhoneFieldActive.toString());
    print('primary ' + FocusScope.of(context).hasPrimaryFocus.toString());
    //TextEditingController phoneController = TextEditingController();
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => locator<LoginModel>(),
      child: Consumer<LoginModel>(
        builder: (context, model, child) => AnimatedPositioned(
          duration: Duration(milliseconds: 180),
          curve: Curves.easeOut,
          left: 0.0,
          right: 0.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10.0,
          child: SizedBox(
            height: 0.452 * constants.screenWidth,
            //width: 0.452 * constants.screenWidth,
            child: Form(
              key: model.loginFormKey,
              child: PageView(
                controller: controller,
                onPageChanged: (position) {
                  if (position == 0) {
                    FocusScope.of(context).requestFocus(phoneFocusNode);
                  } else {
                    if (!userSignedUp)
                      FocusScope.of(context).requestFocus(otpFocusNode);
                    else
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                  }
                },
                children: <Widget>[
                  textFieldContainer(
                    mobileTextField: mobileTextField(model),
                    model: model,
                  ),
                  userSignedUp
                      ? passwordFieldContainer(passwordField(), model)
                      : otpFieldContainer(
                          otpTextField: OtpTextField(
                              otpFocusNode: otpFocusNode,
                              controller: otpController),
                          model: model,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
