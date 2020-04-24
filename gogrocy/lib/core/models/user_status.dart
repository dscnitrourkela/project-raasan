import 'dart:convert';

UserStatus userStatusFromJson(String str) =>
    UserStatus.fromJson(json.decode(str));

String userStatusToJson(UserStatus data) => json.encode(data.toJson());

class UserStatus {
  String status;

  UserStatus({
    this.status,
  });

  factory UserStatus.fromJson(Map<String, dynamic> json) => UserStatus(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
