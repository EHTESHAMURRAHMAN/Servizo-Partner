import 'dart:convert';

KhataProfileResp khataProfileRespFromJson(String str) =>
    KhataProfileResp.fromJson(json.decode(str));

String khataProfileRespToJson(KhataProfileResp data) =>
    json.encode(data.toJson());

class KhataProfileResp {
  KhataProfileResp({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final KhataProfileData data;

  factory KhataProfileResp.fromJson(Map<String, dynamic> json) =>
      KhataProfileResp(
        status: json["status"] == "succeed",
        message: json["message"] ?? '',
        data: KhataProfileData.fromJson(json["data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
    "status": status ? "succeed" : "failed",
    "message": message,
    "data": data.toJson(),
  };
}

class KhataProfileData {
  KhataProfileData({
    required this.userID,
    required this.fullName,
    required this.firmName,
    required this.email,
    required this.phoneNumber,
    required this.passwordHash,
    required this.address,
    required this.gstNumber,
  });

  final int userID;
  final String fullName;
  final String firmName;
  final String email;
  final String phoneNumber;
  final String passwordHash;
  final String address;
  final String gstNumber;

  factory KhataProfileData.fromJson(Map<String, dynamic> json) =>
      KhataProfileData(
        userID: json["userID"] ?? 0,
        fullName: json["fullName"] ?? '',
        firmName: json["firmName"] ?? '',
        email: json["email"] ?? '',
        phoneNumber: json["phoneNumber"] ?? '',
        passwordHash: json["passwordHash"] ?? '',
        address: json["address"] ?? '',
        gstNumber: json["gstNumber"] ?? '',
      );

  Map<String, dynamic> toJson() => {
    "userID": userID,
    "fullName": fullName,
    "firmName": firmName,
    "email": email,
    "phoneNumber": phoneNumber,
    "passwordHash": passwordHash,
    "address": address,
    "gstNumber": gstNumber,
  };
}
