class Orders {
  bool empty;
  Result result;

  Orders({this.empty, this.result});

  Orders.fromJson(Map<String, dynamic> json) {
    empty = json['empty'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empty'] = this.empty;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  List<Bills> bills;

  Result({this.bills});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['bills'] != null) {
      bills = new List<Bills>();
      json['bills'].forEach((v) {
        bills.add(new Bills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bills != null) {
      data['bills'] = this.bills.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bills {
  String billId;
  List<Details> details;

  Bills({this.billId, this.details});

  Bills.fromJson(Map<String, dynamic> json) {
    billId = json['bill_id'];
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bill_id'] = this.billId;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String productId;
  String orderId;
  String billId;
  String image;
  String name;
  String price;
  String orderQty;
  String paymentStat;
  String status;
  String sellerNumber;
  String sellerName;
  String orderDate;

  Details(
      {this.productId,
      this.orderId,
      this.billId,
      this.image,
      this.name,
      this.price,
      this.orderQty,
      this.paymentStat,
      this.status,
      this.sellerNumber,
      this.sellerName,
      this.orderDate});

  Details.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    orderId = json['order_id'];
    billId = json['bill_id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    orderQty = json['order_qty'];
    paymentStat = json['payment_stat'];
    status = json['status'];
    sellerNumber = json['seller_number'];
    sellerName = json['seller_name'];
    orderDate = json['order_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['order_id'] = this.orderId;
    data['bill_id'] = this.billId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['price'] = this.price;
    data['order_qty'] = this.orderQty;
    data['payment_stat'] = this.paymentStat;
    data['status'] = this.status;
    data['seller_number'] = this.sellerNumber;
    data['seller_name'] = this.sellerName;
    data['order_date'] = this.orderDate;
    return data;
  }
}
