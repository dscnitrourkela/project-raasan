import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gogrocy/core/viewModels/login_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/widgets/otp_field.dart';
import 'package:gogrocy/ui/widgets/snackbars.dart';
import 'package:gogrocy/ui/widgets/vertical_spaces.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 16 * constants.scaleRatio),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0 * constants.scaleRatio),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16 * constants.scaleRatio,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                'Let\'s Begin',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gilroy',
                    fontSize: 18 * constants.scaleRatio),
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
                      cursorColor: Colors.lightGreen,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Country code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10.0 * constants.scaleRatio,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7.851 * constants.scaleRatio,
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
                          Icons.check_circle,
                          size: 31.404 * constants.scaleRatio,
                        ),
                        onPressed: () async {
                          if (await model.checkInternetStatus()) {
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
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'You will receive an OTP for verifying this number',
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          EdgeInsets.only(left: 6.318 * constants.scaleRatio),
                      child: Visibility(
                        visible: passwordFocusNode.hasFocus,
                        child: IconButton(
                          icon: Icon(
                            Icons.check_circle,
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
              Text(
                'You will receive an OTP for verifying this number',
              ),
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
                    flex: 0,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 0.019 * constants.screenWidth),
                      child: Visibility(
                        visible: otpFocusNode.hasFocus,
                        child: IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            size: 0.094 * constants.screenWidth,
                          ),
                          onPressed: () {
                            model.loginWithOtp(
                                otp: otpController.text,
                                phoneNumber: phoneController.text,
                                context: context,
                                countryCode: countryCodeController.text);
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                            Navigator.of(context).pushNamed('awesome');
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Text('Retry'),
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
      focusNode: phoneFocusNode,
      textAlign: TextAlign.center,
      controller: phoneController,
      textInputAction: TextInputAction.next,
      validator: (value) {
        return value.length < 4 ? "Enter a correct mobile number" : null;
      },
      onFieldSubmitted: (value) async {
        if (model.loginFormKey.currentState.validate()) {
          if (await model.checkInternetStatus()) {
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
      cursorColor: Colors.lightGreen,
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
