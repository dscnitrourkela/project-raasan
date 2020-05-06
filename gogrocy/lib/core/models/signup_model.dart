import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  bool success;
  String msg;
  Error error;

  SignUpModel({
    this.success,
    this.msg,
    this.error,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        success: json["success"] == null ? null : json["success"],
        msg: json["msg"] == null ? null : json["msg"],
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "msg": msg == null ? null : msg,
        "error": error == null ? null : error.toJson(),
      };
}

class Error {
  String mobile;
  String password;
  String cPassword;

  Error({
    this.mobile,
    this.password,
    this.cPassword,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        mobile: json["mobile"] == null ? null : json["mobile"],
        password: json["password"] == null ? null : json["password"],
        cPassword: json["cpassword"] == null ? null : json["cpassword"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile == null ? null : mobile,
        "password": password == null ? null : password,
        "cpassword": cPassword == null ? null : cPassword,
      };
}
