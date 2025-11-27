import 'dart:convert';

KhataClientResp khataClientRespFromJson(String str) =>
    KhataClientResp.fromJson(json.decode(str));

String khataClientRespToJson(KhataClientResp data) =>
    json.encode(data.toJson());

class KhataClientResp {
  KhataClientResp({
    required this.status,
    required this.message,
    required this.overallBalance,
    required this.data,
  });

  final bool status;
  final String message;
  final dynamic overallBalance;
  final List<KhataClientData> data;

  factory KhataClientResp.fromJson(Map<String, dynamic> json) =>
      KhataClientResp(
        status: json["status"] == "succeed",
        message: json["message"] ?? '',
        overallBalance: json["overallBalance"] ?? '',
        data:
            json["data"] == null
                ? []
                : List<KhataClientData>.from(
                  json["data"].map((x) => KhataClientData.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "overallBalance": overallBalance,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class KhataClientData {
  KhataClientData({
    required this.id,
    required this.userId,
    required this.firmName,
    required this.proprieterName,
    required this.mobileNo,
    required this.clientAddress,
    required this.pincode,
    required this.gstin,
    required this.totalBalance,
  });

  final int id;
  final int userId;
  final String firmName;
  final String proprieterName;
  final String mobileNo;
  final String clientAddress;
  final String pincode;
  final String gstin;
  final dynamic totalBalance;

  factory KhataClientData.fromJson(Map<String, dynamic> json) =>
      KhataClientData(
        id: json["id"] ?? 0,
        userId: json["userId"] ?? 0,
        firmName: json["firmName"] ?? '',
        proprieterName: json["proprieterName"] ?? '',
        mobileNo: json["mobileNo"] ?? '',
        clientAddress: json["clientAddress"] ?? '',
        pincode: json["pincode"] ?? '',
        gstin: json["gstin"] ?? '',
        totalBalance: json["totalBalance"] ?? '',
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "firmName": firmName,
    "proprieterName": proprieterName,
    "mobileNo": mobileNo,
    "clientAddress": clientAddress,
    "pincode": pincode,
    "gstin": gstin,
    "totalBalance": totalBalance,
  };
}
