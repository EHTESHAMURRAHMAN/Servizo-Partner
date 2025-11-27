import 'dart:convert';

ProfileResp profileRespFromJson(String str) =>
    ProfileResp.fromJson(json.decode(str));

String profileRespToJson(ProfileResp data) => json.encode(data.toJson());

class ProfileResp {
  ProfileResp({
    required this.status,
    required this.message,
    this.data,
  });

  final bool status;
  final String message;
  final ProfileData? data;

  factory ProfileResp.fromJson(Map<String, dynamic> json) => ProfileResp(
        status: json["status"] == "succeed",
        message: json["message"] ?? '',
        data: json["data"] != null ? ProfileData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class ProfileData {
  ProfileData({
    required this.userID,
    required this.name,
    required this.phone,
    required this.email,
    required this.passHash,
    required this.role,
    required this.address,
  });

  final int userID;
  final String name;
  final String phone;
  final String email;
  final String passHash;
  final String role;
  final String address;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        userID: json["userID"] ?? 0, // Added missing "userID" field
        name: json["name"] ?? '',
        phone: json["phone"] ?? '',
        email: json["email"] ?? '',
        passHash: json["pass_hash"] ?? '',
        role: json["role"] ?? '',
        address: json["address"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "name": name,
        "phone": phone,
        "email": email,
        "pass_hash": passHash,
        "role": role,
        "address": address,
      };
}
