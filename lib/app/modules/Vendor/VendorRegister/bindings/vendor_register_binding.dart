import 'package:get/get.dart';

import '../controllers/vendor_register_controller.dart';

class VendorRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorRegisterController>(
      () => VendorRegisterController(),
    );
  }
}
