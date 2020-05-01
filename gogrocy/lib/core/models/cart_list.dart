class CartDataModel {
  List<Cart> cart;
  int sum;

  CartDataModel({this.cart, this.sum});

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    return CartDataModel(
      cart: json['cart'] != null
          ? (json['cart'] as List).map((i) => Cart.fromJson(i)).toList()
          : null,
      sum: json['sum'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sum'] = this.sum;
    if (this.cart != null) {
      data['cart'] = this.cart.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  String cartId;
  String category;
  String date;
  String description;
  String id;
  String image;
  String name;
  String price;
  String productId;
  String quantity;
  String quantityOrdered;
  String unit;
  String userId;

  Cart(
      {this.cartId,
      this.category,
      this.date,
      this.description,
      this.id,
      this.image,
      this.name,
      this.price,
      this.productId,
      this.quantity,
      this.quantityOrdered,
      this.unit,
      this.userId});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      cartId: json['cart_id'],
      category: json['category'],
      date: json['date'],
      description: json['description'],
      id: json['id'],
      image: json['image'],
      name: json['name'],
      price: json['price'],
      productId: json['product_id'],
      quantity: json['quantity'],
      quantityOrdered: json['quantity_ordered'],
      unit: json['unit'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['category'] = this.category;
    data['date'] = this.date;
    data['description'] = this.description;
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['price'] = this.price;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['quantity_ordered'] = this.quantityOrdered;
    data['unit'] = this.unit;
    data['user_id'] = this.userId;
    return data;
  }
}
