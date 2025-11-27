import 'dart:convert';

VendorListResp vendorListRespFromJson(String str) =>
    VendorListResp.fromJson(json.decode(str));

String vendorListRespToJson(VendorListResp data) => json.encode(data.toJson());

class VendorListResp {
  VendorListResp({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<VendorList> data;

  factory VendorListResp.fromJson(Map<String, dynamic> json) => VendorListResp(
    status: json["status"] == "succeed",
    message: json["message"] ?? '',
    data: List<VendorList>.from(
      json["data"].map((x) => VendorList.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class VendorList {
  VendorList({
    required this.vendorId,
    required this.subcategoryId,
    required this.vendorName,
    required this.seviceimage,
    required this.categoryname,
    required this.vendorDescription,
    required this.vendorPhone,
    required this.vendorPrice,
    required this.vendorRating,
    required this.categoryId,
    required this.vendorStatus,
  });

  final int vendorId;
  final int subcategoryId;
  final String vendorName;
  final String seviceimage;
  final String categoryname;
  final String vendorDescription;
  final String vendorPhone;
  final double vendorPrice;
  final int vendorRating;
  final int categoryId;
  final String vendorStatus;

  factory VendorList.fromJson(Map<String, dynamic> json) => VendorList(
    vendorId: json["vendor_id"] ?? 0,
    subcategoryId: json["subcategory_id"] ?? 0,
    vendorName: json["vendor_name"] ?? '',
    seviceimage: json["seviceimage"] ?? '',
    categoryname: json["categoryname"] ?? '',
    vendorDescription: json["vendor_description"] ?? '',
    vendorPhone: json["vendor_phone"] ?? '',
    vendorPrice: json["vendor_price"] ?? 0.0,
    vendorRating: json["vendor_rating"] ?? 0,
    categoryId: json["category_id"] ?? 0,
    vendorStatus: json["vendor_status"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "vendor_id": vendorId,
    "subcategory_id": subcategoryId,
    "vendor_name": vendorName,
    "seviceimage": seviceimage,
    "categoryname": categoryname,
    "vendor_description": vendorDescription,
    "vendor_phone": vendorPhone,
    "vendor_price": vendorPrice,
    "vendor_rating": vendorRating,
    "category_id": categoryId,
    "vendor_status": vendorStatus,
  };
}
