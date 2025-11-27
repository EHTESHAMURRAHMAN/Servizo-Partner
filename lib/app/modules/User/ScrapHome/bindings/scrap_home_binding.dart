import 'package:get/get.dart';

import '../controllers/scrap_home_controller.dart';

class ScrapHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScrapHomeController>(
      () => ScrapHomeController(),
    );
  }
}
