import 'package:flutter/material.dart';
import 'package:gogrocy/ui/shared/colors.dart';
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
      //autoFocus: true,

      autoDisposeControllers: false,
      length: 6,
      fieldHeight: 0.05 * constants.screenHeight,
      fieldWidth: 0.09 * constants.screenWidth,
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(12.0),
      borderWidth: 1.50,
      inactiveColor: Colors.black,
      textInputType: TextInputType.number,
      selectedColor: primaryColor,
      activeColor: Colors.green,
      disabledColor: Colors.black,
      onChanged: (String value) {},
    );
  }
}
