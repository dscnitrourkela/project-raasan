import 'package:flutter/material.dart';
import 'package:gogrocy/core/services/authentication_service.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;

class OtpTextField extends StatelessWidget {
  const OtpTextField(
      {Key key, @required this.otpFocusNode, @required this.controller})
      : super(key: key);

  final FocusNode otpFocusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      focusNode: otpFocusNode,
      controller: controller,
      onChanged: (value) {},
      onCompleted: (value) {},
      onSubmitted: (value) {
        locator<AuthenticationService>().signInWithOtp(
            locator<AuthenticationService>().verificationId, value);
      },
      //autoFocus: true,
      autoDisposeControllers: false,
      length: 6,
      fieldHeight: 0.071 * constants.screenHeight,
      fieldWidth: 0.105 * constants.screenWidth,
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(12.0),
      borderWidth: 1.50,
      inactiveColor: Colors.black,
      textInputType: TextInputType.number,
      selectedColor: Colors.lightGreen,
      activeColor: Colors.green,
      disabledColor: Colors.black,
    );
  }
}
