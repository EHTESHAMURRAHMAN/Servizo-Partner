import 'package:get/get.dart';

import '../controllers/khata_send_controller.dart';

class KhataSendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KhataSendController>(
      () => KhataSendController(),
    );
  }
}
