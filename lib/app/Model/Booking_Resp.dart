import 'dart:convert';

BookResp bookRespFromJson(String str) => BookResp.fromJson(json.decode(str));

String bookRespToJson(BookResp data) => json.encode(data.toJson());

class BookResp {
  BookResp({required this.status, required this.message, this.data});

  final bool status;
  final String message;
  final BookData? data;

  factory BookResp.fromJson(Map<String, dynamic> json) => BookResp(
    status: json["status"] == 'succeed',
    message: json["message"] ?? '',
    data: json["data"] != null ? BookData.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class BookData {
  BookData({required this.bookingId});

  final int bookingId;

  factory BookData.fromJson(Map<String, dynamic> json) =>
      BookData(bookingId: json["booking_id"]);

  Map<String, dynamic> toJson() => {"booking_id": bookingId};
}
