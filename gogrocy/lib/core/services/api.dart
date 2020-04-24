import 'dart:convert';
import 'dart:io';
import 'package:gogrocy/core/models/cart_list.dart';
import 'package:gogrocy/core/models/product.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "https://gogrocy.in/api/";
const String TOKEN='eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1ODY5NzYxMjEsImlzcyI6Imh0dHBzOlwvXC9nb2dyb2N5LmluXC8iLCJuYmYiOjE1ODY5NzYxMzEsImRhdGEiOnsidXNlcl9pZCI6Ijg1IiwidXNlcl9yb2xlIjoiMSJ9fQ.3jwji_K1l07ttdUUjn4UJbJfuAbrC0msqk7jeftpSzDR7u2d8RCiGWz3ritX3hQIa0MGUe2fIaidErX-xtTQdA';

class Apis {
  static String allProducts = baseUrl + "getProducts";
  static String singleProduct = baseUrl + "getProduct";
  static String cartList=baseUrl+'getCartItems';

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
    } else
      (print("Network failure"));
  }

  Future<cart_list> getCartList() async {
    var client = new http.Client();
    bool connectionState = await checkStatus();
    if (connectionState) //TODO: Add a proper else return
        {
      var response = await client.post(cartList,headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $TOKEN',
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
  }
}
