import 'dart:convert';
import 'dart:io';
import 'package:gogrocy/core/models/product.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "https://gogrocy.in/api/";

class Apis {
  static String allProducts = baseUrl + "getProducts";
  static String singleProduct = baseUrl + "getProduct";

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
