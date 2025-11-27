import 'dart:convert';

PickedScrapResp pickedScrapRespFromJson(String str) =>
    PickedScrapResp.fromJson(json.decode(str));

String pickedScrapRespToJson(PickedScrapResp data) =>
    json.encode(data.toJson());

class PickedScrapResp {
  PickedScrapResp({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<PickedScrapData> data;

  factory PickedScrapResp.fromJson(Map<String, dynamic> json) =>
      PickedScrapResp(
        status: json["status"] == "succeed",
        message: json["message"] ?? '',
        data:
            json["data"] == null
                ? []
                : List<PickedScrapData>.from(
                  json["data"].map((x) => PickedScrapData.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "status": status ? "succeed" : "failed",
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PickedScrapData {
  PickedScrapData({
    required this.requestId,
    required this.userId,
    required this.fullName,
    required this.phoneNumber,
    required this.pickupAddress,
    required this.pickupDate,
    required this.status,
    required this.createdAt,
    required this.isPaid,
    required this.items,
  });

  final int requestId;
  final int userId;
  final String fullName;
  final String phoneNumber;
  final String pickupAddress;
  final String pickupDate;
  final String status;
  final String createdAt;
  final bool isPaid;
  final List<ScrapItem> items;

  factory PickedScrapData.fromJson(Map<String, dynamic> json) =>
      PickedScrapData(
        requestId: json["requestId"] ?? 0,
        userId: json["userId"] ?? 0,
        fullName: json["fullName"] ?? '',
        phoneNumber: json["phoneNumber"] ?? '',
        pickupAddress: json["pickupAddress"] ?? '',
        pickupDate: json["pickupDate"] ?? '',
        status: json["status"] ?? '',
        createdAt: json["created_At"] ?? '',
        isPaid: json["isPaid"] ?? false,
        items:
            json["items"] == null
                ? []
                : List<ScrapItem>.from(
                  json["items"].map((x) => ScrapItem.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "userId": userId,
    "fullName": fullName,
    "phoneNumber": phoneNumber,
    "pickupAddress": pickupAddress,
    "pickupDate": pickupDate,
    "status": status,
    "created_At": createdAt,
    "isPaid": isPaid,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class ScrapItem {
  ScrapItem({
    required this.itemId,
    required this.scrapType,
    required this.scrapImg,
  });

  final int itemId;
  final String scrapType;
  final String scrapImg;

  factory ScrapItem.fromJson(Map<String, dynamic> json) => ScrapItem(
    itemId: json["itemId"] ?? 0,
    scrapType: json["scrapType"] ?? '',
    scrapImg: json["scrapImg"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "scrapType": scrapType,
    "scrapImg": scrapImg,
  };
}
