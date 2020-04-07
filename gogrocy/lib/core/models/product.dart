class Product {
    String id;
    String name;
    String price;
    String quantity;
    String unit;
    String description;
    String timesSold;
    String image;
    String category;

    Product(
        {this.id,
            this.name,
            this.price,
            this.quantity,
            this.unit,
            this.description,
            this.timesSold,
            this.image,
            this.category});

    Product.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        name = json['name'];
        price = json['price'];
        quantity = json['quantity'];
        unit = json['unit'];
        description = json['description'];
        timesSold = json['times_sold'];
        image = json['image'];
        category = json['category'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['name'] = this.name;
        data['price'] = this.price;
        data['quantity'] = this.quantity;
        data['unit'] = this.unit;
        data['description'] = this.description;
        data['times_sold'] = this.timesSold;
        data['image'] = this.image;
        data['category'] = this.category;
        return data;
    }
}
