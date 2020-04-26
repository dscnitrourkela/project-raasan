class Detail {
    String bill_id;
    String image;
    String name;
    String order_date;
    String order_id;
    String order_qty;
    String payment_stat;
    String price;
    String product_id;
    String seller_name;
    String seller_number;
    String status;

    Detail({this.bill_id, this.image, this.name, this.order_date, this.order_id, this.order_qty, this.payment_stat, this.price, this.product_id, this.seller_name, this.seller_number, this.status});

    factory Detail.fromJson(Map<String, dynamic> json) {
        return Detail(
            bill_id: json['bill_id'], 
            image: json['image'], 
            name: json['name'], 
            order_date: json['order_date'], 
            order_id: json['order_id'], 
            order_qty: json['order_qty'], 
            payment_stat: json['payment_stat'], 
            price: json['price'], 
            product_id: json['product_id'], 
            seller_name: json['seller_name'], 
            seller_number: json['seller_number'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bill_id'] = this.bill_id;
        data['image'] = this.image;
        data['name'] = this.name;
        data['order_date'] = this.order_date;
        data['order_id'] = this.order_id;
        data['order_qty'] = this.order_qty;
        data['payment_stat'] = this.payment_stat;
        data['price'] = this.price;
        data['product_id'] = this.product_id;
        data['seller_name'] = this.seller_name;
        data['seller_number'] = this.seller_number;
        data['status'] = this.status;
        return data;
    }
}