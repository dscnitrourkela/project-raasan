import 'package:gogrocy/core/models/cart_list.dart';

class CartEditModel {
  bool success;
  String message;
  CartDataModel result;

  CartEditModel({this.success, this.message, this.result});

  CartEditModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    result =
    json['result'] != null ? new CartDataModel.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

/*class Result {
  int sum;
  List<Cart> cart;

  Result({this.sum, this.cart});

  Result.fromJson(Map<String, dynamic> json) {
    sum = json['sum'];
    if (json['cart'] != null) {
      cart = new List<Cart>();
      json['cart'].forEach((v) {
        cart.add(new Cart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sum'] = this.sum;
    if (this.cart != null) {
      data['cart'] = this.cart.map((v) => v.toJson()).toList();
    }
    return data;
  }
}*/
/*

class Cart {
  String cartId;
  String userId;
  String productId;
  String quantityOrdered;
  String date;
  String id;
  String name;
  String price;
  String quantity;
  String unit;
  String description;
  String image;
  String category;

  Cart(
      {this.cartId,
        this.userId,
        this.productId,
        this.quantityOrdered,
        this.date,
        this.id,
        this.name,
        this.price,
        this.quantity,
        this.unit,
        this.description,
        this.image,
        this.category});

  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    userId = json['user_id'];
    productId = json['product_id'];
    quantityOrdered = json['quantity_ordered'];
    date = json['date'];
    id = json['id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    unit = json['unit'];
    description = json['description'];
    image = json['image'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['quantity_ordered'] = this.quantityOrdered;
    data['date'] = this.date;
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['description'] = this.description;
    data['image'] = this.image;
    data['category'] = this.category;
    return data;
  }
}
*/
