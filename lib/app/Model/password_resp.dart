import 'dart:convert';

PasswordResp passwordResponseFromJson(String str) =>
    PasswordResp.fromJson(json.decode(str));

String otpResponseToJson(PasswordResp data) => json.encode(data.toJson());

class PasswordResp {
  final bool status;
  final String message;
  final PasswordData data;

  PasswordResp({
    required this.status,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {"status": status, "message": message, "data": data};
  }

  factory PasswordResp.fromJson(Map<String, dynamic> json) {
    return PasswordResp(
      status: json["status"].toLowerCase() == 'true',
      message: json["message"],
      data: PasswordData.fromJson(json["data"]),
    );
  }
}

class PasswordData {
  final String email;
  final String password;

  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }

  factory PasswordData.fromJson(Map<String, dynamic> json) {
    return PasswordData(email: json["email"], password: json["password"]);
  }

  PasswordData({required this.email, required this.password});
}
