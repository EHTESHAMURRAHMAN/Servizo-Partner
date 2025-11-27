import 'dart:convert';

AuthResp authRespFromJson(String str) => AuthResp.fromJson(json.decode(str));

String authRespToJson(AuthResp data) => json.encode(data.toJson());

class AuthResp {
  AuthResp({required this.status, required this.message, required this.data});

  final bool status;
  final String message;
  final AuthData data;

  factory AuthResp.fromJson(Map<String, dynamic> json) => AuthResp(
    status: json["status"] == "succeed",
    message: json["message"] ?? '',
    data: AuthData.fromJson(json["data"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class AuthData {
  AuthData({required this.userID});

  final int userID;

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      AuthData(userID: json["userID"] ?? 0);

  Map<String, dynamic> toJson() => {"user_id": userID};
}
