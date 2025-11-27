import 'dart:convert';

VendorServiceResp vendorServiceRespFromJson(String str) =>
    VendorServiceResp.fromJson(json.decode(str));

String vendorServiceRespToJson(VendorServiceResp data) =>
    json.encode(data.toJson());

class VendorServiceResp {
  VendorServiceResp({required this.status, required this.message});

  final bool status;
  final String message;

  factory VendorServiceResp.fromJson(Map<String, dynamic> json) =>
      VendorServiceResp(
        status: json["status"] == 'succeed',
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
    "status": status ? 'succeed' : 'failed',
    "message": message,
  };
}

class VendorServiceData {
  VendorServiceData({required this.serviceId});

  final int serviceId;

  factory VendorServiceData.fromJson(Map<String, dynamic> json) =>
      VendorServiceData(serviceId: json["data"]);

  Map<String, dynamic> toJson() => {"data": serviceId};
}
