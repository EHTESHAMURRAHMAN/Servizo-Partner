import 'dart:convert';

VendorBookingsResp vendorBookingsRespFromJson(String str) =>
    VendorBookingsResp.fromJson(json.decode(str));

String vendorBookingsRespToJson(VendorBookingsResp data) =>
    json.encode(data.toJson());

class VendorBookingsResp {
  VendorBookingsResp({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<VendorBookingData> data;

  factory VendorBookingsResp.fromJson(Map<String, dynamic> json) =>
      VendorBookingsResp(
        status: json["status"] == "succeed",
        message: json["message"] ?? '',
        data: List<VendorBookingData>.from(
          json["data"].map((x) => VendorBookingData.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class VendorBookingData {
  final int bookingID;
  final String bookingDate;
  final int status;
  final String name;
  final String phoneno;
  final double price;
  final double rating;
  final String serviceDescription;
  final String seviceimage;
  final String categoryName;
  final String? subcategoryName;
  final String bookFor;
  final String? alternatePhone;
  final String street;
  final String city;
  final String zipCode;
  final DateTime lastDate;

  // ✅ Constructor
  VendorBookingData({
    required this.bookingID,
    required this.bookingDate,
    required this.status,
    required this.name,
    required this.phoneno,
    required this.price,
    required this.rating,
    required this.serviceDescription,
    required this.seviceimage,
    required this.categoryName,
    this.subcategoryName,
    required this.bookFor,
    required this.street,
    required this.city,
    required this.zipCode,
    required this.alternatePhone,
    required this.lastDate,
  });

  // ✅ Convert instance to Map (for JSON encoding)
  Map<String, dynamic> toJson() {
    return {
      'bookingID': bookingID,
      'bookingDate': bookingDate,
      'status': status,
      'name': name,
      'phoneno': phoneno,
      'price': price,
      'rating': rating,
      'serviceDescription': serviceDescription,
      'seviceimage': seviceimage,
      'categoryName': categoryName,
      'subcategoryName': subcategoryName,
      'bookFor': bookFor,
      'street': street,
      "city": city,
      "zipCode": zipCode,
      'alternatePhone': alternatePhone,
      'lastDate': lastDate.toIso8601String(),
    };
  }

  // ✅ Parse from Map (from JSON)
  factory VendorBookingData.fromJson(Map<String, dynamic> json) {
    return VendorBookingData(
      bookingID: json['bookingID'] as int,
      bookingDate: json['bookingDate'] as String,
      status: json['status'] as int,
      name: json['name'] as String,
      phoneno: json['phoneno'] as String,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      serviceDescription: json['serviceDescription'] as String,
      seviceimage: json['seviceimage'] as String,

      categoryName: json['categoryName'] as String,
      subcategoryName: json['subcategoryName'] as String?,
      bookFor: json['bookFor'] as String,

      alternatePhone: json['alternatePhone'] as String?,
      lastDate: DateTime.parse(json['lastDate'] as String),
      street: json['street'],
      city: json['city'],
      zipCode: json['zipCode'],
    );
  }
}
