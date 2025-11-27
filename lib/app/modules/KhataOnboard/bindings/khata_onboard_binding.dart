import 'package:get/get.dart';

import '../controllers/khata_onboard_controller.dart';

class KhataOnboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KhataOnboardController>(
      () => KhataOnboardController(),
    );
  }
}
