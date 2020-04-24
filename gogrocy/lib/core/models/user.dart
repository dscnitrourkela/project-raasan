import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  bool success;
  Userdata userdata;
  String jwt;
  String message;

  User({
    this.success,
    this.userdata,
    this.jwt,
    this.message,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      success: json["success"],
      userdata:
          json["userdata"] == null ? null : Userdata.fromJson(json["userdata"]),
      jwt: json["jwt"] == null ? null : json["jwt"],
      message: json["message"] == null ? null : json["message"]);

  Map<String, dynamic> toJson() => {
        "success": success,
        "userdata": userdata.toJson(),
        "jwt": jwt,
        "message": message != null ? message : null,
      };
}

class Userdata {
  String userId;
  String username;
  String name;
  String countryCode;
  String mobile;
  String email;
  String contact;
  String userRole;
  String validated;
  String password;
  DateTime registered;
  String displayPicture;

  Userdata({
    this.userId,
    this.username,
    this.name,
    this.countryCode,
    this.mobile,
    this.email,
    this.contact,
    this.userRole,
    this.validated,
    this.password,
    this.registered,
    this.displayPicture,
  });

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
        userId: json["user_id"],
        username: json["username"],
        name: json["name"],
        countryCode: json["country_code"],
        mobile: json["mobile"],
        email: json["email"],
        contact: json["contact"],
        userRole: json["user_role"],
        validated: json["validated"],
        password: json["password"],
        registered: DateTime.parse(json["registered"]),
        displayPicture: json["display_picture"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "name": name,
        "country_code": countryCode,
        "mobile": mobile,
        "email": email,
        "contact": contact,
        "user_role": userRole,
        "validated": validated,
        "password": password,
        "registered": registered.toIso8601String(),
        "display_picture": displayPicture,
      };
}
