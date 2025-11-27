import 'dart:convert';

OtpResp otpResponseFromJson(String str) => OtpResp.fromJson(json.decode(str));

String otpResponseToJson(OtpResp data) => json.encode(data.toJson());

class OtpResp {
  final bool status;
  final String message;
  final OtpData data;

  OtpResp({required this.status, required this.message, required this.data});

  Map<String, dynamic> toJson() {
    return {"status": status, "message": message, "data": data};
  }

  factory OtpResp.fromJson(Map<String, dynamic> json) {
    return OtpResp(
      status: json["status"].toLowerCase() == 'true',
      message: json["message"],
      data: OtpData.fromJson(json["data"]),
    );
  }
}

class OtpData {
  final String otp;
  final String email;

  OtpData({required this.otp, required this.email});

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(otp: json["otp"], email: json["email"]);
  }

  Map<String, dynamic> toJson() {
    return {"otp": otp, "email": email};
  }
}
