import 'dart:convert';

UploadResponse uploadResponseFromJson(String str) =>
    UploadResponse.fromJson(json.decode(str));

String uploadResponseToJson(UploadResponse data) => json.encode(data.toJson());

class UploadResponse {
  UploadResponse({
    required this.requestnumber,
    required this.status,
    required this.message,
  });

  final String requestnumber;
  final String status;
  final String message;

  factory UploadResponse.fromJson(Map<String, dynamic> json) => UploadResponse(
        requestnumber: json["requestnumber"] ?? '',
        status: json["status"],
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "requestnumber": requestnumber,
        "status": status,
        "message": message,
      };
}
