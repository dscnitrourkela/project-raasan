import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/models/Address.dart';
import 'package:gogrocy/core/models/cart_edit.dart';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/core/models/product.dart';
import 'package:gogrocy/core/models/signup_model.dart';
import 'package:gogrocy/core/models/user.dart';
import 'package:gogrocy/core/models/user_status.dart';
import 'package:gogrocy/core/services/shared_prefs.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "https://gogrocy.in/api/";
const String TOKEN =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1ODY5NzYxMjEsImlzcyI6Imh0dHBzOlwvXC9nb2dyb2N5LmluXC8iLCJuYmYiOjE1ODY5NzYxMzEsImRhdGEiOnsidXNlcl9pZCI6Ijg1IiwidXNlcl9yb2xlIjoiMSJ9fQ.3jwji_K1l07ttdUUjn4UJbJfuAbrC0msqk7jeftpSzDR7u2d8RCiGWz3ritX3hQIa0MGUe2fIaidErX-xtTQdA';

const String allProducts = baseUrl + "getProducts";
const String singleProduct = baseUrl + "getProduct";
const String userStatus = baseUrl + "checkMobile";
const String login = baseUrl + "login";
const String signUp = baseUrl + "signup";
const String verifyUser = baseUrl + "verifyUser";
const String addAddress = baseUrl + "add_address";
const String cartList = baseUrl + 'getCartItems';
const String editCart=baseUrl+ "add_to_cart";
const String getAddress=baseUrl+"getAddress";

class Apis {
  final SharedPrefsService _sharedPrefsService = locator<SharedPrefsService>();

  Future<UserStatus> getUserStatus(
      {@required String mobile, @required String countryCode}) async {
    Map<String, String> body = {"mobile": mobile, "country_code": countryCode};
    return UserStatus.fromJson(
        json.decode((await http.post(userStatus, body: body)).body));
  }

  Future<bool> addAddressApi(
      {@required String name,
      @required String locality,
      @required String city,
      @required String contact,
      @required String pinCode,
      @required String jwt}) async {
    Map<String, String> body = {
      "name": name,
      "locality": locality,
      "contact": contact,
      "city": city,
      "zip": pinCode,
      "state": "Odisha",
      "country": "India",
    };
    http.Response result = await http.post(addAddress,
        headers: {HttpHeaders.authorizationHeader: "Bearer $jwt"}, body: body);
    print(result.body);
    if ((json.decode(result.body))["success"]) {
      print("Add Address success");
      return true;
    } else
      print("add address fail");
    return false;
  }

  Future<SignUpModel> signUpApi(
      {@required String name,
      @required String countryCode,
      @required String password,
      @required String cPassword,
      @required String mobile,
      @required String city,
      @required String locality,
      @required String zip}) async {
    Map<String, String> body = {
      "name": name,
      "country_code": countryCode,
      "password": password,
      "cpassword": cPassword,
      "mobile": mobile
    };
    var signUpModel = SignUpModel.fromJson(
        json.decode((await http.post(signUp, body: body)).body));
    if (signUpModel.success) {
      print("signUpModel success");
      var user = await loginApi(
          mobile: mobile, countryCode: countryCode, password: password);
      print("login via sign up success");
      if (user.jwt != null) {
        await verifyUserApi(user.jwt);
        await addAddressApi(
          name: name,
          locality: locality,
          city: city,
          contact: mobile,
          pinCode: zip,
          jwt: user.jwt,
        );
      } else {
        print("JWT FAIL: ACCOUNT NOT VALIDATED");
      }
      return signUpModel;
    } else {
      print("signup model fail");
      return signUpModel;
    }
  }

  Future<User> loginApi(
      {@required String mobile,
      @required String countryCode,
      @required String password}) async {
    Map<String, String> body = {
      "mobile": mobile,
      "password": password,
      "country_code": countryCode
    };

    var user =
        User.fromJson(json.decode((await http.post(login, body: body)).body));
    if (user.success) {
      _sharedPrefsService.setJWT(user.jwt);
      return user;
    } else {
      return user;
    }
  }

  Future<CartEdit> editCartList(
      {@required String product_id, @required String quantity}) async {
    Map<String,String>body={
      "product_id":product_id,
      "quantity":quantity
    };
    String jwt=await _sharedPrefsService.getJWT();
    var client = new http.Client();
    bool connectionState = await checkStatus();
    if (connectionState) //TODO: Add a proper else return
    {
      var response = await client.post(editCart, headers: {
        'Authorization': 'Bearer $jwt',
      },body: body);
      return CartEdit.fromJson(json.decode(response.body));
    } else
      (print("Network failure"));
  }

  Future<List<Product>> getAllProducts() async {
    var client = new http.Client();
    bool connectionState = await checkStatus();
    if (connectionState) //TODO: Add a proper else return
    {
      var products = List<Product>();
      var response = await client.post(allProducts);
      var parsed = json.decode(response.body) as List<dynamic>;
      for (var product in parsed) {
        products.add(Product.fromJson(product));
      }
      return products;
    } else {
      print("Network failure");
      return null;
    }
  }

  Future<List<Address>> getAddresses() async{
    var client = new http.Client();
    bool connectionState = await checkStatus();
    String jwt=await _sharedPrefsService.getJWT();
    if (connectionState) //TODO: Add a proper else return
        {
      var address = List<Address>();
      var response = await client.post(getAddress, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      });
      var parsed = json.decode(response.body) as List<dynamic>;
      for (var product in parsed) {
        address.add(Address.fromJson(product));
      }
      return address;
    } else
      (print("Network failure"));
  }


  Future<cart_list> getCartList() async {
    var client = new http.Client();
    bool connectionState = await checkStatus();
    String jwt=await _sharedPrefsService.getJWT();
    if (connectionState) //TODO: Add a proper else return
    {
      var response = await client.post(cartList, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      });
      return cart_list.fromJson(json.decode(response.body));
    } else
      (print("Network failure"));
  }

  Future<bool> checkStatus() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
    return false;
  }

  Future<bool> verifyUserApi(String jwt) async {
    http.Response result = await http.post(verifyUser,
        headers: {HttpHeaders.authorizationHeader: "Bearer $jwt"});
    if ((json.decode(result.body))["success"])
      return true;
    else
      return false;
  }
}
