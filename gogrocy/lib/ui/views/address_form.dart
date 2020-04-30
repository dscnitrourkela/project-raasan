import 'dart:ui';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/services/api.dart';
import 'package:gogrocy/core/services/shared_prefs.dart';
import 'package:gogrocy/core/viewModels/base_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/widgets/appbars/secondary_appbar.dart';
import 'package:gogrocy/ui/widgets/vertical_spaces.dart';

class AddressForm extends StatefulWidget {
  @override
  _AddressFormState createState() => _AddressFormState();
}

GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

class _AddressFormState extends State<AddressForm> {
  @override
  Widget build(BuildContext context) {
    return BaseView<AddressFormModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: SecondaryAppBar("Add an address"),
          body: Form(
            key: addressFormKey,
            child: ListView(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.0 * constants.scaleRatio),
              shrinkWrap: true,
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
                      model.phoneNode.requestFocus();
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
                SizedBox(
                  width: constants.SignUpConfig.textFieldWidth,
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    controller: model.phoneController,
                    focusNode: model.phoneNode,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter a correct phone number";
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (value) {},
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Phone Number',
                    ),
                  ),
                ),
                VerticalSpaces.small20,
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 80 * constants.scaleRatio),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.black,
                    child: Text(
                      'ADD',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      if (addressFormKey.currentState.validate()) {
                        var result = await model.addAddress();
                        if (result) {
                          Navigator.of(context).pop();
                          Flushbar(
                            message: "Address added successfully.",
                            duration: Duration(seconds: 1),
                          ).show(context);
                        } else
                          Flushbar(
                            message:
                                "Error adding address. Please try again later.",
                            duration: Duration(seconds: 3),
                          ).show(context);
                      }
                    },
                  ),
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

class AddressFormModel extends BaseModel {
  final Apis _apiService = locator<Apis>();
  final SharedPrefsService _sharedPrefsService = locator<SharedPrefsService>();

  @override
  void dispose() {
    pinCodeController.dispose();
    pinCodeNode.dispose();
    cityNode.dispose();
    nameNode.dispose();
    addressNode.dispose();
    phoneController.dispose();
    phoneNode.dispose();
    cityController.dispose();
    addressController.dispose();
    nameController.dispose();
    super.dispose();
  }

  TextEditingController pinCodeController = TextEditingController();
  FocusNode pinCodeNode = FocusNode();
  TextEditingController cityController = TextEditingController();
  FocusNode cityNode = FocusNode();
  FocusNode nameNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  FocusNode addressNode = FocusNode();
  TextEditingController phoneController = TextEditingController();
  FocusNode phoneNode = FocusNode();

  Future<bool> addAddress() async {
    var jwt = await _sharedPrefsService.getJWT();
    return await _apiService.addAddressApi(
        name: nameController.text,
        locality: addressController.text,
        city: cityController.text,
        contact: phoneController.text,
        pinCode: pinCodeController.text,
        jwt: jwt);
  }
}
