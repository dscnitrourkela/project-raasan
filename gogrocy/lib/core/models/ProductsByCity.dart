class ProductsByCity {
    bool empty;
    List<Result> result;

    ProductsByCity({this.empty, this.result});

    ProductsByCity.fromJson(Map<String, dynamic> json) {
        empty = json['empty'];
        if (json['result'] != null) {
            result = new List<Result>();
            json['result'].forEach((v) {
                result.add(new Result.fromJson(v));
            });
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['empty'] = this.empty;
        if (this.result != null) {
            data['result'] = this.result.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Result {
    String id;
    String name;
    String price;
    String quantity;
    String unit;
    String description;
    String image;
    String category;

    Result(
        {this.id,
            this.name,
            this.price,
            this.quantity,
            this.unit,
            this.description,
            this.image,
            this.category});

    Result.fromJson(Map<String, dynamic> json) {
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
