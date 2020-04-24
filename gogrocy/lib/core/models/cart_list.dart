class cart_list {
    List<Cart> cart;
    int sum;

    cart_list({this.cart, this.sum});

    factory cart_list.fromJson(Map<String, dynamic> json) {
        return cart_list(
            cart: json['cart'] != null ? (json['cart'] as List).map((i) => Cart.fromJson(i)).toList() : null, 
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
    String cart_id;
    String category;
    String date;
    String description;
    String id;
    String image;
    String name;
    String price;
    String product_id;
    String quantity;
    String quantity_ordered;
    String unit;
    String user_id;

    Cart({this.cart_id, this.category, this.date, this.description, this.id, this.image, this.name, this.price, this.product_id, this.quantity, this.quantity_ordered, this.unit, this.user_id});

    factory Cart.fromJson(Map<String, dynamic> json) {
        return Cart(
            cart_id: json['cart_id'],
            category: json['category'],
            date: json['date'],
            description: json['description'],
            id: json['id'],
            image: json['image'],
            name: json['name'],
            price: json['price'],
            product_id: json['product_id'],
            quantity: json['quantity'],
            quantity_ordered: json['quantity_ordered'],
            unit: json['unit'],
            user_id: json['user_id'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['cart_id'] = this.cart_id;
        data['category'] = this.category;
        data['date'] = this.date;
        data['description'] = this.description;
        data['id'] = this.id;
        data['image'] = this.image;
        data['name'] = this.name;
        data['price'] = this.price;
        data['product_id'] = this.product_id;
        data['quantity'] = this.quantity;
        data['quantity_ordered'] = this.quantity_ordered;
        data['unit'] = this.unit;
        data['user_id'] = this.user_id;
        return data;
    }
}