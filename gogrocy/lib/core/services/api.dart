import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:gogrocy/core/models/product.dart';
import 'package:gogrocy/core/models/signup_model.dart';
import 'package:gogrocy/core/models/user.dart';
import 'package:gogrocy/core/models/user_status.dart';
import 'package:gogrocy/core/services/shared_prefs.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "https://gogrocy.in/api/";

const String allProducts = baseUrl + "getProducts";
const String singleProduct = baseUrl + "getProduct";
const String userStatus = baseUrl + "checkMobile";
const String login = baseUrl + "login";
const String signUp = baseUrl + "signup";
const String verifyUser = baseUrl + "verifyUser";
const String addAddress = baseUrl + "";

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
      "state":"Odisha",
      "country":"India",
    };
    http.Response result = await http.post(addAddress,
        headers: {HttpHeaders.authorizationHeader: "Bearer $jwt"}, body: body);
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
      if (user.success) {
        print("login via sign up success");
        assert(await verifyUserApi(user.jwt), "verify user failed");
        assert(
            await addAddressApi(
                name: name,
                locality: locality,
                city: city,
                contact: mobile,
                pinCode: zip,
                jwt: user.jwt),
            "add address failed");
      } else {
        print("login via sign up fail");
        print(user.message);
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
