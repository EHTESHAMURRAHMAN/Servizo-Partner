import 'dart:convert';

SubcategoryResp subcategoryRespFromJson(String str) =>
    SubcategoryResp.fromJson(json.decode(str));

String subcategoryRespToJson(SubcategoryResp data) =>
    json.encode(data.toJson());

class SubcategoryResp {
  SubcategoryResp({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<SubcategoryData> data;

  factory SubcategoryResp.fromJson(Map<String, dynamic> json) =>
      SubcategoryResp(
        status: json["status"] == "succeed",
        message: json["message"] ?? '',
        data: List<SubcategoryData>.from(
          json["data"].map((x) => SubcategoryData.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SubcategoryData {
  SubcategoryData({
    required this.subcategoryId,
    required this.categoryId,
    required this.subcategoryName,
    required this.subcategoryImage,
    required this.vendorCount,
  });

  final int subcategoryId;
  final int categoryId;
  final String subcategoryName;
  final String subcategoryImage;
  final int vendorCount;

  factory SubcategoryData.fromJson(Map<String, dynamic> json) =>
      SubcategoryData(
        subcategoryId: json["subcategory_id"] ?? 0,
        categoryId: json["category_id"] ?? 0,
        subcategoryName: json["subcategory_name"] ?? '',
        subcategoryImage: json["seviceimage"] ?? '',
        vendorCount: json["vendor_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "subcategory_id": subcategoryId,
    "category_id": categoryId,
    "subcategory_name": subcategoryName,
    "seviceimage": subcategoryImage,
    "vendor_count": vendorCount,
  };
}
