import 'package:gogrocy/core/models/Detail.dart';

class Bill {
    String bill_id;
    List<Detail> details;

    Bill({this.bill_id, this.details});

    factory Bill.fromJson(Map<String, dynamic> json) {
        return Bill(
            bill_id: json['bill_id'], 
            details: json['details'] != null ? (json['details'] as List).map((i) => Detail.fromJson(i)).toList() : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bill_id'] = this.bill_id;
        if (this.details != null) {
            data['details'] = this.details.map((v) => v.toJson()).toList();
        }
        return data;
    }
}