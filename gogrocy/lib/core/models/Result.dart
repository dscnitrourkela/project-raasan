import 'package:gogrocy/core/models/Address.dart';
import 'package:gogrocy/core/models/Bill.dart';

class Result {
    List<Address> address;
    List<Bill> bills;

    Result({this.address, this.bills});

    factory Result.fromJson(Map<String, dynamic> json) {
        return Result(
            address: json['address'] != null ? (json['address'] as List).map((i) => Address.fromJson(i)).toList() : null,
            bills: json['bills'] != null ? (json['bills'] as List).map((i) => Bill.fromJson(i)).toList() : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.address != null) {
            data['address'] = this.address.map((v) => v.toJson()).toList();
        }
        if (this.bills != null) {
            data['bills'] = this.bills.map((v) => v.toJson()).toList();
        }
        return data;
    }
}