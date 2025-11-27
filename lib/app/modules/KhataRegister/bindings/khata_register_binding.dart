import 'package:get/get.dart';

import '../controllers/khata_register_controller.dart';

class KhataRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KhataRegisterController>(
      () => KhataRegisterController(),
    );
  }
}
