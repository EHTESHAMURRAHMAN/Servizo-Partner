import 'dart:convert';

CategoryResp categoryRespFromJson(String str) =>
    CategoryResp.fromJson(json.decode(str));

String categoryRespToJson(CategoryResp data) => json.encode(data.toJson());

class CategoryResp {
  CategoryResp({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<CategoryData> data;

  factory CategoryResp.fromJson(Map<String, dynamic> json) => CategoryResp(
    status: json["status"] == "succeed",
    message: json["message"] ?? '',
    data: List<CategoryData>.from(
      json["data"].map((x) => CategoryData.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CategoryData {
  CategoryData({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.subcategoryCount,
    required this.vendorCount,
  });

  final int categoryId;
  final String categoryName;
  final String categoryImage;
  final int subcategoryCount;
  final int vendorCount;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    categoryId: json["category_id"] ?? 0,
    categoryName: json["category_name"] ?? '',
    categoryImage: json["category_image"] ?? '',
    subcategoryCount: json["subcategory_count"] ?? 0,
    vendorCount: json["vendor_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_name": categoryName,
    "category_image": categoryImage,
    "subcategory_count": subcategoryCount,
    "vendor_count": vendorCount,
  };
}
