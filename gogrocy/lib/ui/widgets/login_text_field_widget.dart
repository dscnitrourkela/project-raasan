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
  }


  @override
  void dispose() {
    phoneFocusNode.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  _onPhoneFocusChange(){
    setState(() {
      isPhoneFieldActive = !isPhoneFieldActive;
    });
  }

  Widget textFieldContainer({TextFormField mobileTextField, PinCodeTextField otpTextField}) {
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
                mobileTextField!=null?'Let\'s Begin':'Enter OTP',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gilroy',
                    fontSize: 20.0),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: mobileTextField!=null?mobileTextField:otpTextField,
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
                            phoneFocusNode.unfocus();
                            FocusScope.of(context).requestFocus(otpFocusNode);
                            setState(() {
                              isOtpFieldActive = !isOtpFieldActive;
                            });
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
              Text(mobileTextField!=null?'You will receive an OTP for verifying this number':'Retry')
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

  PinCodeTextField otpTextField(){
    return PinCodeTextField(
      focusNode: otpFocusNode,
      onChanged: (value){},
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
    print('primary '+ FocusScope.of(context).hasPrimaryFocus.toString());
    return AnimatedPositioned(
      duration: Duration(milliseconds: 180),
      curve: Curves.easeOut,
      left: 0.0,
      right: 0.0,
      bottom:
          isPhoneFieldActive ? (MediaQuery.of(context).viewInsets.bottom + 10.0) : 10.0,
      child: SizedBox(
        height: 200.0,
        child: PageView(
          controller: controller,
          children: <Widget>[
            textFieldContainer(mobileTextField: mobileTextField()),
            textFieldContainer(otpTextField: otpTextField()),
          ],
        ),
      ),
    );
  }
}
