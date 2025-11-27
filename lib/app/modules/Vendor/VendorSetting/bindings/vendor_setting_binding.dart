import 'package:get/get.dart';

import '../controllers/vendor_setting_controller.dart';

class VendorSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<VendorSettingController>(VendorSettingController());
  }
}
