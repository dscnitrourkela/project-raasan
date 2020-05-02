import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/models/address.dart';
import 'package:gogrocy/core/models/orders.dart';
import 'package:gogrocy/core/models/ProductsByCity.dart';
import 'package:gogrocy/core/models/cart_edit.dart';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/core/models/place_order.dart';
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
const String addAddress = baseUrl + "add_address";
const String cartList = baseUrl + 'getCartItems';
const String editCart = baseUrl + "add_to_cart";
const String getAddress = baseUrl + "getAddress";
const String orderRequest = baseUrl + "placeOrder";
const String getOrders = baseUrl + "getorders";
const String getProductsByCityRequest = baseUrl + "getProductsByCity";
const String getCategoriesByCityRequest = baseUrl + "getProductsByCategory";
const String getOrderRequest = baseUrl + "getorders";
const String searchByCity = baseUrl + "searchProductsByCity";

class Apis {
  final SharedPrefsService _sharedPrefsService = locator<SharedPrefsService>();

  Future<UserStatus> getUserStatus(
      {@required String mobile, @required String countryCode}) async {
    Map<String, String> body = {"mobile": mobile, "country_code": countryCode};
    return UserStatus.fromJson(
        json.decode((await http.post(userStatus, body: body)).body));
  }

  Future<bool> addToCart({
    @required String quantity,
    @required String productId,
  }) async {
    Map<String, String> body = {"quantity": quantity, "product_id": productId};
    String jwt = await _sharedPrefsService.getJWT();
    var result = json.decode((await http.post(
      editCart,
      body: body,
      headers: {
        'Authorization': 'Bearer $jwt',
      },
    ))
        .body);
    return result["success"];
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
    print(body);
    print("ADDDRESSSSSS     " + jwt);
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
        print("LOGIN             " + user.jwt);
        Future.delayed(
          Duration(milliseconds: 10),
          () async {
            await verifyUserApi(user.jwt);
            await addAddressApi(
              name: name,
              locality: locality,
              city: city,
              contact: mobile,
              pinCode: zip,
              jwt: user.jwt,
            );
          },
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
    Map<String, String> body = {"product_id": product_id, "quantity": quantity};
    String jwt = await _sharedPrefsService.getJWT();
    var client = new http.Client();
    bool connectionState = await checkStatus();
    if (connectionState) //TODO: Add a proper else return
    {
      var response = await client.post(editCart,
          headers: {
            'Authorization': 'Bearer $jwt',
          },
          body: body);
      return CartEdit.fromJson(json.decode(response.body));
    } else
      (print("Network failure"));
  }

  Future<bool> placeOrder({@required String addressId}) async {
    Map<String, String> body = {
      "address_id": addressId,
    };
    String jwt = await _sharedPrefsService.getJWT();
    var client = new http.Client();
    bool connectionState = await checkStatus();
    if (connectionState) //TODO: Add a proper else return
    {
      try{
        var response = await client.post(orderRequest,
            headers: {
              'Authorization': 'Bearer $jwt',
            },
            body: body);
        if(PlaceOrder.fromJson(json.decode(response.body)).success)
          return true;
        else return false;
      }
      catch(e)
      {
        print(e);
        return false;
      }
    } else
      return false;
  }

  Future<ProductsByCity> getProductsByCity() async {
    Map<String, String> body = {
      "city": await _sharedPrefsService.getCity(),
      // TODO: Add city here from SharedPrefs
    };
    String jwt = await _sharedPrefsService.getJWT();
    var client = new http.Client();
    bool connectionState = await checkStatus();
    if (connectionState) //TODO: Add a proper else return
    {
      var response = await client.post(getProductsByCityRequest,
          headers: {
            'Authorization': 'Bearer $jwt',
          },
          body: body);
      return ProductsByCity.fromJson(json.decode(response.body));
    } else
      return null;
  }

  Future<ProductsByCity> getProductsByCityCategory(String cat_id) async {
    Map<String, String> body = {
      "city": await _sharedPrefsService.getCity(),
      // TODO: Add city here from SharedPrefs
      "cat_id": cat_id
    };
    String jwt = await _sharedPrefsService.getJWT();
    var client = new http.Client();
    bool connectionState = await checkStatus();
    if (connectionState) //TODO: Add a proper else return
    {
      var response = await client.post(getCategoriesByCityRequest,
          headers: {
            'Authorization': 'Bearer $jwt',
          },
          body: body);
      return ProductsByCity.fromJson(json.decode(response.body));
    } else
      return null;
  }

  Future<ProductsByCity> searchProductByCity(String query) async {
    Map<String, String> body = {
      "city": await _sharedPrefsService.getCity(),
      // TODO: Add city here from SharedPrefs
      "query": query
    };
    String jwt = await _sharedPrefsService.getJWT();
    var client = new http.Client();
    bool connectionState = await checkStatus();
    if (connectionState) //TODO: Add a proper else return
    {
      var response = await client.post(searchByCity,
          headers: {
            'Authorization': 'Bearer $jwt',
          },
          body: body);
      return ProductsByCity.fromJson(json.decode(response.body));
    } else
      return null;
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

  Future<List<Product>> getCityProductsByCategory() async {
    var client = new http.Client();
    bool connectionState = await checkStatus();
    String jwt = await _sharedPrefsService.getJWT();
    Map<String, String> body = {
      "city": await _sharedPrefsService.getCity(),
      // TODO: Add city here from SharedPrefs
    };
    if (connectionState) //TODO: Add a proper else return
    {
      var products = List<Product>();
      var response = await client.post(allProducts,
          headers: {
            'Authorization': 'Bearer $jwt',
          },
          body: body);
      var parsed = json.decode(
        response.body,
      ) as List<dynamic>;
      for (var product in parsed) {
        products.add(Product.fromJson(product));
      }
      return products;
    } else {
      print("Network failure");
      return null;
    }
  }

  Future<List<Address>> getAddresses() async {
    var client = new http.Client();
    bool connectionState = await checkStatus();
    String jwt = await _sharedPrefsService.getJWT();
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
    } else {
      print('Network Failure');
      return null;
    }
  }

  Future<Orders> getOrders() async {
    var client = new http.Client();
    bool connectionState = await checkStatus();
    String jwt = await _sharedPrefsService.getJWT();
    if (connectionState) //TODO: Add a proper else return
    {
      var response = await client.post(getOrderRequest, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      });
      return Orders.fromJson(json.decode(response.body));
    } else {
      print("Network failure");
      return null;
    }
  }

  Future<CartDataModel> getCartList() async {
    var client = http.Client();
    bool connectionState = await checkStatus();
    String jwt = await _sharedPrefsService.getJWT();
    if (connectionState) //TODO: Add a proper else return
    {
      var response = await client.post(cartList, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      });
      return CartDataModel.fromJson(json.decode(response.body));
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
    if ((json.decode(result.body))["success"]) {
      print("VERIFIED USER");
      return true;
    } else
      return false;
  }
}
