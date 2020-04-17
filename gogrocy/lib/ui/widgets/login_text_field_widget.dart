import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gogrocy/core/viewModels/login_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/widgets/otp_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class LoginTextFieldWidget extends StatefulWidget {
  LoginTextFieldWidget();

  @override
  _LoginTextFieldWidgetState createState() => _LoginTextFieldWidgetState();
}

class _LoginTextFieldWidgetState extends State<LoginTextFieldWidget> {
  bool isOtpFieldActive = false;
  PageController controller = PageController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  FocusNode phoneFocusNode;
  FocusNode otpFocusNode;

  @override
  void initState() {
    super.initState();
    phoneFocusNode = FocusNode();
    otpFocusNode = FocusNode();
    phoneFocusNode.addListener(_onPhoneFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    phoneFocusNode.dispose();
    otpFocusNode.dispose();
  }

  _onPhoneFocusChange() {
    setState(() {});
  }

  Widget textFieldContainer(
      {TextFormField mobileTextField,
      PinCodeTextField otpTextField,
      LoginModel model}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
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
                    fontSize: 20.0),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: mobileTextField,
                  ),
                  Expanded(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Visibility(
                        visible: phoneFocusNode.hasFocus,
                        child: IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            size: 40.0,
                          ),
                          onPressed: () {
                            controller.animateToPage(1,
                                duration: Duration(milliseconds: 250),
                                curve: Curves.easeOut);
                            model.loginWithPhone(
                                context: context,
                                phoneNumber: phoneController.text);
                          },
                        ),
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

  Widget otpFieldContainer(
      {TextFormField mobileTextField,
      OtpTextField otpTextField,
      LoginModel model}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
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
                    fontSize: 20.0),
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
                      padding: EdgeInsets.only(left: 8.0),
                      child: Visibility(
                        visible: otpFocusNode.hasFocus,
                        child: IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            size: 40.0,
                          ),
                          onPressed: () {
                            model.loginWithOtp(
                                otp: otpController.text,
                                phoneNumber: phoneController.text,
                                context: context);
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

  TextFormField mobileTextField(TextEditingController phoneController) {
    return TextFormField(
      focusNode: phoneFocusNode,
      textAlign: TextAlign.center,
      controller: phoneController,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        controller.animateToPage(
          1,
          duration: Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
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
            height: 200.0,
            child: PageView(
              controller: controller,
              onPageChanged: (position) {
                if (position == 0) {
                  //FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(phoneFocusNode);
                } else {
                  //FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(otpFocusNode);
                }
              },
              children: <Widget>[
                textFieldContainer(
                  mobileTextField: mobileTextField(phoneController),
                  model: model,
                ),
                otpFieldContainer(
                  otpTextField: OtpTextField(
                      otpFocusNode: otpFocusNode, controller: otpController),
                  model: model,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
