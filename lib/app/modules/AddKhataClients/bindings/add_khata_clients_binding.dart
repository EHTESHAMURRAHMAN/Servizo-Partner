import 'package:get/get.dart';

import '../controllers/add_khata_clients_controller.dart';

class AddKhataClientsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddKhataClientsController>(
      () => AddKhataClientsController(),
    );
  }
}
