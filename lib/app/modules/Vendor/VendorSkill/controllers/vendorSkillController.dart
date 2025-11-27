import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../Model/vendorSkillResp.dart';

class VendorSkillController extends GetxController {
  List<VendorSkill> skillList =
      <VendorSkill>[
        VendorSkill(vendorId: 1, skillId: 1, skill: "Blueprint Reading"),
        VendorSkill(vendorId: 1, skillId: 1, skill: "Math & Measurement"),
        VendorSkill(vendorId: 1, skillId: 1, skill: "Tool Proficiency"),
        VendorSkill(vendorId: 1, skillId: 1, skill: "Joinery & Woodworking"),
        VendorSkill(vendorId: 1, skillId: 1, skill: "Material Knowledge"),
      ].obs;

  TextEditingController skillController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void addSkill(String newSkill) {}
}
