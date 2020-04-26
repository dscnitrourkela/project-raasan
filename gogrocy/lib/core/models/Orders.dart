import 'package:gogrocy/core/models/Result.dart';

class Orders {
    bool empty;
    Result result;

    Orders({this.empty, this.result});

    factory Orders.fromJson(Map<String, dynamic> json) {
        return Orders(
            empty: json['empty'], 
            result: json['result'] != null ? Result.fromJson(json['result']) : null, 
        );
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