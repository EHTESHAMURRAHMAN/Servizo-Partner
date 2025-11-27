import 'package:get/get.dart';

import '../controllers/make_khata_bills_controller.dart';

class MakeKhataBillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MakeKhataBillsController>(
      () => MakeKhataBillsController(),
    );
  }
}
