class CartEdit {
    String message;
    bool success;

    CartEdit({this.message, this.success});

    factory CartEdit.fromJson(Map<String, dynamic> json) {
        return CartEdit(
            message: json['message'], 
            success: json['success'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['success'] = this.success;
        return data;
    }
}