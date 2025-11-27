import 'package:get/get.dart';

import '../controllers/categorys_controller.dart';

class CategorysBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CategorysController>(CategorysController());
  }
}
