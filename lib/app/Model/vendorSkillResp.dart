import 'dart:convert';

VendorSkillResp vendorSkillRespFromJson(String str) =>
    VendorSkillResp.fromJson(json.decode(str));

String vendorSkillRespToJson(VendorSkillResp data) =>
    json.encode(data.toJson());

class VendorSkillResp {
  final bool status;
  final String message;
  final List<VendorSkill> data;

  VendorSkillResp({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VendorSkillResp.fromJson(Map<String, dynamic> json) {
    return VendorSkillResp(
      status: json["status"].toString().toLowerCase() == 'true',
      message: json["message"] as String,
      data:
          (json["data"] as List<dynamic>)
              .map((e) => VendorSkill.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {"status": status, "message": message, "data": jsonEncode(data)};
  }
}

class VendorSkill {
  final int vendorId;
  final int skillId;
  final String? skill;

  VendorSkill({
    required this.vendorId,
    required this.skillId,
    required this.skill,
  });

  factory VendorSkill.fromJson(Map<String, dynamic> json) {
    return VendorSkill(
      vendorId: int.parse(json["vendorId"].toString()),
      skillId: json['skillId'],
      skill: json["skills"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {"vendorId": vendorId, 'skillId': skillId, "skills": skill};
  }
}
