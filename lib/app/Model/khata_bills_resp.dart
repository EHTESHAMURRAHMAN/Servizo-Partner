import 'dart:convert';

KhataBillResp khataBillRespFromJson(String str) =>
    KhataBillResp.fromJson(json.decode(str));

String khataBillRespToJson(KhataBillResp data) => json.encode(data.toJson());

class KhataBillResp {
  KhataBillResp({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<KhataBillData> data;

  factory KhataBillResp.fromJson(Map<String, dynamic> json) => KhataBillResp(
    status: json["status"] == "succeed",
    message: json["message"] ?? '',
    data:
        json["data"] == null
            ? []
            : List<KhataBillData>.from(
              json["data"].map((x) => KhataBillData.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "status": status ? "succeed" : "failed",
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class KhataBillData {
  KhataBillData({
    required this.billId,
    required this.userid,
    required this.clientId,
    required this.customerName,
    required this.note,
    required this.total,
    required this.isPaid,
    required this.gstid,
    required this.address,
    required this.heading,
    required this.createdAt,
    required this.items,
  });

  final int billId;
  final int userid;
  final int clientId;
  final String customerName;
  final String note;
  final dynamic total;
  final bool isPaid;
  final String gstid;
  final String address;
  final String heading;
  final String createdAt;
  final List<BillItem> items;

  factory KhataBillData.fromJson(Map<String, dynamic> json) => KhataBillData(
    billId: json["billId"] ?? 0,
    userid: json["userid"] ?? 0,
    clientId: json["clientId"] ?? 0,
    customerName: json["customerName"] ?? '',
    note: json["note"] ?? '',
    total: json["total"] ?? 0,
    isPaid: json["isPaid"] ?? false,
    gstid: json["gstid"] ?? '',
    address: json["address"] ?? '',
    heading: json["heading"] ?? '',
    createdAt: json["createdAt"] ?? '',
    items:
        json["items"] == null
            ? []
            : List<BillItem>.from(
              json["items"].map((x) => BillItem.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "billId": billId,
    "userid": userid,
    "clientId": clientId,
    "customerName": customerName,
    "note": note,
    "total": total,
    "isPaid": isPaid,
    "gstid": gstid,
    "address": address,
    "heading": heading,
    "createdAt": createdAt,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class BillItem {
  BillItem({
    required this.itemId,
    required this.billId,
    required this.itemName,
    required this.quantity,
    required this.productType,
    required this.mrp,
    required this.price,
    required this.gstPercent,
    required this.priceWithTax,
    required this.cessPercent,
    required this.hsn,
    required this.total,
  });

  final int itemId;
  final int billId;
  final String itemName;
  final int quantity;
  final String productType;
  final dynamic mrp;
  final dynamic price;
  final dynamic gstPercent;
  final dynamic priceWithTax;
  final dynamic cessPercent;
  final String hsn;
  final dynamic total;

  factory BillItem.fromJson(Map<String, dynamic> json) => BillItem(
    itemId: json["itemId"] ?? 0,
    billId: json["billId"] ?? 0,
    itemName: json["itemName"] ?? '',
    quantity: json["quantity"] ?? 0,
    productType: json["productType"] ?? '',
    mrp: json["mrp"] ?? 0,
    price: json["price"] ?? 0,
    gstPercent: json["gstPercent"] ?? 0,
    priceWithTax: json["priceWithTax"] ?? 0,
    cessPercent: json["cessPercent"] ?? 0,
    hsn: json["hsn"] ?? '',
    total: json["total"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "billId": billId,
    "itemName": itemName,
    "quantity": quantity,
    "productType": productType,
    "mrp": mrp,
    "price": price,
    "gstPercent": gstPercent,
    "priceWithTax": priceWithTax,
    "cessPercent": cessPercent,
    "hsn": hsn,
    "total": total,
  };
}
