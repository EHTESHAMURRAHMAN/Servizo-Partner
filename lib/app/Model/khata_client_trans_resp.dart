import 'dart:convert';

KhataTransactionResp khataTransactionRespFromJson(String str) =>
    KhataTransactionResp.fromJson(json.decode(str));

String khataTransactionRespToJson(KhataTransactionResp data) =>
    json.encode(data.toJson());

class KhataTransactionResp {
  KhataTransactionResp({
    required this.status,
    required this.message,
    required this.totalReceived,
    required this.totalSent,
    required this.balance,
    required this.data,
  });

  final bool status;
  final String message;
  final dynamic totalReceived;
  final dynamic totalSent;
  final dynamic balance;
  final List<KhataTransactionData> data;

  factory KhataTransactionResp.fromJson(Map<String, dynamic> json) =>
      KhataTransactionResp(
        status: json["status"] == "succeed",
        message: json["message"] ?? '',
        totalReceived: json["totalReceived"] ?? 0.0,
        totalSent: json["totalSent"] ?? 0,
        balance: json["balance"] ?? 0,
        data:
            json["data"] == null
                ? []
                : List<KhataTransactionData>.from(
                  json["data"].map((x) => KhataTransactionData.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "totalReceived": totalReceived,
    "totalSent": totalSent,
    "balance": balance,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class KhataTransactionData {
  KhataTransactionData({
    required this.transactionId,
    required this.clientId,
    required this.userId,
    required this.transactionType,
    required this.amount,
    required this.description,
    required this.transactionDate,
    required this.balance,
  });

  final int transactionId;
  final int clientId;
  final int userId;
  final String transactionType;
  final dynamic amount;
  final String description;
  final String transactionDate;
  final int balance;

  factory KhataTransactionData.fromJson(Map<String, dynamic> json) =>
      KhataTransactionData(
        transactionId: json["transactionId"] ?? 0,
        clientId: json["clientId"] ?? 0,
        userId: json["userId"] ?? 0,
        transactionType: json["transactionType"] ?? '',
        amount: json["amount"] ?? 0,
        description: json["description"] ?? '',
        transactionDate: json["transactionDate"] ?? '',
        balance: json["balance"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "transactionId": transactionId,
    "clientId": clientId,
    "userId": userId,
    "transactionType": transactionType,
    "amount": amount,
    "description": description,
    "transactionDate": transactionDate,
    "balance": balance,
  };
}
