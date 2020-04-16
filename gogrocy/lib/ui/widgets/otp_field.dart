import 'package:flutter/material.dart';
import 'package:gogrocy/core/services/authentication_service.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
      fieldHeight: 42.0,
      fieldWidth: 40.0,
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(12.0),
      borderWidth: 2.0,
      inactiveColor: Colors.black,
      textInputType: TextInputType.number,
      selectedColor: Colors.lightGreen,
      activeColor: Colors.green,
      disabledColor: Colors.black,
    );
  }
}
