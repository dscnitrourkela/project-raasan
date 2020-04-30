class Address {
  String recipient;
  String addressId;
  String city;
  String contact;
  String country;
  String isPrimary;
  String locality;
  String state;
  String userId;
  String zip;

  Address(
      {this.recipient,
      this.addressId,
      this.city,
      this.contact,
      this.country,
      this.isPrimary,
      this.locality,
      this.state,
      this.userId,
      this.zip});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      recipient: json['recipent'],
      addressId: json['address_id'],
      city: json['city'],
      contact: json['contact'],
      country: json['country'],
      isPrimary: json['is_primary'],
      locality: json['locality'],
      state: json['state'],
      userId: json['user_id'],
      zip: json['zip'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipent'] = this.recipient;
    data['address_id'] = this.addressId;
    data['city'] = this.city;
    data['contact'] = this.contact;
    data['country'] = this.country;
    data['is_primary'] = this.isPrimary;
    data['locality'] = this.locality;
    data['state'] = this.state;
    data['user_id'] = this.userId;
    data['zip'] = this.zip;
    return data;
  }
}
