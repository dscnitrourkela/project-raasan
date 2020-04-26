class Address {
    String recipent;
    String address_id;
    String city;
    String contact;
    String country;
    String is_primary;
    String locality;
    String state;
    String user_id;
    String zip;

    Address({this.recipent, this.address_id, this.city, this.contact, this.country, this.is_primary, this.locality, this.state, this.user_id, this.zip});

    factory Address.fromJson(Map<String, dynamic> json) {
        return Address(
            recipent: json['recipent'],
            address_id: json['address_id'], 
            city: json['city'], 
            contact: json['contact'], 
            country: json['country'], 
            is_primary: json['is_primary'], 
            locality: json['locality'], 
            state: json['state'], 
            user_id: json['user_id'], 
            zip: json['zip'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['recipent'] = this.recipent;
        data['address_id'] = this.address_id;
        data['city'] = this.city;
        data['contact'] = this.contact;
        data['country'] = this.country;
        data['is_primary'] = this.is_primary;
        data['locality'] = this.locality;
        data['state'] = this.state;
        data['user_id'] = this.user_id;
        data['zip'] = this.zip;
        return data;
    }
}