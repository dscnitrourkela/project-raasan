import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginTextFieldWidget extends StatefulWidget {
  LoginTextFieldWidget();

  @override
  _LoginTextFieldWidgetState createState() => _LoginTextFieldWidgetState();
}

class _LoginTextFieldWidgetState extends State<LoginTextFieldWidget> {
  bool isPhoneFieldActive = false;
  bool isOtpFieldActive = false;
  PageController controller = PageController();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode otpFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    phoneFocusNode.addListener(_onPhoneFocusChange);
    otpFocusNode.addListener(_onOtpFocusChange);
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  _onPhoneFocusChange() {
    setState(() {
      isPhoneFieldActive = !isPhoneFieldActive;
    });
  }

  _onOtpFocusChange() {
    setState(() {
      isOtpFieldActive = !isOtpFieldActive;
    });
  }

  Widget textFieldContainer(
      {TextFormField mobileTextField, PinCodeTextField otpTextField}) {
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
                        visible: isPhoneFieldActive,
                        child: IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            size: 40.0,
                          ),
                          onPressed: () {
                            //phoneFocusNode.unfocus();
                            FocusScope.of(context).requestFocus(otpFocusNode);
                            controller.animateToPage(1,
                                duration: Duration(milliseconds: 250),
                                curve: Curves.easeOut);
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
      {TextFormField mobileTextField, PinCodeTextField otpTextField}) {
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
                ],
              ),
              Text('Retry'),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField mobileTextField() {
    return TextFormField(
      focusNode: phoneFocusNode,
      textAlign: TextAlign.center,
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

  PinCodeTextField otpTextField() {
    return PinCodeTextField(
      focusNode: otpFocusNode,
      onChanged: (value) {},
      length: 6,
      fieldHeight: 42.0,
      fieldWidth: 40.0,
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(12.0),
      borderWidth: 2.0,
      inactiveColor: Colors.black,
      textInputType: TextInputType.number,
      activeColor: Colors.lightGreen,
      disabledColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(isPhoneFieldActive.toString());
    print('primary ' + FocusScope.of(context).hasPrimaryFocus.toString());
    return AnimatedPositioned(
      duration: Duration(milliseconds: 180),
      curve: Curves.easeOut,
      left: 0.0,
      right: 0.0,
      bottom: MediaQuery.of(context).viewInsets.bottom+10.0,
      child: SizedBox(
        height: 200.0,
        child: PageView(
          controller: controller,
          onPageChanged: (position){
            if(position!=0){
              otpFocusNode.unfocus();
              phoneFocusNode.requestFocus();
            }else{
              phoneFocusNode.unfocus();
              otpFocusNode.requestFocus();
            }
          },
          children: <Widget>[
            textFieldContainer(mobileTextField: mobileTextField()),
            otpFieldContainer(otpTextField: otpTextField()),
          ],
        ),
      ),
    );
  }
}
