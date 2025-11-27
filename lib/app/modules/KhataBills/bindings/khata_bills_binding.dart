import 'package:get/get.dart';

import '../controllers/khata_bills_controller.dart';

class KhataBillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KhataBillsController>(
      () => KhataBillsController(),
    );
  }
}
