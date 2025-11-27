import 'package:get/get.dart';

import '../controllers/add_vender_service_controller.dart';

class AddVenderServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddVenderServiceController>(AddVenderServiceController());
  }
}
