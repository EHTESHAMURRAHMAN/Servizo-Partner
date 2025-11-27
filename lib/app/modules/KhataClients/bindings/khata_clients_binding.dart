import 'package:get/get.dart';

import '../controllers/khata_clients_controller.dart';

class KhataClientsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KhataClientsController>(
      () => KhataClientsController(),
    );
  }
}
