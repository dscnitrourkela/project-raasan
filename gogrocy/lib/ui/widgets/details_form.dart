import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/services/firestore_service.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/core/viewModels/signup_view_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/widgets/vertical_spaces.dart';
import 'package:provider/provider.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;

class DetailsForm extends StatefulWidget {
  final womanScaleController;
  final mobile;
  final countryCode;

  DetailsForm(this.womanScaleController, this.mobile, this.countryCode);

  @override
  _DetailsFormState createState() => _DetailsFormState();
}

class _DetailsFormState extends State<DetailsForm> {
  final NavigationService navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (context) => SignUpViewModel(
          controller: widget.womanScaleController,
          mobile: widget.mobile,
          countryCode: widget.countryCode),
      child: Consumer<SignUpViewModel>(
        builder: (context, model, child) => FadeTransition(
          opacity: model.formFadeAnimation,
          child: Form(
            key: model.detailsFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('What do we call you?'),
                VerticalSpaces.small10,
                SizedBox(
                  width: constants.SignUpConfig.textFieldWidth,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    focusNode: model.nameNode,
                    onFieldSubmitted: (value) {
                      model.addressNode.requestFocus();
                    },
                    controller: model.nameController,
                    validator: (value) {
                      if (value.isEmpty)
                        return "Enter your name";
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Name',
                    ),
                  ),
                ),
                VerticalSpaces.small20,
                Text('Where do you live?'),
                VerticalSpaces.small10,
                SizedBox(
                  width: constants.SignUpConfig.textFieldWidth,
                  child: TextFormField(
                    controller: model.addressController,
                    focusNode: model.addressNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      model.cityNode.requestFocus();
                    },
                    validator: (value) {
                      if (value.isNotEmpty) {
                        return null;
                      } else {
                        return "Enter an address";
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'House/ Flat Number, Locality',
                    ),
                  ),
                ),
                VerticalSpaces.small20,
                SizedBox(
                  width: constants.SignUpConfig.textFieldWidth,
                  child: TextFormField(
                    controller: model.cityController,
                    textInputAction: TextInputAction.next,
                    focusNode: model.cityNode,
                    onFieldSubmitted: (value) {
                      model.pinCodeNode.requestFocus();
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter city name";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'City',
                    ),
                  ),
                ),
                VerticalSpaces.small20,
                SizedBox(
                  width: constants.SignUpConfig.textFieldWidth,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    controller: model.pinCodeController,
                    focusNode: model.pinCodeNode,
                    validator: (value) {
                      if (value.length != 6) {
                        return "Pincode must be 6 digits";
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (value) {
                      model.passwordNode.requestFocus();
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Pincode',
                    ),
                  ),
                ),
                VerticalSpaces.small20,
                Text(
                  'Create password',
                  style: TextStyle(fontSize: 0.034 * constants.screenWidth),
                ),
                VerticalSpaces.small10,
                SizedBox(
                  width: constants.SignUpConfig.textFieldWidth,
                  child: TextFormField(
                    focusNode: model.passwordNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      model.cPasswordNode.requestFocus();
                    },
                    validator: (value) {
                      if (value.length < 8) {
                        return "Password should be at least 8 characters";
                      } else {
                        return null;
                      }
                    },
                    controller: model.passwordController,
                    obscureText: true,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter password',
                    ),
                  ),
                ),
                VerticalSpaces.small20,
                SizedBox(
                  width: constants.SignUpConfig.textFieldWidth,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isNotEmpty &&
                          value != null &&
                          value != model.passwordController.text) {
                        model.passwordController.clear();
                        model.cPasswordController.clear();
                        return "Password should match in both fields";
                      } else {
                        return null;
                      }
                    },
                    focusNode: model.cPasswordNode,
                    textInputAction: TextInputAction.done,
                    controller: model.cPasswordController,
                    obscureText: true,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Confirm password',
                    ),
                  ),
                ),
                VerticalSpaces.small20,
                SizedBox(
                  width: constants.SignUpConfig.raisedButtonWidth,
                  height: constants.SignUpConfig.raisedButtonHeight,
                  child: model.state == ViewState.Idle
                      ? RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          color: Colors.black,
                          child: Text(
                            'Done',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            var result = await model.signUpWithApi();
                            if (result) {
                              FireStoreService.addUser(
                                  phoneNumber: widget.mobile,
                                  countryCode: widget.countryCode);
                            }
                          },
                        )
                      : CircularProgressIndicator(),
                ),
                VerticalSpaces.small10,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
