import 'dart:convert';

CommonResponse commonResponseFromJson(String str) =>
    CommonResponse.fromJson(json.decode(str));

String commonResponseToJson(CommonResponse data) => json.encode(data.toJson());

class CommonResponse {
  CommonResponse({
    required this.status,
    required this.message,
  });

  final bool status;
  final String message;

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
        status: json["status"] == 'succeed',
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
