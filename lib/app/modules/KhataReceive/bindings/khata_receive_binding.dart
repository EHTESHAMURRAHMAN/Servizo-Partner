import 'package:get/get.dart';

import '../controllers/khata_receive_controller.dart';

class KhataReceiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KhataReceiveController>(
      () => KhataReceiveController(),
    );
  }
}
