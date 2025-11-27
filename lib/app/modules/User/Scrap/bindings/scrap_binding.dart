import 'package:get/get.dart';

import '../controllers/scrap_controller.dart';

class ScrapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScrapController>(
      () => ScrapController(),
    );
  }
}
