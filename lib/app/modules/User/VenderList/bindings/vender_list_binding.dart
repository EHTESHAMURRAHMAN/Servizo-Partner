import 'package:get/get.dart';

import '../controllers/vender_list_controller.dart';

class VenderListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<VenderListController>(VenderListController());
  }
}
