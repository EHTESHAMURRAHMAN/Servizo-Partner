import 'package:get/get.dart';
import 'package:servizo_vendor/app/modules/Vendor/VendorSkill/controllers/vendorSkillController.dart';

class VendorSkillBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorSkillController>(() => VendorSkillController());
  }
}
