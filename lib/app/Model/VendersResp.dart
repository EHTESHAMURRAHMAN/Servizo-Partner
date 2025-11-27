import 'dart:convert';

VendersResp vendersRespFromJson(String str) =>
    VendersResp.fromJson(json.decode(str));

String vendersRespToJson(VendersResp data) => json.encode(data.toJson());

class VendersResp {
  VendersResp({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<VendorData> data;

  factory VendersResp.fromJson(Map<String, dynamic> json) => VendersResp(
    status: json["status"] == "succeed",
    message: json["message"] ?? '',
    data: List<VendorData>.from(
      json["data"].map((x) => VendorData.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class VendorData {
  VendorData({
    required this.vendorId,
    required this.ServiceID,
    required this.subcategoryId,
    required this.vendorName,
    required this.seviceimage,
    required this.vendorDescription,
    required this.categoryname,
    required this.vendorPhone,
    required this.vendorPrice,
    required this.vendorRating,
    required this.categoryid,
    required this.vendorstatus,
  });

  final int vendorId;
  final int ServiceID;
  final int subcategoryId;
  final String vendorName;
  final String seviceimage;
  final String vendorDescription;
  final String categoryname;
  final String vendorPhone;
  final double vendorPrice;
  final int vendorRating;
  final int categoryid;
  final String vendorstatus;

  factory VendorData.fromJson(Map<String, dynamic> json) => VendorData(
    vendorId: json["vendor_id"] ?? 0,
    ServiceID: json["serviceID"] ?? 0,
    subcategoryId: json["subcategory_id"] ?? 0,
    vendorName: json["vendor_name"] ?? '',
    seviceimage: json["seviceimage"] ?? '',
    vendorDescription: json["vendor_description"] ?? '',
    categoryname: json["categoryname"] ?? '',
    vendorPhone: json["vendor_phone"] ?? '',
    vendorPrice: json["vendor_price"] ?? 0.0,
    vendorRating: json["vendor_rating"] ?? 0,
    categoryid: json["category_id"] ?? 0,
    vendorstatus: json["vendor_status"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "vendor_id": vendorId,
    "serviceID": ServiceID,
    "subcategory_id": subcategoryId,
    "vendor_name": vendorName,
    "seviceimage": seviceimage,
    "vendor_description": vendorDescription,
    "categoryname": categoryname,
    "vendor_phone": vendorPhone,
    "vendor_price": vendorPrice,
    "vendor_rating": vendorRating,
    "category_id": categoryid,
    "vendor_status": vendorstatus,
  };
}
