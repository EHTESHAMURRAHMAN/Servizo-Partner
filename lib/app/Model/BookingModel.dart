import 'dart:convert';

UserBookingsResp userBookingsRespFromJson(String str) =>
    UserBookingsResp.fromJson(json.decode(str));

String userBookingsRespToJson(UserBookingsResp data) =>
    json.encode(data.toJson());

class UserBookingsResp {
  UserBookingsResp({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final List<UserBookingData> data;

  factory UserBookingsResp.fromJson(Map<String, dynamic> json) =>
      UserBookingsResp(
        status: json["status"] == "succeed",
        message: json["message"] ?? '',
        data:
            json["data"] == null
                ? []
                : List<UserBookingData>.from(
                  json["data"].map((x) => UserBookingData.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "status": status ? "succeed" : "failed",
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserBookingData {
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
  final DateTime lastDate;
  final String street;
  final String city;
  final String zipCode;
  // final int serviceId;
  // final int vendorId;

  // ✅ Constructor
  UserBookingData({
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
    required this.subcategoryName,
    required this.bookFor,
    required this.street,
    required this.city,
    required this.zipCode,
    required this.alternatePhone,
    required this.lastDate,
    // required this.serviceId,
    // required this.vendorId,
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
      // 'serviceId': serviceId,
      // 'vendorId': vendorId,
    };
  }

  // ✅ Parse from Map (from JSON)
  factory UserBookingData.fromJson(Map<String, dynamic> json) {
    return UserBookingData(
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
      street: json['street'],
      city: json['city'],
      zipCode: json['zipCode'],
      alternatePhone: json['alternatePhone'] as String?,
      lastDate: DateTime.parse(json['lastDate'] as String),
      // serviceId: json['serviceId'],
      // vendorId: json['vendorId'],
    );
  }
}
